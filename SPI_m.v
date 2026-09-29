module SPI_m(
	input [0:0] clk,
	input [0:0] miso,
	output [0:0] mosi,
	input [0:0] start_sig,
	output reg [0:0] chip_select_n = 1'b1,
	output reg [15:0] rx_received = 16'd0,
	input [15:0] tx_sent
);
	reg [15:0] shift_reg;
	reg [4:0] bit_count = 5'd0;
	reg [15:0] tx_reg;
	reg [0:0] done_flag;
	
	// if at 0, then do the following actions:
	
		// wait until the first posedge of the clk, then send the data
		// what mode is this?
		// CPOL = 0, CPHA = 0 -> mode 0 in total
		// Clock polarity = 0, sclk idles low
		// clock phase = 0, data sampled on first edge of clock
		
		// transfer bit one by one on spi, everytime during posedge of clk
		
		// word size -> be 16 for this part of the project
		
		
		// design choices to be made
		// do a procedural block with posedge of clk, as we aare using mode 0 
		
		/*
			within this block we check if chip_select_n has been active low or not?
			if no, jsut continue until next posedge of clock
			if yes, then wait until the next posedge of the clk, to send a bit through
			also, a bit must be sent back simultaneously, so therefore a condition must be that:
			
				A: a bit is sent through mosi
				B: a bit is required back through miso
		*/
		

		
		/*
		IDLE:
			 cs_n = 1, sclk = 0 (CPOL = 0)
			 if (start) -> load tx_data into shift register, cs_n = 0, mosi = MSB, go to TRANSFER

		TRANSFER (act only when tick fires):
			 if sclk is low (rising edge next):
				  sclk = 1
				  sample MISO into rx shift register
				  bit_count++
			 else (falling edge next):
				  sclk = 0
				  if bit_count == WORD_SIZE -> go to FINISH
				  else shift tx register, drive next bit onto MOSI

		FINISH:
			 done = 1, cs_n = 1
			 return to IDLE
		*/
		
	wire [0:0] ser_clk;
	wire [0:0] sclkRiseLogic;
	wire [0:0] sclkFallLogic;
	
	assign tx_reg = tx_sent; // once to reg
	assign mosi = tx_reg[15];
	
	sclk sclk_5MHZ (
		.clk(clk),
		.ser_clk(ser_clk),
		.sclk_rise(sclkRiseLogic),
		.sclk_fall(sclkFallLogic)
	);
	
	always @(posedge clk) begin
		done_flag <= 1'b0;
		
		// cs low, start transmission
		if (~chip_select_n && ~done_flag) begin
		
			// wait for rising edge of sclk to sample data
			if (sclkRiseLogic) begin
				shift_reg <= {shift_reg[14:0], miso};
				bit_count <= bit_count + 5'd1;
				
				if (bit_count == 5'd15) begin
				
					rx_received <= {shift_reg[14:0], miso};
					// change start signal 
					done_flag = 1'b1;
					// reset bit count
					bit_count <= 5'd0;
				end
			
			// wait for falling edge of sclk to shift data to be transmitted
			end else if (sclkFallLogic && ~done_flag) begin
				// shift tx_reg by one
				tx_reg = {tx_reg[14:0], 1'b0};
				
			end
		
		end
	end
	
		
	// idle for now, on each posedge of clk check whether or not start signal has been asserted 1.
	always @(posedge clk) begin
	
		// check start signal, if high then chip_select will go low, starting transmission.
		if (~done_flag) begin
			chip_select_n <= start_sig ? 1'b0 : 1'b1;
		end else if (done_flag) begin
			chip_select_n <= 1'b1;
		end
			
	end
	
	

		
		
endmodule