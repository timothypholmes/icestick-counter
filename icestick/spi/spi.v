module SPI (input        sclk,  // slave clock
            input        mosi,  // master out, slave in
            input        ce0,   // clock enable
            output       miso,  // master in, slave out
            input  [7:0] data_outgoing,
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
   //assign data_incoming = counter(clock, receive, data_incoming);
   
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


//function counter (input clk,              // Declare input port for the clock to allow counter to count up  
//                 input rstn,             // Declare input port for the reset to allow the counter to be reset to 0 when required  
//                  output reg[7:0] count); // Declare 8-bit output port to get the counter values  

//   always @ (posedge clk) begin  
      if (! rstn)  
         count <= 0;  
      else  
         count <= count + 1;  
   end  

endfunction


//module correlation_function ()
   // Add later
//endmodule