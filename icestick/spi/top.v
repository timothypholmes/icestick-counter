module main(input clk,
            input SCLK,
            input MOSI,
            input CE0,
            output MISO,
            output D1,
            output D2,
            output D3,
            output D4,
            output D5,
            );

   //wire ssig;
   wire [7:0] data_incoming;
   reg [7:0] data_outgoing = 8'b0001111;//8'b00000000;//8'b0001111;

   // call spi function
   SPI u1(.sclk(SCLK),
           .mosi(MOSI),
           .ce0(CE0),
           .data_outgoing(data_outgoing),
           .miso(MISO),
           .data_incoming(data_incoming),
          );

   assign D1 = data_incoming[0];
   assign D2 = data_incoming[1];
   assign D3 = data_incoming[2];
   assign D4 = data_incoming[3];
   assign D5 = data_incoming[5];

   //reg [24:0] ncount = 0;

   // call counter function
   /*
   counter u2(// input
               .clk(clk),
               .data_incoming(data_incoming),
               //.ncount(ncount),
               // output
               .ncount(ncount),
               );
   */
   always @(posedge clk) begin
      data_outgoing <= data_incoming + 4;
      //data_outgoing = ncount;
   end
   
endmodule