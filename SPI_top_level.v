module SPI_top_level(
	input GPIO_mosi_in,
	output GPIO_mosi_out,
	input GPIO_miso_in,
	output GPIO_miso_out,
	input CLOCK_50,
	output done_flag,
	input [1:0] SW,
	output reg [9:0] LEDR = 10'b0
);

	reg [0:0] start = 1'b0;
	wire [15:0] master_rx;
	wire [15:0] slave_rx;
	wire cs_n_wire;
	
	reg [15:0] master_tx = 16'd67;
	reg [15:0] slave_tx = 16'd69;
	
	wire sclk;
	
	always @(*) begin
		// display what master has received
		if (SW[0] && ~SW[1]) begin
			LEDR[9:0] = master_rx[9:0];
			
		// display what slave has received
		end else if (SW[1] && ~SW[0]) begin
			LEDR[9:0] = slave_rx[9:0];
			
		end else LEDR[9:0] = {10{1'b1}};
		
	end
	
	SPI_master master_ins0 (
		.start_sig(start),
		.clk(CLOCK_50),
		.miso(GPIO_miso_in),
		.mosi(GPIO_mosi_out),
		.cs_n(cs_n_wire),
		.rx(master_rx),
		.tx(master_tx),
		.done(done_flag),
		.sclk_reg(sclk)
	);
	
	SPI_slave slave_ins0 (
		.cs_n(cs_n_wire),
		.rx_slave(slave_rx),
		.tx_slave(slave_tx),
		.sclk(sclk),
		.mosi(GPIO_mosi_in),
		.miso(GPIO_miso_out)
	);


endmodule