// this modules divides a clk down to sclk for transmission purposes in SPI

module sclk (
	input [0:0] clk,
	output reg [0:0] ser_clk = 1'd0,
	output [0:0] sclk_rise,
	output [0:0] sclk_fall
);
	
	parameter COUNT = 5; 
	
	// ceiling log 2 the count -> only runs at compile time, not synthesised onto hardware
	reg [$clog2(COUNT)-1:0] count = 0;
	
	
	// serial clock is about to rise -> sample data from both sides
	assign sclk_rise = ( (count == (COUNT-1)) && (~ser_clk) );
		
	// serial clock is about to fall -> shift data in to be sent
	assign sclk_fall = ( (count == (COUNT-1)) && (ser_clk) );
	
	always @(posedge clk) begin
	
		// -1, as we account for count to begin at 0, therefore 0, 1, 2, 3, 4 -> 5 ticks each cycle
		if (count == (COUNT-1)) begin
			count <= 0;
			ser_clk <= ~ser_clk;
		end else begin
			count <= count + 1'd1;
		end
		
		
	end
	// therefore, sclk will change from high to low, or low to high -> every period is 5MHZ
	
	
	
	

endmodule