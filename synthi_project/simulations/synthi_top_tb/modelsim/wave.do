onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /synthi_top_tb/DUT/i2c_master_1/sda_io
add wave -noupdate /synthi_top_tb/DUT/i2c_master_1/scl_o
add wave -noupdate /synthi_top_tb/DUT/codec_controller_1/fsm_state
add wave -noupdate /synthi_top_tb/DUT/codec_controller_1/write_data_o
add wave -noupdate /synthi_top_tb/DUT/codec_controller_1/write_o
add wave -noupdate /synthi_top_tb/DUT/codec_controller_1/count
add wave -noupdate /synthi_top_tb/KEY_0
add wave -noupdate /synthi_top_tb/SW
add wave -noupdate /synthi_top_tb/DUT/inst_i2s_master/i2s_frame_generator_1/count_reg
add wave -noupdate /synthi_top_tb/DUT/inst_i2s_master/i2s_frame_generator_1/shift_l
add wave -noupdate /synthi_top_tb/DUT/inst_i2s_master/i2s_frame_generator_1/shift_r
add wave -noupdate /synthi_top_tb/DUT/inst_i2s_master/i2s_frame_generator_1/load
add wave -noupdate /synthi_top_tb/DUT/inst_i2s_master/i2s_frame_generator_1/clk_6m
add wave -noupdate /synthi_top_tb/DUT/inst_i2s_master/i2s_frame_generator_1/ws
add wave -noupdate /synthi_top_tb/DUT/inst_i2s_master/dacdat_s_o
add wave -noupdate /synthi_top_tb/DUT/inst_i2s_master/adcdat_s_i
add wave -noupdate /synthi_top_tb/DUT/inst_i2s_master/adcdat_pl_o
add wave -noupdate /synthi_top_tb/DUT/inst_i2s_master/adcdat_pr_o
add wave -noupdate /synthi_top_tb/DUT/inst_i2s_master/ws_o
add wave -noupdate /synthi_top_tb/DUT/inst_i2s_master/dacdat_pr_i
add wave -noupdate /synthi_top_tb/DUT/inst_i2s_master/dacdat_pl_i
add wave -noupdate /synthi_top_tb/DUT/inst_i2s_master/adcdat_pl_o
add wave -noupdate /synthi_top_tb/DUT/inst_i2s_master/adcdat_pr_o
add wave -noupdate /synthi_top_tb/DUT/inst_i2s_master/uni_shiftreg_4/serial_in
add wave -noupdate /synthi_top_tb/DUT/inst_i2s_master/uni_shiftreg_4/enable
add wave -noupdate /synthi_top_tb/DUT/inst_i2s_master/uni_shiftreg_4/parallel_out
add wave -noupdate /synthi_top_tb/DUT/inst_i2s_master/uni_shiftreg_4/clock
add wave -noupdate /synthi_top_tb/DUT/inst_i2s_master/uni_shiftreg_4/reset
add wave -noupdate /synthi_top_tb/DUT/inst_i2s_master/reset
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {23579 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 426
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
WaveRestoreZoom {0 ns} {41214 ns}
