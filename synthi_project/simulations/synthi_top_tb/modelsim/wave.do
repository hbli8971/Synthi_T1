onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /synthi_top_tb/SW
add wave -noupdate /synthi_top_tb/DUT/uart_top_1/rx_data
add wave -noupdate /synthi_top_tb/DUT/uart_top_1/rx_data_rdy
add wave -noupdate /synthi_top_tb/DUT/MIDI_2/note
add wave -noupdate /synthi_top_tb/DUT/MIDI_2/velocity
add wave -noupdate /synthi_top_tb/DUT/MIDI_2/note_valid
add wave -noupdate /synthi_top_tb/DUT/MIDI_2/data2_reg
add wave -noupdate /synthi_top_tb/DUT/MIDI_2/data1_reg
add wave -noupdate /synthi_top_tb/DUT/MIDI_2/note_on
add wave -noupdate /synthi_top_tb/DUT/MIDI_2/reg_tone_on
add wave -noupdate /synthi_top_tb/DUT/tone_generator_1/tone_on_i
add wave -noupdate /synthi_top_tb/DUT/tone_generator_1/step_i
add wave -noupdate /synthi_top_tb/DUT/tone_generator_1/note_i
add wave -noupdate /synthi_top_tb/DUT/tone_generator_1/velocity_i
add wave -noupdate /synthi_top_tb/DUT/uart_top_1/serial_in
add wave -noupdate /synthi_top_tb/DUT/uart_top_1/rx_data
add wave -noupdate /synthi_top_tb/DUT/uart_top_1/bit_data
add wave -noupdate /synthi_top_tb/GPIO_26
add wave -noupdate /synthi_top_tb/DUT/uart_top_1/baud_tick1
add wave -noupdate /synthi_top_tb/DUT/infrastructure_1/clock_sync_2/sync_out
add wave -noupdate /synthi_top_tb/DUT/uart_top_1/b2v_inst1/next_shiftreg
add wave -noupdate /synthi_top_tb/DUT/uart_top_1/b2v_inst1/load_in
add wave -noupdate /synthi_top_tb/DUT/uart_top_1/b2v_inst1/shift_enable
add wave -noupdate /synthi_top_tb/DUT/uart_top_1/b2v_inst1/clk
add wave -noupdate /synthi_top_tb/DUT/uart_top_1/b2v_inst7/parallel_data
add wave -noupdate /synthi_top_tb/DUT/uart_top_1/b2v_inst7/data_valid
add wave -noupdate /synthi_top_tb/DUT/uart_top_1/b2v_inst1/parallel_out
add wave -noupdate /synthi_top_tb/DUT/MIDI_2/status_reg
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {370790 ns} 0}
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
WaveRestoreZoom {354035 ns} {412588 ns}
