module main (input clk,
             output D1,
             output D2,
             output D3,
             output D4,
             output D5,
             );

	// Inputs
	//reg clock;
	reg reset;

	// Outputs
	wire [12:0] rnd;

	LFSR u1(.clock(clk), 
  			.reset(reset), 
  			.rnd(rnd)
		   );

	assign {D1, D2, D3, D4, D5} = rnd;

	initial begin
	clock = 0;
	forever
	#50 clock = ~clock;
	end
  
	initial begin
	// Initialize Inputs
  	reset = 0;

	// Wait 100 ns for global reset to finish
	#100;
		reset = 1;
	#200;
	reset = 0;
	// Add stimulus here

	end
 
	//initial begin
		//$display("clock rnd");
		//$monitor("%b,%b", clock, rnd);
	//end  

	/*
	localparam BITS = 5;
	localparam LOG2DELAY = 20;//25;

	reg [BITS + LOG2DELAY - 1:0] counter = 0;
	reg [BITS - 1:0] outcnt;

	always @(posedge clk) begin
		counter <= counter + 1;
		outcnt <= counter >> LOG2DELAY;
	end

	assign {D1, D2, D3, D4, D5} = outcnt ^ (outcnt >> 1);
	*/
   
endmodule