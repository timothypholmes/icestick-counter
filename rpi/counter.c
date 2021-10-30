#include <stdio.h>
#include <wiringPiSPI.h>
#include <wiringPi.h>
#include <ctype.h>
#include <stdlib.h>
#include <unistd.h>
/*

*/
int incoming_data_sum (unsigned char data) {

  //long int sum;
  //sum += data;
  //fprintf(stderr, "Sum: %lu\n", sum);

  return 0;
}

/*

*/
int send_data (unsigned char data[], int i) {

  data[0] = i % 16;
  fprintf(stderr, "Sent: %u\n", data[0]);

  return data[0];
}

/*

*/
int receive_data (unsigned char data) {

  printf("received: %u\n", data);
  
  return 0;
}

/*

*/
int main (int argc, char **argv) {
  wiringPiSetup ();

  // other values
  unsigned char data[1];

  // Default values 
  int fd;
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

  if ((fd = wiringPiSPISetup(0, 500000)) == -1 ){
    fprintf(stderr, "Error: setup failed.\n");
    return -1;
  }
  printf("Driver: fd=%i\n", fd);

  for (int i = 0; i < 1000; i++) {

    data[0] = send_data(data, i);
    incoming_data_sum(data[0]);
    if ( wiringPiSPIDataRW(0, data, 1) == -1 ) {
      fprintf(stderr, "Error: killing process.\n");
      return -1;    
    }

    //receive_data(data[0]);
    
    if (delay_flag == 1) {
      delay(1000);
    }
  }
  
  return 0;
}