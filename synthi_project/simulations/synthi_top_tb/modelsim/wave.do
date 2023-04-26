onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /synthi_top_tb/SW
add wave -noupdate /synthi_top_tb/DUT/MIDI_1/rx_data_rdy
add wave -noupdate /synthi_top_tb/DUT/MIDI_1/note_valid
add wave -noupdate /synthi_top_tb/DUT/MIDI_1/fsm_state
add wave -noupdate /synthi_top_tb/DUT/MIDI_1/next_fsm_state
add wave -noupdate /synthi_top_tb/DUT/MIDI_1/data1_reg
add wave -noupdate /synthi_top_tb/DUT/MIDI_1/data2_reg
add wave -noupdate /synthi_top_tb/DUT/MIDI_1/note_on
add wave -noupdate /synthi_top_tb/DUT/uart_top_1/rx_data
add wave -noupdate /synthi_top_tb/DUT/uart_top_1/rx_data_rdy
add wave -noupdate /synthi_top_tb/USB_TXD
add wave -noupdate /synthi_top_tb/DUT/MIDI_1/rx_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2880097 ns} 0}
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
WaveRestoreZoom {0 ns} {1229553 ns}
