module main (input clk,
             output D1,
             output D2,
             output D3,
             output D4,
             output D5,
             );

	localparam BITS = 5;
	localparam LOG2DELAY = 1;//25;

	reg [BITS + LOG2DELAY - 1:0] counter = 0;
	reg [BITS - 1:0] outcnt;

	always @(posedge clk) begin
		counter <= counter + 1;
		outcnt <= counter >> LOG2DELAY;
	end

	assign {D1, D2, D3, D4, D5} = outcnt ^ (outcnt >> 1);
   
endmodule