onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /synthi_top_tb/SW
add wave -noupdate /synthi_top_tb/DUT/inst_i2s_master/i2s_frame_generator_1/count_reg
add wave -noupdate /synthi_top_tb/DUT/inst_i2s_master/i2s_frame_generator_1/shift_l
add wave -noupdate /synthi_top_tb/DUT/inst_i2s_master/i2s_frame_generator_1/shift_r
add wave -noupdate /synthi_top_tb/DUT/inst_i2s_master/i2s_frame_generator_1/load
add wave -noupdate /synthi_top_tb/DUT/inst_i2s_master/i2s_frame_generator_1/ws
add wave -noupdate /synthi_top_tb/DUT/inst_i2s_master/dacdat_s_o
add wave -noupdate /synthi_top_tb/DUT/inst_i2s_master/adcdat_s_i
add wave -noupdate /synthi_top_tb/DUT/inst_i2s_master/adcdat_pl_o
add wave -noupdate /synthi_top_tb/DUT/inst_i2s_master/adcdat_pr_o
add wave -noupdate /synthi_top_tb/DUT/inst_i2s_master/dacdat_pr_i
add wave -noupdate /synthi_top_tb/DUT/inst_i2s_master/dacdat_pl_i
add wave -noupdate /synthi_top_tb/DUT/inst_i2s_master/uni_shiftreg_4/serial_in
add wave -noupdate /synthi_top_tb/DUT/inst_i2s_master/uni_shiftreg_4/enable
add wave -noupdate /synthi_top_tb/DUT/inst_i2s_master/uni_shiftreg_4/parallel_out
add wave -noupdate /synthi_top_tb/DUT/inst_i2s_master/uni_shiftreg_4/clock
add wave -noupdate /synthi_top_tb/DUT/inst_i2s_master/reset
add wave -noupdate /synthi_top_tb/DUT/inst_tone_generator/dds_1/tone_on
add wave -noupdate -format Analog-Step -height 74 -max 269850.0 /synthi_top_tb/DUT/inst_tone_generator/dds_o
add wave -noupdate -format Analog-Step -height 74 -max 269850.0 /synthi_top_tb/DUT/inst_path_ctrl/dds_l_i
add wave -noupdate -format Analog-Step -height 74 -max 269850.0 /synthi_top_tb/DUT/inst_path_ctrl/dds_r_i
add wave -noupdate /synthi_top_tb/DUT/inst_tone_generator/dds_1/counter_register/lut_addr
add wave -noupdate /synthi_top_tb/DUT/inst_tone_generator/dds_1/lut_val
add wave -noupdate /synthi_top_tb/DUT/inst_tone_generator/dds_1/count_o
add wave -noupdate -radix decimal -radixshowbase 0 /synthi_top_tb/DUT/inst_tone_generator/dds_1/phi_incr
add wave -noupdate /synthi_top_tb/DUT/inst_tone_generator/dds_1/attenu_i
add wave -noupdate /synthi_top_tb/DUT/inst_tone_generator/note_i
add wave -noupdate /synthi_top_tb/DUT/inst_tone_generator/step_i
add wave -noupdate /synthi_top_tb/DUT/inst_tone_generator/dds_1/count
add wave -noupdate /synthi_top_tb/DUT/inst_tone_generator/dds_1/next_count
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {20154000 ns} 0}
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
configure wave -timelineunits ms
update
WaveRestoreZoom {20149458 ns} {20167982 ns}
