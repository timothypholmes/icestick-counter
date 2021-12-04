module main (// input
             input clk,
             input SCLK,
             input MOSI,
             input CE0,
             input CE1,
             // output
             output MISO,
             output D1,
             output D2,
             output D3,
             output D4,
             output D5,
            );

    // call spi function
    spi u1 (// input
            .MOSI(MOSI),
            .SCLK(SCLK),
            .CE0(CE0),
            .CE1(CE1),
            .clk(clk),
            // output
            .MISO(MISO),
          );


   //assign D1 = MISO[0];
   //assign D2 = MISO[1];
   //assign D3 = MISO[2];
   //assign D4 = MISO[3];
   //assign D5 = MISO[5];

   //wire [7:0] incount;
   //wire [7:0] outcount;

   // call counter function
   /*
   counter u2(// input
               .clk(clk),
               .data_incoming(data_incoming),
               .incount(ncount),
               // output
               .outcount(ncount),
               );
   */
   //always @(posedge clk) begin
   //   //data_outgoing <= data_incoming + 4;
   //   data_outgoing <= outcount;
   //end
endmodule