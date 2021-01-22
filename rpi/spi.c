#include <stdio.h>
#include <wiringPiSPI.h>
#include <wiringPi.h>

int main (void)
{
  wiringPiSetup ();

  int fd;
  if( (fd = wiringPiSPISetup(0, 500000)) == -1 ){
    fprintf(stderr, "ERROR: could not setup spi interface\n");
    return -1;
  }
  printf("initialized the driver: fd=%i\n", fd);

  int i;
  unsigned char data[1];
  for( i = 0; i < 100000; i++ ){

    data[0] = i % 16;
    
    //system("gpio edge 0 falling"
    fprintf(stderr, "sending %u\n", data[0]);
    if( wiringPiSPIDataRW(0, data, 1) == -1 ){
      fprintf(stderr, "ERROR: data transfer error\n");
      return -1;    
    }
    //printf("received %u\n", data[0]);
    delay(1000);
  }
  
  printf("received the buffer: %s\n", (char*) data);
  
  return 0;
}