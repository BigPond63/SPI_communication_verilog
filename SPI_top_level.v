module SPI_top_level(
	input CLOCK_50,
	
	input GPIO_14_MOSI_IN,
	output GPIO_0_MOSI_OUT,
	
	input GPIO_18_MISO_IN,
	output GPIO_4_MISO_OUT,
	
	input GPIO_20_SCLK_IN,
	output GPIO_9_SCLK_OUT,
	
	input GPIO_24_CS_IN,
	output GPIO_7_CS_OUT,

	input [1:0] SW,
	output reg [9:0] LEDR = 10'b0
);

	
	reg [0:0] start = 1'b0;
	wire [15:0] master_rx;
	wire [15:0] slave_rx;
	
	reg [15:0] master_tx = 16'd67;
	reg [15:0] slave_tx = 16'd69;
	
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
		.miso(GPIO_18_MISO_IN),
		.mosi(GPIO_0_MOSI_OUT),
		.cs_n(GPIO_7_CS_OUT),
		.rx(master_rx),
		.tx(master_tx),
		.done(done_flag),
		.sclk_out(GPIO_9_SCLK_OUT)
	);
	
	SPI_slave slave_ins0 (
		.cs_n(GPIO_24_CS_IN),
		.rx_slave(slave_rx),
		.tx_slave(slave_tx),
		.sclk(GPIO_20_SCLK_IN),
		.mosi(GPIO_14_MOSI_IN),
		.miso(GPIO_4_MISO_OUT)
	);


endmodule