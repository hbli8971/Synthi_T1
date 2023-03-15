onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /synthi_top_tb/CLOCK_50
add wave -noupdate /synthi_top_tb/KEY_0
add wave -noupdate /synthi_top_tb/USB_TXD
add wave -noupdate /synthi_top_tb/DUT/uart_top_1/b2v_inst/baud_tick
add wave -noupdate /synthi_top_tb/DUT/uart_top_1/b2v_inst/start_bit
add wave -noupdate /synthi_top_tb/DUT/uart_top_1/b2v_inst1/parallel_out
add wave -noupdate /synthi_top_tb/DUT/uart_top_1/rx_data
add wave -noupdate /synthi_top_tb/DUT/uart_top_1/rx_data_rdy
add wave -noupdate /synthi_top_tb/DUT/uart_top_1/b2v_inst/count
add wave -noupdate /synthi_top_tb/DUT/uart_top_1/b2v_inst7/fsm_state
add wave -noupdate /synthi_top_tb/DUT/uart_top_1/b2v_inst7/falling_pulse
add wave -noupdate /synthi_top_tb/DUT/uart_top_1/b2v_inst18/clk
add wave -noupdate /synthi_top_tb/DUT/uart_top_1/b2v_inst18/data_in
add wave -noupdate /synthi_top_tb/DUT/uart_top_1/b2v_inst18/falling_pulse
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {10710 ns} 0}
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
WaveRestoreZoom {0 ns} {824320 ns}
