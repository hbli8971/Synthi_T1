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
add wave -noupdate /synthi_top_tb/DUT/MIDI_2/reg_note
add wave -noupdate /synthi_top_tb/DUT/MIDI_2/reg_velocity
add wave -noupdate /synthi_top_tb/DUT/MIDI_2/output_velocity
add wave -noupdate /synthi_top_tb/DUT/MIDI_2/output_note
add wave -noupdate /synthi_top_tb/DUT/MIDI_2/TEST/note_written
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {99270 ns} 0}
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
WaveRestoreZoom {48831925 ns} {50061478 ns}
