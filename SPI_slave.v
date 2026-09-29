module SPI_slave (
	input cs_n,
	output reg [15:0] rx_slave = 16'd0,
	input [15:0] tx_slave, // to be transmitted to master
	input sclk,
	input mosi,
	output miso
);
	reg [15:0] rx_shift = 16'd0;
	reg [15:0] tx_shift = 16'd0;
	reg [4:0] bit_count = 5'd0;
	
	assign miso = tx_shift[15];
	
	
	// IDLE TRANSMISSION FINISH
	
	always @(posedge sclk, posedge cs_n) begin
	
		if (cs_n) begin
			// reset bit count
			bit_count <= 5'd0;
		
		end else begin
		
			// receive bits from master
			rx_shift <= {rx_shift[14:0], mosi};
			bit_count <= bit_count + 5'd1;
			
		end
		
		
	end
	
	
	always @(negedge sclk, posedge cs_n) begin
		
		// cs_n = 1, transmission informaion is placed onto tx_shift
		if (cs_n) begin
			tx_shift <= tx_slave;
		end else if (bit_count == 5'd16) begin
			rx_slave <= rx_shift;
			
		end else begin
			// load up next bit for transmission
			tx_shift <= {tx_shift[14:0], 1'b0};
		end

		
	end
	
endmodule

