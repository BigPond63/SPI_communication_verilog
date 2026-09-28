module SPI_master(
	input [0:0] sclk,
	input [0:0] miso,
	output [0:0] mosi,
	input [0:0] chip_select_n
);
	reg [0:0] chip_select_activate;

	// check if chip select is active low or not (active when logic 0)
	always @(chip_select_n) begin
		
	end
	
	
	// if at 0, then do the following actions:
	
		// wait until the first posedge of the clk, then send the data
		// what mode is this?
		// CPOL = 0, CPHA = 0 -> mode 0 in total
		// Clock polarity = 0, sclk idles low
		// clock phase = 0, data sampled on first edge of clock
		
		// transfer bit one by one on spi, everytime during posedge of clk
		
		// word size -> be 16 for this part of the project
		
		
		// design choices to be made
		// do an alwa