module SPI_master_tb;

		/*
		bit counter is sampled each edge, just once
		mosi changes only on change edge
		miso sampled on correct edge as well, and also msut be in the right order
		i dont get what mosi shows expected bit at each sample edge means.

		at the end, we also check

		word size amoutn of bits must be received, and also 2*wordsize amoutn fo sclk occured
		done pulse, rx holds word, and cs_n go high (All values must be checked)
		cs_n low for whoel time, sclk must idle before cs_n rises.
		time out wanrings, i ened to chekci this later.
		
		*/
		

endmodule