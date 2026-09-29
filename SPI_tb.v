module SPI_tb;



	wire done_tb;
	reg clk_tb = 1'b0;
	reg [9:0] SW_tb;
	wire [9:0] LEDR_tb;
	
	
	SPI_one_fpga_top_level ins0 (
		.CLOCK_50(clk_tb),
		.done_flag(done_tb),
		.SW(SW_tb),
		.LEDR(LEDR_tb)
	);
	
	
	
	always begin
		#10;
		clk_tb = ~clk_tb;
		
	end

	
	initial begin
		#50;
		SW_tb[9] = 1'b1;
		#20;
		SW_tb[9] = 1'b0;
	end
	
	initial begin
	
		#10000;
		$stop;
	
	
	end
	
endmodule