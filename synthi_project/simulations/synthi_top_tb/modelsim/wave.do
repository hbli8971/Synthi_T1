onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /synthi_top_tb/DUT/i2c_master_1/sda_io
add wave -noupdate /synthi_top_tb/DUT/i2c_master_1/scl_o
add wave -noupdate /synthi_top_tb/DUT/codec_controller_1/fsm_state
add wave -noupdate /synthi_top_tb/DUT/codec_controller_1/write_data_o
add wave -noupdate /synthi_top_tb/DUT/codec_controller_1/write_o
add wave -noupdate /synthi_top_tb/DUT/codec_controller_1/count
add wave -noupdate /synthi_top_tb/i2c_slave_bfm_1/AUD_XCK
add wave -noupdate /synthi_top_tb/DUT/AUD_SCLK
add wave -noupdate /synthi_top_tb/DUT/AUD_SDAT
add wave -noupdate /synthi_top_tb/i2c_slave_bfm_1/reg_data0
add wave -noupdate /synthi_top_tb/i2c_slave_bfm_1/reg_data1
add wave -noupdate /synthi_top_tb/i2c_slave_bfm_1/reg_data2
add wave -noupdate /synthi_top_tb/DUT/i2c_master_1/write_done
add wave -noupdate /synthi_top_tb/DUT/i2c_master_1/ack_error_o
add wave -noupdate /synthi_top_tb/DUT/i2c_master_1/write_data_i
add wave -noupdate /synthi_top_tb/DUT/i2c_master_1/fsm_state
add wave -noupdate -radix hexadecimal /synthi_top_tb/DUT/i2c_master_1/next_data
add wave -noupdate /synthi_top_tb/DUT/i2c_master_1/data
add wave -noupdate /synthi_top_tb/DUT/i2c_master_1/byte_count
add wave -noupdate /synthi_top_tb/DUT/i2c_master_1/next_byte_count
add wave -noupdate /synthi_top_tb/KEY_0
add wave -noupdate /synthi_top_tb/SW
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {8710 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 295
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {4432896 ns}
