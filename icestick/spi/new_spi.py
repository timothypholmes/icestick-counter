#sudo pigpiod -p 8888

import pigpio
import time
import sys

pi = pigpio.pi()
if not pi.connected:
    print("pigpio fail on open")
    exit(0)

eeprom = pi.spi_open(0, 32000, 0) # open spi0.0 @ 32k

print("eeprom: " + str(eeprom))

pi.spi_write(0, b'\x06') # write latch enable

time.sleep(0.001) # allow CE to toggle

pi.spi_write(0, b'\x02')         # actual write command
pi.spi_write(0, b'\x00\x00\x00') # address
pi.spi_write(0, b'\xCC')         # easily identifiable data

pi.spi_close(eeprom)
pi.stop()
