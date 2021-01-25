module SPI (//input        clk,   // fpga clock       
            input        sclk,  // slave clock
            input        mosi,  // master out, slave in
            input        ce0,   // clock enable
            output       miso,  // master in, slave out
            input [7:0]  data_outgoing,
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
   

module FIFO (input        reset,
             input [7:0]  wdata,
             input        we,
             input        wclk,
             output [7:0] rdata,
             input        re,
             input        rclk,
             output       empty,
             output       full
             );

   parameter state_nominal = 3'b001;
   parameter state_empty = 3'b010;
   parameter state_full = 3'b100;
   
   reg [2:0] state = state_nominal;
   reg [7:0] waddr = 8'b00000000;
   reg [7:0] raddr = 8'b00000000;

   RAM256x8 ram (
                 .wdata(wdata),
                 .waddr(waddr),
                 .wclk(wclk),
                 .wclke(1'b1),
                 .we(we),
                 .rdata(rdata),
                 .raddr(raddr),
                 .rclk(rclk),
                 .rclke(1'b1),
                 .re(re)
                 );
endmodule

   
module RAM256x8 (input [7:0] wdata,
                 input [7:0] waddr,
                 input wclk,
                 input wclke,
                 input we,
                 output [7:0] rdata,
                 input [7:0] raddr,
                 input rclk,
                 input rclke,
                 input re
                 );

   wire [15:0] mask = 16'b1111_1111_0000_0000;
      
   wire [15:0] data_in;
   wire [15:0] data_out;

   assign data_in = {8'b00000000, wdata};
   assign rdata = data_out[7:0];

   SB_RAM40_4K #(.WRITE_MODE(0), .READ_MODE(0)) 
   ram40_4kinst_physical (
                          .WDATA(data_in),
                          .WADDR({3'b000, waddr[7:0]}),
                          .WCLK(wclk),
                          .WCLKE(wclke),
                          .WE(we),
                          .MASK(mask),
                          .RDATA(data_out),
                          .RADDR({3'b000, raddr[7:0]}),
                          .RCLK(rclk),
                          .RCLKE(rclke),
                          .RE(re),
                          );

endmodule
