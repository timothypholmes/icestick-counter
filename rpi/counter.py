import pigpio
import time
from bitarray import bitarray
from bitarray.util import ba2int

#sudo pigpiod -p 8889

CS   = 2
MISO = 19
MOSI = 21
SCLK = 23
MODE = 0

pi = pigpio.pi()
#pi.spi_close(CS)  # because I use ctrl-C to break each time
pi.spi_close(CS) 
h = pi.spi_open(0, 1000000, 3)


sum_val = 0
#print(int(sum_val, 16))
while True:

    (count, rx_data) = pi.spi_xfer(h, hex(sum_val))
    '''
    out = 0
    for bit in rx_data:
        out = (out << 1) | bit
    '''
    i = ba2int(rx_data)
    sum_val += i
    print(sum_val)


    '''
    pi.spi_write(0, sum_val)
    (b, d) = pi.spi_read(h, 60)
    if b == 60:
        print(d)
        i = 0
        for bit in d:
            i = (i << 1) | bit
        print(i)
        sum_val += i
        print(sum_val)
    else:
        print('error')
    '''

    #print(rx_data)
    #sum_val += int(rx_data)
    #print(sum_val)
    time.sleep(1)