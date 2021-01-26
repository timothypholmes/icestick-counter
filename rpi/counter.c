#include <stdio.h>
#include <wiringPiSPI.h>
#include <wiringPi.h>


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
int main (void) {
  wiringPiSetup ();

  int fd;
  unsigned char data[1];

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
    delay(1000);

  }
  
  return 0;
}