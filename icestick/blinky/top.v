module main (input wire clk,				// 12MHZ clock
             output wire D1,
             output wire D2,
             output wire D3,
             output wire D4,
             output wire D5
	        );

    reg [24:0] counter = 0;

	// Drive the LEDs from the MSBs of the counter
    assign D1 = counter[20];		// divide by 2MHZ
    assign D2 = counter[21];		// divide by 4MHZ
    assign D3 = counter[22];		// divide by 8MHZ
    assign D4 = counter[23];		// divide by 16MHZ
    //assign D5 = counter[24];		// divide by 32MHZ

	// Add 1 to the counter on each rising edge of the clk input signal
    always @ (posedge clk) 
	begin
        counter <= counter + 1;
    end

endmodule