module SPI_master (
	input start_sig, // externally from processor
	input clk, // synced with clock_50
	
	input miso,
	output mosi,
	output reg cs_n = 1'b1,
	output reg [15:0] rx = 16'b0, // data to be received from slave
	input [15:0] tx, // data to be sent to slave
	output reg [0:0] done = 1'b0,
	output reg [0:0] sclk_reg = 1'b0;
);

	reg [2:0] state = 3'b001;
	reg [15:0] tx_shift = 16'b0;
	reg [15:0] rx_shift = 16'b0;
	reg [4:0] bit_count = 5'd0;
	
	
	
// states -> IDLE, TRANSMISSION, FINISH

	wire sclk_rise;
	wire sclk_fall;
	wire sclk;
	assign sclk_reg = sclk;

	sclk sclk_5MHZ (
		.clk(clk),
		.sclk_rise(sclk_rise),
		.sclk_fall(sclk_fall),
		.ser_clk(sclk)
	);
	
	// transmit bit to slave
	assign mosi = tx_shift[15];
	
	reg misoOne = 1'b0;
	reg misoTwo = 1'b0;
	
	// fix metastability, so that mosi is latched to certain value by the time we use it
	always @(posedge clk) begin
		misoOne <= miso;
		misoTwo <= misoOne;
	end


	always @(posedge clk) begin
	
		case (state)
		
		// IDLE
			3'b001: begin
			// check if we start transmission
			
				if (start_sig) begin
					cs_n <= 1'b0;
					state <= 3'b010;
					tx_shift <= tx;
				end
				
			end
			
		// TRANSMISSION
			3'b010: begin
				
					// mode = 0, rising edge sample bits
					if (sclk_rise) begin
					
						
						// receive bit from slave
						rx_shift <= {rx_shift[14:0], misoTwo};
						bit_count <= bit_count + 5'd1;
					
					// load next bit to be transmitted
					end 
					
					else if (sclk_fall) begin
					
						// check that bit transmission has completed
						if (bit_count == 5'd16) begin
							
							state <= 3'b100;
							rx <= rx_shift;
							bit_count <= 5'd0;
							
						end else begin
						
							// load next bit to be transmitted
							tx_shift <= {tx_shift[14:0], 1'b0};
							
						end
						
					end
				
			end
			
			
			
			3'b100: begin
				cs_n <= 1'b1;
				done <= 1'b1;
				state <= 3'b001;
			end
		
			default: state <= 3'b001;
			
		endcase
	
	end
