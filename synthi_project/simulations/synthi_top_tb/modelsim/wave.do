onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /synthi_top_tb/SW
add wave -noupdate /synthi_top_tb/DUT/uart_top_1/rx_data
add wave -noupdate /synthi_top_tb/DUT/uart_top_1/rx_data_rdy
add wave -noupdate /synthi_top_tb/USB_TXD
add wave -noupdate /synthi_top_tb/DUT/MIDI_2/note
add wave -noupdate /synthi_top_tb/DUT/MIDI_2/velocity
add wave -noupdate /synthi_top_tb/DUT/MIDI_2/note_valid
add wave -noupdate /synthi_top_tb/DUT/MIDI_2/data1_reg
add wave -noupdate /synthi_top_tb/DUT/MIDI_2/data2_reg
add wave -noupdate /synthi_top_tb/DUT/MIDI_2/note_on
add wave -noupdate /synthi_top_tb/DUT/MIDI_2/reg_tone_on
add wave -noupdate /synthi_top_tb/DUT/tone_generator_1/tone_on_i
add wave -noupdate /synthi_top_tb/DUT/tone_generator_1/step_i
add wave -noupdate /synthi_top_tb/DUT/tone_generator_1/note_i
add wave -noupdate /synthi_top_tb/DUT/tone_generator_1/velocity_i
add wave -noupdate /synthi_top_tb/DUT/tone_generator_1/rst_n
add wave -noupdate /synthi_top_tb/DUT/tone_generator_1/dds_l_o
add wave -noupdate /synthi_top_tb/DUT/tone_generator_1/dds_r_o
add wave -noupdate /synthi_top_tb/DUT/tone_generator_1/dds_o_array
add wave -noupdate /synthi_top_tb/DUT/tone_generator_1/sum_reg
add wave -noupdate /synthi_top_tb/DUT/tone_generator_1/next_sum_reg
add wave -noupdate /synthi_top_tb/DUT/tone_generator_1/dds_o
add wave -noupdate -format Analog-Step -height 74 -max 30.999999999999996 -min -31.0 /synthi_top_tb/DUT/tone_generator_1/dds_inst_gen(0)/inst_dds/dds_o
add wave -noupdate -max 4094.9999999999991 -min -3857.0 /synthi_top_tb/DUT/tone_generator_1/dds_inst_gen(0)/inst_dds/lut_val
add wave -noupdate /synthi_top_tb/DUT/tone_generator_1/dds_inst_gen(0)/inst_dds/counter_register/lut_addr
add wave -noupdate /synthi_top_tb/DUT/tone_generator_1/dds_l_o
add wave -noupdate /synthi_top_tb/DUT/tone_generator_1/dds_r_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {35671761 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 456
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
WaveRestoreZoom {34979066 ns} {38755371 ns}
