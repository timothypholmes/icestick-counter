module main (input clk,
             output D1,
             output D2,
             output D3,
             output D4,
             output D5,
             );

   //wire ssig;
   //wire [7:0] data_incoming;
   //reg [7:0] data_outgoing = 8'b0001111;

   /*
   parameter N = 3;
   parameter reset = 0;
   wire [N:0] Q;

   LFSR lfsr(.n(N),
             .clk(clk),
             .q(Q),
             .reset(reset),
            );

   assign D1 = Q[0];
   assign D2 = Q[1];
   assign D3 = Q[2];
   assign D4 = Q[3];
   assign D5 = Q[5];
   */
   /*
   initial begin
      clk = 1'b0;
      RST_N = 1'b0;
      # 10;
      RST_N = 1'b1;
    end
    always begin
        #20 clk <= ~clk;
    end
   */

   //reg clk;
   /*
   reg reset_n;
  
   wire [63:0] lfsr_var;
   wire DATA;

   initial
      begin
            reset_n = 1'b1;
            clk = 1'b1;
      #10   reset_n = 1'b0;
      #10   reset_n = 1'b1;
      //#10000 $finish;
      end

   //always #1 clk = ~clk;

   // subcomponent subcomponent_instance_name
   
   fibonacci_lfsr lfsr(// input
                       .clk(clk), 
                       .rst_n(reset_n), 
                       // output
                       .data(DATA)
                      );
   
   LFSR8_8E lfsr(
    .clock(clk),
    .reset_(reset_n),
    .q(lfsr_var),
    .lfsr_to(lfsr_to)
   );
  */

  parameter BITS = 5;
   wire [5:0] lfsr_var;
   wire DATA;

   initial
      begin
            reset_n = 1'b1;
            clk = 1'b1;
      #10   reset_n = 1'b0;
      #10   reset_n = 1'b1;
      //#10000 $finish;
      end

   fibonacci_lfsr_nbit lfsr(
      .BITS(BITS),
      .clk(clk),
      .rst_n(reset_n),
      .data(DATA)
   );

   
  
   assign D1 = DATA[0];
   assign D2 = DATA[1];
   assign D3 = DATA[2];
   assign D4 = DATA[3];
   assign D5 = DATA[4];


   //always @(posedge clk) begin
   //   Q <= Q + 4;
   //end
   
endmodule