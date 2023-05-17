onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /synthi_top_tb/DUT/MIDI_2/note
add wave -noupdate /synthi_top_tb/DUT/MIDI_2/velocity
add wave -noupdate /synthi_top_tb/DUT/MIDI_2/note_valid
add wave -noupdate /synthi_top_tb/DUT/MIDI_2/data2_reg
add wave -noupdate /synthi_top_tb/DUT/MIDI_2/data1_reg
add wave -noupdate /synthi_top_tb/DUT/uart_top_1/rx_data
add wave -noupdate /synthi_top_tb/DUT/infrastructure_1/clock_sync_2/sync_out
add wave -noupdate /synthi_top_tb/DUT/uart_top_1/b2v_inst1/next_shiftreg
add wave -noupdate /synthi_top_tb/DUT/uart_top_1/b2v_inst1/load_in
add wave -noupdate /synthi_top_tb/DUT/uart_top_1/b2v_inst1/shift_enable
add wave -noupdate /synthi_top_tb/DUT/uart_top_1/b2v_inst1/clk
add wave -noupdate /synthi_top_tb/DUT/uart_top_1/b2v_inst7/data_valid
add wave -noupdate /synthi_top_tb/DUT/uart_top_1/b2v_inst1/parallel_out
add wave -noupdate /synthi_top_tb/DUT/MIDI_2/status_reg
add wave -noupdate /synthi_top_tb/DUT/BT_TXD
add wave -noupdate /synthi_top_tb/DUT/EQ_top_1/RX_DATA_intern
add wave -noupdate /synthi_top_tb/DUT/EQ_top_1/atte_freqency
add wave -noupdate /synthi_top_tb/DUT/EQ_top_1/atte_value
add wave -noupdate /synthi_top_tb/DUT/EQ_top_1/enable
add wave -noupdate /synthi_top_tb/DUT/EQ_top_1/EQ_ctrl_1/ctrl_reg
add wave -noupdate /synthi_top_tb/DUT/EQ_top_1/EQ_ctrl_1/data1_reg
add wave -noupdate /synthi_top_tb/DUT/EQ_top_1/EQ_ctrl_1/data2_reg
add wave -noupdate /synthi_top_tb/DUT/EQ_top_1/EQ_ctrl_1/rx_data_rdy
add wave -noupdate /synthi_top_tb/DUT/EQ_top_1/EQ_ctrl_1/data_rdy
add wave -noupdate /synthi_top_tb/DUT/EQ_top_1/EQ_ctrl_1/next_enable
add wave -noupdate /synthi_top_tb/DUT/EQ_top_1/EQ_ctrl_1/atte_freq
add wave -noupdate /synthi_top_tb/DUT/EQ_top_1/EQ_ctrl_1/atte_value
add wave -noupdate /synthi_top_tb/DUT/EQ_top_1/EQ_ctrl_1/enable_eq
add wave -noupdate /synthi_top_tb/DUT/EQ_top_1/EQ_ctrl_1/reset_n
add wave -noupdate -format Analog-Step -height 74 -max 255.00000000000003 -min -256.0 -radix decimal /synthi_top_tb/DUT/tone_generator_1/dds_l_o
add wave -noupdate -radix decimal /synthi_top_tb/DUT/tone_generator_1/dds_inst_gen(0)/inst_dds/phi_incr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4761449 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 456
configure wave -valuecolwidth 55
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
WaveRestoreZoom {141432 ns} {6578172 ns}
