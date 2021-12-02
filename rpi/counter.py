import pigpio
import time
from bitarray import bitarray
from bitarray.util import ba2int
import time
import spidev

'''
spi_speed_hz = 2500000
spi_delay_us = 0

spi = spidev.SpiDev()
spi.open(0, 0)
spi.mode = 0b11  # set mode: pol 1 pha 1
spi.max_speed_hz = 25000000  # maximum speed of 25MHz
spi.no_cs = True  # disable chip selects

msg = b'\x07\x00'
resp = spi.xfer3(msg, spi_speed_hz, spi_delay_us)
spi.close()

print("Raw sent: {}".format(msg))
print("Raw response: {}".format(resp))

print("Sent {}".format(bin(msg[0])))
print("Received {}".format(bin(resp[-1])))
'''

#sudo pigpiod -p 8888

CS   = 2
MISO = 19
MOSI = 21
SCLK = 23
MODE = 0

pi = pigpio.pi()
#pi.spi_close(CS)  # because I use ctrl-C to break each time
#pi.spi_close(CS) 
#h = pi.spi_open(0, 1000000, 3)
handle = pi.spi_open(0, 50000, 3)

sum_val = 0
#print(int(sum_val, 16))
start_val = 1                                                         
while True:

    (count, rx_data) = pi.spi_xfer(handle, hex(1))
    
    #out = 0
    #for bit in rx_data:
    #    out = (out << 1) | bit
    
    #i = ba2int(rx_data)
    #sum_val += out
    print(count)
    print(rx_data)
    print(int.from_bytes(rx_data, byteorder='big', signed=False))
    #print(ba2int(rx_data))


    
    #pi.spi_write(0, sum_val)
    #(b, d) = pi.spi_read(h, 60)
    #if b == 60:
    #    print(d)
    #    i = 0
    #    for bit in d:
    #        i = (i << 1) | bit
    #    print(i)
    #    sum_val += i
    #    print(sum_val)
    #else:
    #    print('error')
    

    #print(rx_data)
    #sum_val += int(rx_data)
    #print(sum_val)
    time.sleep(0.75)
