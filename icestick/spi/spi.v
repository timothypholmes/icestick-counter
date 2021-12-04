//
module spi (// input
			input MOSI,
			input SCLK,
			input CE0,
			input CE1,
    		input clk,
			// output
			output MISO,
		   );

    // setup internal 48MHz oscillator
    wire clk;

	// store data in registers
    reg [7:0] read_data = 0;
	reg [7:0] write_data = 0;

	reg [1:0] sclk_buf = 0;
	always @(posedge clk) begin
		// buffer SPI clock
		sclk_buf = {sclk_buf[0], SCLK};
	end

    assign D5 = 0;
    assign D1 = 1;
	reg [3:0] bit_count = 0;
	always @(posedge clk) begin
		// if buffered SPI clock has rising edge, clock in MOSI
		// read
        if (sclk_buf[1:0] == 2'b01) begin
			read_data = {read_data[6:0], MOSI};
			bit_count <= bit_count + 1;
        end
        // write
		if (sclk_buf[1:0] == 2'b10) begin
			if (bit_count[3]) begin
				bit_count <= 0;
				write_data <= read_data;
			end else begin
				write_data <= {write_data[6:0], 1'b0};
			end
		end
    end
    assign D1 = 0;
    assign D5 = 1;

    // return data
	assign MISO = write_data[7];
endmodule

// XX bit counter function 
module counter (// input
                input         clk,
                input  [7:0]  data_incoming,
                input  [7:0] incount,
                // output
                output [7:0] outcount
               );

   always @ (posedge clk) 
	begin
        outcount <= data_incoming + 1;
   end

endmodule

module correlation_function (// input

                             // output
                            );
   // add functiona later
endmodule