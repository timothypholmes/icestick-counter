# icestick-counter

## Table of Contents
 * [About](#About)
 * [Setup](#Setup)
    * [Moving files to pi](#Moving-files-to-pi)
    * [Turning on SPI](#Turning-on-SPI)
 * [Demo](#Demo)
 * [Links](#Links)
 * [Task list](#Task-list)


## About

## Setup

### Moving files to pi

Moving the files from this repo to the rpi is easy. A file named `setup.sh` has been setup
to automatically move the files into the home directory of the rpi. By running `./setup.sh`
the script will print out all of the use cases. This program can be setup by using the 
following

```
./setup.sh -u USERNAME -a 192.168.1.0 
```

This will copy the files over and generate a file named `pi_connect.sh`. Each time there
is a  need to connect to rpi, running the script `./pi_connect.sh` will automatically connect
to the rpi and change directory to the project.

### Turning on SPI

To check to see if SPI is enables alread run:

```
lsmod | grep spi_
```

First check to see if there are any 
```
sudo apt-get update
sudo apt-get upgrade
```

Edit the system file by:

```
sudo nano /boot/config.txt 
```

or

```
sudo vim /boot/config.txt 
```


Find the line `dtparam=spi=` and change it to:
```
dtparam=spi=on
```

If `dtparam=spi=` doesn't exist, add it at the bottom. Reboot the device to 
reflect the new change:

```
sudo reboot
```

### Hardware setup

![alt text](https://github.com/timothypholmes/icestick-counter/blob/main/.wires.png)

The icestick pins that are used are shown below.

```
     ----------
    | 3V3  3V3 |
    | GND  GND |
    | 91    81 |
    | 90    80 |              
    | 88    79 |              
    | 87    78 | <            
     ----------   
```

The Raspberry-pi has will display pinouts using the command `pinout`. This is shown below as well.

```
   3V3  (1) (2)  5V    
 GPIO2  (3) (4)  5V    
 GPIO3  (5) (6)  GND   
 GPIO4  (7) (8)  GPIO14
   GND  (9) (10) GPIO15
GPIO17 (11) (12) GPIO18
GPIO27 (13) (14) GND   
GPIO22 (15) (16) GPIO23
   3V3 (17) (18) GPIO24
GPIO10 (19) (20) GND   
 GPIO9 (21) (22) GPIO25
GPIO11 (23) (24) GPIO8 
   GND (25) (26) GPIO7 
 GPIO0 (27) (28) GPIO1 
 GPIO5 (29) (30) GND   
 GPIO6 (31) (32) GPIO12
GPIO13 (33) (34) GND   
GPIO19 (35) (36) GPIO16
GPIO26 (37) (38) GPIO20
   GND (39) (40) GPIO21
```

The following pins are used on the icestick

```
MOSI -> Pin 88 -> GPIO Pin (19)
MISO -> Pin 90 -> GPIO Pin (21)
SCLK -> Pin 91 -> GPIO Pin (23)
CE0  -> Pin 81 -> GPIO Pin (24)
```

### Compiling Icestick

Within the repo change directories on the machine that the icestick is connected to:

```
cd ./icestick
```

run the command `make upload` and now the icestick is ready!


### Running count program

Within the repo change directories on the raspberry-pi to:

```
cd ./rpi
```

run the command `make`, this will compile the programe with the appropriate library. Then
run `./counter` to start the program.


## Demo

Within the repo

`cd rpi`

and run the command

`./counter`

## Links

[ice-stick-getting-started](http://www.clifford.at/icestorm/)

[ice-tutorial](https://mjoldfield.com/atelier/2018/02/ice40-blinky-icestick.html)
[ice-examples](https://github.com/nesl/ice40_examples)
[Pin-map](https://github.com/Obijuan/open-fpga-verilog-tutorial/blob/master/tutorial/doc/images/icestick_pinout.png)

## Task list

- [x] Setup a README.md
- [x] Setup a Demo