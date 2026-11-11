REM Поиск звуковой карты
' (образцовая программа)
'
' * *************************
' * Программа написана на языке программирования QBasic, ver. 1.0.
' *
' * @author Ефремов А. В., 11.11.2026
'

DIM port AS INTEGER, cnt AS INTEGER, al AS INTEGER
DIM isFound AS INTEGER
LET isFound = 0: ' признак "карта не найдена" (по умолчанию)
FOR port = &H200 TO &H290 STEP &H10
  OUT port + &H6, 1
  FOR cnt = 1 TO 4: LET al = INP(port + &H6): NEXT cnt
  OUT port + &H6, 0
  FOR cnt = 1 TO 100: LET al = INP(port + &HA): NEXT cnt
  IF al = &HAA THEN
    LET isFound = 1: ' признак "карта найдена"
    EXIT FOR
  END IF
NEXT port
IF isFound = 0 THEN
  PRINT "Звуковая карта не найдена."
ELSE
  PRINT "Звуковая карта подключена к порту " + HEX$(port) + "h."
END IF
END
