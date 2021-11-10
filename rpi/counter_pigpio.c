#include <stdio.h>
#include <stdlib.h>
#include <pigpio.h>
#include <ctype.h>
#include <unistd.h>
#include <getopt.h>
#include<time.h>

// global variables
#define LOOPS 500000

#define READ_BIT  0x80
#define MULTI_BIT 0x40

#define BW_RATE     0x2C
#define POWER_CTL   0x2D
#define DATA_FORMAT 0x31
#define DATAX0      0x32

/*

*/
int read_bytes(int handle, char *data, int count) {
	data[0] |= READ_BIT;
	if (count > 1) data[0] |= MULTI_BIT;
		return spiXfer(handle, data, data, count);
}

int write_bytes(int handle, char *data, int count) {
	if (count > 1) data[0] |= MULTI_BIT;
		return spiWrite(handle, data, count);
}

int main (int argc, char **argv) {

	// other values
	char test_data[1];

	// Default values 
	int fd;
	int bytes;
	int delay_flag = 0;
	int c;

	opterr = 0;
	while ((c = getopt (argc, argv, "f:d")) != -1)
	switch (c)
		{
		case 'f':
		fd = optarg;
		break;
		case 'd':
		delay_flag = 1;
		break;
		case '?':
		if (optopt == 'c')
			fprintf (stderr, "Option -%c requires an argument.\n", optopt);
		else if (isprint (optopt))
			fprintf (stderr, "Unknown option `-%c'.\n", optopt);
		else
			fprintf (stderr,
					"Unknown option character `\\x%x'.\n",
					optopt);
		return 1;
		default:
		abort ();
		}

	// Initialise the library
	if (gpioInitialise() < 0) {
	printf("pigpio initialisation failed.");
	exit(1);
	} else {
	printf("pigpio initialised okay.");
	}

	fd = spiOpen(0, 1000000, 3);

	char a[1];
	int count=1;
	while(count <= 10000) {
    	a[1] = spiXfer(fd, 0x0800, 0x0000, 1);
		printf(a[1]);
		count++;
	}

  /*
  int h = spiOpen(0, 2000000, 3);
  

  for (int i = 0; i < 1000; i++) {

    //test_data[0] = send_data(test_data, i);
    //test_data[0] = i;
    write_bytes(h, test_data, 2);
    bytes = read_bytes(h, test_data, 1);

    printf("%i", bytes);
    
    if (delay_flag == 1) {
      sleep(1);
    }
  }
  */

  /*
  char data[7];
  int16_t x, y, z, lx, ly, lz;
  int bytes;
  double start, duration;

  int h = spiOpen(0, 2000000, 3);

  data[0] = BW_RATE;
  data[1] = 0x0F;
  write_bytes(h, data, 2);

  data[0] = DATA_FORMAT;
  data[1] = 0x01;
  write_bytes(h, data, 2);

  data[0] = POWER_CTL;
  data[1] = 0x08;
  write_bytes(h, data, 2);

  lx = 0;
  ly = 0;
  lz = 0;

  start = time_time();

  for (int i = 0; i <LOOPS ; i++) {

    if (delay_flag == 1) {
      sleep(1);
    }

    data[0] = DATAX0;
    bytes = read_bytes(h, data, 7);


    if (bytes == 7) {
      x = (data[2]<<8)|data[1];
      y = (data[4]<<8)|data[3];
      z = (data[6]<<8)|data[5];

      if ((abs(x-lx) > 30) || (abs(y-ly) > 30) || (abs(z-lz) > 30)) {
        printf("x=%d y=%d z=%d\n", x, y, z);

        lx = x;
        ly = y;
        lz = z;
      }
    } else {
      printf("spiXfer error (%d)\n", bytes);
    }
  }

  duration = time_time() - start;

  printf("%d loops in %.2f seconds (%.1f sps)\n",
    LOOPS, duration, LOOPS/duration);
  */
  
  // Terminate process to release memory and running treads
	gpioTerminate();
	return 0;
}