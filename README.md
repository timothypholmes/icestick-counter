# icestick-counter

## Table of Contents
 * [About](#About)
 * [Setup](#Setup)
    * [Moving files to pi](#Moving-files-to-pi)
 * [Demo](#Demo)
 * [Links](#Links)
 * [Task list](#Task-list)

<details>
<summary>"Click to expand"</summary>
More to come ...
</details>

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

## Demo

## Links

## Task list

- [x] Setup a README.md