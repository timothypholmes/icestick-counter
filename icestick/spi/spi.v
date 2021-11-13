//
module SPI(input        sclk,  // slave clock
           input        mosi,  // master out, slave in
           input        ce0,   // clock enable
           input  [7:0] data_outgoing,
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
/*
module counter(// input
               input         clk,
               input  [7:0]  data_incoming,
               //input  [24:0] ncount,
               // output
               output [24:0] ncount
               );

   reg [7:0] send;   
   reg [7:0] receive;
   assign data_incoming = receive;

   always @ (posedge clk) 
	begin
        send <= ncount + receive + 1;
   end

endmodule
*/


/*
   Failed functionality 
*/
// 32 bit counter
/*
module counter(input clk,
               output xcount,
              );



   
    always @( posedge clk or posedge PMOD4)
    begin : the_code__posedge_clk_active_high_PMOD4__code
        if (PMOD4==1'b1)
        begin
            xcount <= 32'h0;
        end
        else
        begin
            xcount <= (xcount+32'h1);
        end //if
    end //always

endmodule
*/

//function counter (input clk,              // Declare input port for the clock to allow counter to count up  
//                 input rstn,             // Declare input port for the reset to allow the counter to be reset to 0 when required  
//                  output reg[7:0] count); // Declare 8-bit output port to get the counter values  

//   always @ (posedge clk) begin  
//      if (! rstn)  
//         count <= 0;  
//      else  
//         count <= count + 1;  
//   end  

//endfunction

/*
module correlation_function ()
   Add later
endmodule
*/