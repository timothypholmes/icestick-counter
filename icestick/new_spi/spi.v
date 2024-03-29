//
module top (
	output MISO,
	input MOSI,
	input SCLK,
	input CE0,
	input CE1,
    input clk
);
    // setup internal 48MHz oscillator
    wire clk;
    //SB_HFOSC inthosc (
    //    .CLKHFPU(1'b1),  // power-up
    //    .CLKHFEN(1'b1),  // enable
    //    .CLKHF(clk)  // output
    //);
	// inthosc.CLKHF_DIV = 2'b00;  divide by 1/2/4/8

	// register to store spi value
	reg [7:0] r0 = 0;
	reg [7:0] w0 = 0;

	reg [1:0] sclk_buf = 0;
	always @(posedge clk) begin
		// buffer SPI clock
		sclk_buf = {sclk_buf[0], SCLK};
	end

	reg [3:0] bit_count = 0;
	always @(posedge clk) begin
		// if buffered SPI clock has rising edge, clock in MOSI
		if (sclk_buf[1:0] == 2'b01) begin
			r0 = {r0[6:0], MOSI};
			bit_count <= bit_count + 1;
		end
		if (sclk_buf[1:0] == 2'b10) begin
			if (bit_count[3]) begin
				bit_count <= 0;
				w0 <= r0;
			end else begin
				w0 <= {w0[6:0], 1'b0};
			end
		end
	end

	assign MISO = w0[7];
endmodule
