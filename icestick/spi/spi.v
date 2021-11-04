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


module counter (input rst, 
                input clk, 
                input cet, 
                input cep, 
                output [size-1:0] count, 
                output tc);


   parameter size = 5;
   parameter length = 20;

   reg [size - 1:0] count; 

   wire tc; 

   always @ (posedge clk or posedge rst)
   if (rst) 
      count <= {size{1'b0}};
   else
   if (cet && cep) // Enables both  true
      begin
         if (count == length - 1)
            count <= {size{1'b0}};
         else
            count <= count + 1'b1;
      end

   assign tc = (cet && (count == length - 1));

endmodule

module total_count ()

endmodule

module correlation_function ()

endmodule