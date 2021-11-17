//
module spi (// input
            input        sclk,  // slave clock
            input        mosi,  // master out, slave in
            input        ce0,   // clock enable
            input  [7:0] data_outgoing,
            // output
            output       miso,  // master in, slave out
            output [7:0] data_incoming
           );

   reg [1:0] count = 2'b00;
   reg [7:0] send;
   reg [7:0] receive;
   reg [7:0] receive_buffer;
   
   reg latch_data = 0;   
   wire clock = sclk | latch_data;

   assign miso = send[index];
   assign data_incoming = receive;
   
   always @(negedge ce0) begin      
      latch_data <= 0;
      send <= data_outgoing;
   end
   
   always @(posedge ce0) begin
      latch_data <= 1;
      receive <= receive_buffer;
   end

   reg [2:0] index = 3'b111;
   always @(posedge clock) begin
      if(latch_data == 0) begin
         receive_buffer <= {receive_buffer[6:0], mosi};
         index <= index - 1;
      end
      else begin
        index <= 3'b111;
      end
   end

endmodule

// XX bit counter function 

module counter (// input
                input         clk,
                input  [7:0]  data_incoming,
                input  [7:0] incount,
                // output
                output [7:0] outcount
               );

   always @ (posedge clk) 
	begin
        outcount <= data_incoming + 1;
   end

endmodule

module correlation_function (// input

                             // output
                            );
   // add functiona later
endmodule
