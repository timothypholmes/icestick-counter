warning = Wall
library = lwiringPi

all:
	#gcc -$(warning) -o counter counter.c -$(library)
	gcc -$(warning) -pthread -o counter_pigpio counter_pigpio.c -lpigpio -lrt
clean:
	#rm ./counter
	rm ./counter_pigpio