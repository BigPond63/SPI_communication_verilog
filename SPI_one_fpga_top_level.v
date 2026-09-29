module SPI_one_fpga_top_level(
	input CLOCK_50,
	output done_flag,
	input [9:0] SW,
	output reg [9:0] LEDR = 10'b0
);
	
	
	wire mosi;
	wire miso;
	
	wire [0:0] start;
	wire [15:0] master_rx;
	wire [15:0] slave_rx;
	wire cs_n_wire;
	
	/*
	reg [15:0] master_tx = 16'd67;
	reg [15:0] slave_tx = 16'd69;
	*/
	reg [15:0] master_tx = 16'd43210;
	reg [15:0] slave_tx = 16'd32100;
	wire sclk;
	
	assign start = SW[9];
	
	always @(*) begin
		// display what master has received
		if (SW[0] && ~SW[1]) begin
			LEDR[9:0] = master_rx[9:0];
			
		// display what slave has received
		end else if (SW[1] && ~SW[0]) begin
			LEDR[9:0] = slave_rx[9:0];
			
		end else if (SW[5]) begin
			LEDR[9:0] = 16'd64;
		end else LEDR[9:0] = {10{1'b1}};
		
	end
	
	// fragile with done_flag atm -> output logic feeds into input logic -> just test
	SPI_master master_ins0 (
		.start_sig(start),
		.clk(CLOCK_50),
		.miso(miso),
		.mosi(mosi),
		.cs_n(cs_n_wire),
		.rx(master_rx),
		.tx(master_tx),
		.done(done_flag),
		.sclk_out(sclk)
	);
	
	SPI_slave slave_ins0 (
		.cs_n(cs_n_wire),
		.rx_slave(slave_rx),
		.tx_slave(slave_tx),
		.sclk(sclk),
		.mosi(mosi),
		.miso(miso)
	);


endmodule