//#include <stdio.h>
#include <system.h>
#include <altera_avalon_pio_regs.h>
//#include <math.h>


int main()
{

	while(1)
	{

  unsigned int done = 1;

  IOWR_ALTERA_AVALON_PIO_DATA(DONE_PIO_BASE, done);



  unsigned int start = IORD_ALTERA_AVALON_PIO_DATA(START_PIO_BASE);



  if(start==1)

  {
  unsigned int input=IORD_ALTERA_AVALON_PIO_DATA(X_PIO_BASE);

  float x=*(float*)&input;

  done=0;


  IOWR_ALTERA_AVALON_PIO_DATA(DONE_PIO_BASE, done);




  float y= x-((x*x)/2.0f)+((x*x*x)/3.0f)-((x*x*x*x)/4);




  unsigned int data_to_write=*(int*)&y;


  IOWR_ALTERA_AVALON_PIO_DATA(RESULT_PIO_BASE, data_to_write);


  }
	}

  return 0;
}




