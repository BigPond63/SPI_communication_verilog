onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /SPI_tb/ins0/master_ins0/start_sig
add wave -noupdate /SPI_tb/ins0/master_ins0/clk
add wave -noupdate /SPI_tb/ins0/master_ins0/miso
add wave -noupdate /SPI_tb/ins0/master_ins0/mosi
add wave -noupdate /SPI_tb/ins0/master_ins0/cs_n
add wave -noupdate /SPI_tb/ins0/master_ins0/rx
add wave -noupdate /SPI_tb/ins0/master_ins0/tx
add wave -noupdate /SPI_tb/ins0/master_ins0/done
add wave -noupdate /SPI_tb/ins0/master_ins0/sclk_out
add wave -noupdate /SPI_tb/ins0/master_ins0/state
add wave -noupdate /SPI_tb/ins0/master_ins0/tx_shift
add wave -noupdate /SPI_tb/ins0/master_ins0/rx_shift
add wave -noupdate /SPI_tb/ins0/master_ins0/bit_count
add wave -noupdate /SPI_tb/ins0/master_ins0/sclk_rise
add wave -noupdate /SPI_tb/ins0/master_ins0/sclk_fall
add wave -noupdate /SPI_tb/ins0/master_ins0/sclk
add wave -noupdate /SPI_tb/ins0/master_ins0/misoOne
add wave -noupdate /SPI_tb/ins0/master_ins0/misoTwo
add wave -noupdate /SPI_tb/ins0/slave_ins0/cs_n
add wave -noupdate /SPI_tb/ins0/slave_ins0/rx_slave
add wave -noupdate /SPI_tb/ins0/slave_ins0/tx_slave
add wave -noupdate /SPI_tb/ins0/slave_ins0/sclk
add wave -noupdate /SPI_tb/ins0/slave_ins0/mosi
add wave -noupdate /SPI_tb/ins0/slave_ins0/miso
add wave -noupdate /SPI_tb/ins0/slave_ins0/rx_shift
add wave -noupdate /SPI_tb/ins0/slave_ins0/tx_shift
add wave -noupdate /SPI_tb/ins0/slave_ins0/bit_count
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3407813 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 230
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {3407813 ps} {3669957 ps}
