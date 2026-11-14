REM Звуковая карта типа Sound Blaster(R)
CONST t# = 1193181 / 65536, d! = .003, t1! = .048
' d! - время задержки (в секундах)
' t1! - время ожидания готовности устройства (в секундах)
' t# - коэффициент преобразования времени в машинные тики для кварцевого генератора

DIM sb%(6), datum%(6)
' sb% - список всех устройств типа Sound Blaster(R)
' datum% - байт данных для каждого из устройств типа Sound Blaster(R)

CLS

GOSUB 4: ' ищем все устройства типа Sound Blaster(R)

GOSUB 6: ' включаем звук

WHILE NOT INKEY$ = CHR$(27)
GOSUB 9: FOR x% = 0 TO 6: PRINT datum%(x%), : NEXT x%: PRINT : PRINT
WEND

GOSUB 7: ' выключаем звук

END

' посылка данных в ЦАП для Sound Blaster(R)
8 FOR x% = 0 TO 6: LET byte% = &H10: GOSUB 3
LET byte% = datum%(x%): GOSUB 3: ' datum% - байт данных для ЦАП
NEXT x%: RETURN

' включение звука на Sound Blaster(R)
6 FOR x% = 0 TO 6: LET byte% = &HD1: GOSUB 3: NEXT x%: RETURN

' выключение звука на Sound Blaster(R)
7 FOR x% = 0 TO 6: LET byte% = &HD3: GOSUB 3: NEXT x%: RETURN

' запись в DSP
3 IF sb%(x%) = -1 THEN
LET port% = &H10 * (x% + &H20)
LET z% = 0: WHILE (INP(port% + &HC) AND 128) = 0: GOSUB 1: LET z% = z% + 1
IF z% >= t1! * t# THEN LET sb%(x%) = 0: GOTO 5: ' сбой в устройстве, и оно не работает
WEND
OUT port% + &HC, byte%: ' байт данных, который надо записать в DSP
END IF
5 RETURN

' чтение из DSP
9 FOR x% = 0 TO 6
IF sb%(x%) = -1 THEN
LET port% = &H10 * (x% + &H20)
LET z% = 0: WHILE (INP(port% + &HE) AND 128) = 1: GOSUB 1: LET z% = z% + 1
IF z% >= t1! * t# THEN LET sb%(x%) = 0: GOTO 10: ' сбой в устройстве, и оно не работает
WEND
LET datum%(x%) = INP(port% + &HA)
END IF
10 NEXT x%: RETURN

' поиск всех звуковых карт типа Sound Blaster(R)
' (в элементах массива sb% значение -1 означает, что SB с данным адресом есть)
' (базовые адреса: от 200h до 260h)
4 FOR x% = 0 TO 6: LET sb%(x%) = 0: NEXT x%
FOR port% = &H200 TO &H260 STEP &H10
' сброс DSP
LET f% = 0: OUT port% + 6, 1
FOR x% = 1 TO d! * t#
GOSUB 1: NEXT x%
OUT port% + 6, 0
LET x% = 0: WHILE (INP(port% + &HE) AND 128) = 1: GOSUB 1: LET x% = x% + 1
IF x% >= t1! * t# THEN LET f% = -1: GOTO 2
WEND
LET x% = 0: WHILE INP(port% + &HA) <> &HAA: GOSUB 1: LET x% = x% + 1
IF x% >= t1! * t# THEN LET f% = -1: GOTO 2
WEND
2 IF f% = 0 THEN LET sb%(port% \ &H10 - &H20) = -1
NEXT port%: RETURN

1 DEF SEG = 0: LET y% = PEEK(&H46C): WHILE PEEK(&H46C) = y%: WEND: RETURN