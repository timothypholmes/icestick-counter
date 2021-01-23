# icestick-counter

## Table of Contents
 * [About](#About)
 * [Setup](#Setup)
    * [Moving files to pi](#Moving-files-to-pi)
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

### Hardware setup

## Demo

## Links

[ice-stick-getting-started](http://www.clifford.at/icestorm/)

[ice-tutorial](https://mjoldfield.com/atelier/2018/02/ice40-blinky-icestick.html)
[ice-examples](https://github.com/nesl/ice40_examples)
[Pin-map](https://github.com/Obijuan/open-fpga-verilog-tutorial/blob/master/tutorial/doc/images/icestick_pinout.png)

## Task list

- [x] Setup a README.md