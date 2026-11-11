# Sound Card Detection
(sample)

The program checks ports from 200h to 290h in increments of 10h. For each port, it reads from ports port + 06h and port + 0Ah then checks whether the last value read is equal to AAh. If it is, the sound card is considered detected and the search stops.

The algorithm in simple terms:

1. Assume that no sound card has been found (the default).

2. Set the first address to check to 0x200.

3. For the current address

  3.1. Write the value 1 to the port at "current address + 0x6";

  3.2. Read the value from the port at "current address + 0x6" 4 times;

  3.3. Write 0 to this port;

  3.4. Read the value from the port at "current address + 0xA" 100 times;

  3.5. Compare the last value read with 0xAA.

5. If the last value is equal to 0xAA, consider the sound card found and stop searching.

6. If the value is not equal to 0xAA, move to the next address by adding 0x10. If all addresses have been checked and the value 0xAA has not been found, display a message stating that no sound card was found.

7. If the card is found, display the address where it was detected.

The program is written in QBasic, ver. 1.0.

Source code encoding: CP866.

---

# Поиск звуковой карты
(образцовая программа)

Программа проверяет порты от 200h до 290h с шагом 10h. Для каждого порта она выполняет чтения из портов port + 06h и port + 0Ah, а затем проверяет, равно ли последнее считанное значение AAh. Если равно - карта считается найденной, и поиск прекращается.

Алгоритм простыми словами:
1. Считать, что звуковая карта не найдена (по умолчанию).

2. Взять первый проверяемый адрес - 0x200.

3. Для текущего адреса:

  3.1. Записать значение 1 по адресу "текущий адрес + 0x6";

  3.2. 4 раза прочитать значение из порта, расположенного по адресу "текущий адрес + 0x6";

  3.3. Записать 0 в этот порт;

  3.4. 100 раз прочитать значение из порта "текущий адрес + 0xA";

  3.5. Сравнить последнее прочитанное значение с 0xAA.

4. Если последнее значение равно 0xAA, считать карту найденной и прекратить перебор.

5. Если значение не равно 0xAA, перейти к следующему адресу, прибавив 0x10. Если проверены все адреса, а значение 0xAA не обнаружено, вывести сообщение, что звуковая карта не найдена.

6. Если карта найдена, вывести адрес, что она обнаружена.

Программа написана на языке программирования QBasic, ver. 1.0.

Кодировка исходного кода: CP866.

