warning = Wall
file1 = counter
file2 = counter_pigpio
library1 = lwiringPi
library2 = lpigpio

all: counter counter_pigpio

counter:
	gcc -$(warning) -o $(file1) $(file1).c -$(library1)

counter_pigpio:
	gcc -$(warning) -pthread -o $(file2) $(file2).c -$(library2) -lrt

clean:
	rm ./counter ./counter_pigpio