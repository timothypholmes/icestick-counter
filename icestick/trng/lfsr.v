/*
module LFSR(input n,
            input clk, 
            input reset, 
            output [n:0] q
           );

    reg [n:0] r_reg;
    wire [n:0] r_next;
    wire feedback_value;
                            
    always @(posedge clk, posedge reset)
    begin 
        if (reset)
            begin
            // set initial value to 1
            r_reg <= 1;  // use this or uncomment below two line
            
    //      r_reg[0] <= 1'b1; // 0th bit = 1
    //      r_reg[n:1] <= 0;  // other bits are zero
            
            
            end     
        else if (clk == 1'b1)
            r_reg <= r_next;
    end

    //// n = 3
    //// Feedback polynomial : x^3 + x^2 + 1
    ////total sequences (maximum) : 2^3 - 1 = 7
    assign feedback_value = r_reg[3] ^ r_reg[2] ^ r_reg[0];

    //// n = 4
    //assign feedback_value = r_reg[4] ^ r_reg[3] ^ r_reg[0];

    // n = 5, maximum length = 28 (not 31)
    //assign feedback_value = r_reg[5] ^ r_reg[3] ^ r_reg[0];

    //// n = 9
    //assign feedback_value = r_reg[9] ^ r_reg[5] ^ r_reg[0];


    assign r_next = {feedback_value, r_reg[n:1]};
    assign q = r_reg;
endmodule  

// Verilog built in number generator (for simulation)
module random(q); 
    //output [0:31] q; 
    //reg [0:31] q;

    output [7:0] q; 
    reg [7:0] q;
    
    initial
        r_seed = 2;
    always
        #10 q = $random(r_seed); 
endmodule

*/


module LFSR (input clock,
             input reset,
             output [12:0] rnd 
            );

	wire feedback = random[12] ^ random[3] ^ random[2] ^ random[0]; 

	reg [12:0] random, random_next, random_done;
	reg [3:0] count, count_next; //to keep track of the shifts

	always @ (posedge clock or posedge reset)
	begin
	if (reset)
		begin
		random <= 13'hF; //An LFSR cannot have an all 0 state, thus reset to FF
		count <= 0;
		end
	else
		begin
		random <= random_next;
		count <= count_next;
		end
	end

	always @ (*)
	begin
		random_next = random; //default state stays the same
		count_next = count;
	
		random_next = {random[11:0], feedback}; //shift left the xor'd every posedge clock
		count_next = count + 1;

		if (count == 13)
		begin
			count = 0;
			random_done = random; //assign the random number to output after 13 shifts
		end	
	end

	assign rnd = random_done;

endmodule



module fibonacci_lfsr (input  clk,
                       input  rst_n,
                       output [4:0] data
                      );

wire feedback = data[4] ^ data[1];

always @(posedge clk or negedge rst_n)
  if (~rst_n) 
    data <= 4'hf;
  else
    data <= {data[3:0], feedback} ;

endmodule


module Blink(input clk, output D5, output D1, output D2, output D3, output D4);

	// define a 24-bit counter to divide the clock down from 12MHz
	localparam WIDTH = 24;
	reg [WIDTH-1:0] counter;

	// run counter from 12MHz clock
	always @(posedge clk)
		counter <= counter + 1;

	// wire up the red LEDs to the counter MSB
	assign D1 = counter[WIDTH-1];

endmodule

module LFSR8_8E(reset_, clock, q, lfsr_to);
  input clock, reset_;
  output [63:0] q;
  output lfsr_to;
  
  reg [63:0] LFSR;
  wire  lfsr_to;
    
  assign lfsr_to = (LFSR == 64'h9C69832196724182);

  always @(posedge clock or negedge reset_)
  begin
    if (!reset_) 
      LFSR[63:0] <= 64'hffff_ffff_ffff_ffff;
    else if (lfsr_to) 
      LFSR[63:0] <= 64'hffff_ffff_ffff_ffff;
    else
    begin
      LFSR[63:0] <= {(LFSR[62]^LFSR[61]),
                     (LFSR[61]^LFSR[60]),
                     (LFSR[60]^LFSR[59]),
                     (LFSR[59]^LFSR[58]),
                     LFSR[58:0],
                     LFSR[63]};
    end
  end
  
  assign q = LFSR;
endmodule

module fibonacci_lfsr_nbit
   (
    input             BITS,
    input             clk,
    input             rst_n,
    output reg [4:0] data
    );

   reg [4:0] data_next;
   always_comb begin
      data_next = data;
      repeat(BITS) begin
         data_next = {(data_next[4]^data_next[1]), data_next[4:1]};
      end
   end

   always_ff @(posedge clk or negedge reset) begin
      if(!rst_n)
         data <= 5'h1f;
      else
         data <= data_next;
      end
   end

endmodule