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