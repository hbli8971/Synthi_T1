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
add wave -noupdate -expand /synthi_top_tb/DUT/EQ_top_1/EQ_ctrl_1/atte_freq
add wave -noupdate -expand /synthi_top_tb/DUT/EQ_top_1/EQ_ctrl_1/atte_value
add wave -noupdate /synthi_top_tb/DUT/EQ_top_1/EQ_ctrl_1/enable_eq
add wave -noupdate /synthi_top_tb/DUT/EQ_top_1/EQ_ctrl_1/reset_n
add wave -noupdate -format Analog-Step -height 74 -max 1023.0 -min -1024.0 -radix decimal -childformat {{/synthi_top_tb/DUT/tone_generator_1/dds_l_o(15) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_l_o(14) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_l_o(13) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_l_o(12) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_l_o(11) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_l_o(10) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_l_o(9) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_l_o(8) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_l_o(7) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_l_o(6) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_l_o(5) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_l_o(4) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_l_o(3) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_l_o(2) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_l_o(1) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_l_o(0) -radix decimal}} -expand -subitemconfig {/synthi_top_tb/DUT/tone_generator_1/dds_l_o(15) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_l_o(14) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_l_o(13) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_l_o(12) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_l_o(11) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_l_o(10) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_l_o(9) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_l_o(8) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_l_o(7) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_l_o(6) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_l_o(5) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_l_o(4) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_l_o(3) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_l_o(2) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_l_o(1) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_l_o(0) {-radix decimal}} /synthi_top_tb/DUT/tone_generator_1/dds_l_o
add wave -noupdate -radix decimal -childformat {{/synthi_top_tb/DUT/tone_generator_1/dds_inst_gen(0)/inst_dds/phi_incr(18) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_inst_gen(0)/inst_dds/phi_incr(17) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_inst_gen(0)/inst_dds/phi_incr(16) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_inst_gen(0)/inst_dds/phi_incr(15) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_inst_gen(0)/inst_dds/phi_incr(14) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_inst_gen(0)/inst_dds/phi_incr(13) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_inst_gen(0)/inst_dds/phi_incr(12) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_inst_gen(0)/inst_dds/phi_incr(11) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_inst_gen(0)/inst_dds/phi_incr(10) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_inst_gen(0)/inst_dds/phi_incr(9) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_inst_gen(0)/inst_dds/phi_incr(8) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_inst_gen(0)/inst_dds/phi_incr(7) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_inst_gen(0)/inst_dds/phi_incr(6) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_inst_gen(0)/inst_dds/phi_incr(5) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_inst_gen(0)/inst_dds/phi_incr(4) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_inst_gen(0)/inst_dds/phi_incr(3) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_inst_gen(0)/inst_dds/phi_incr(2) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_inst_gen(0)/inst_dds/phi_incr(1) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_inst_gen(0)/inst_dds/phi_incr(0) -radix decimal}} -subitemconfig {/synthi_top_tb/DUT/tone_generator_1/dds_inst_gen(0)/inst_dds/phi_incr(18) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_inst_gen(0)/inst_dds/phi_incr(17) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_inst_gen(0)/inst_dds/phi_incr(16) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_inst_gen(0)/inst_dds/phi_incr(15) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_inst_gen(0)/inst_dds/phi_incr(14) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_inst_gen(0)/inst_dds/phi_incr(13) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_inst_gen(0)/inst_dds/phi_incr(12) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_inst_gen(0)/inst_dds/phi_incr(11) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_inst_gen(0)/inst_dds/phi_incr(10) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_inst_gen(0)/inst_dds/phi_incr(9) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_inst_gen(0)/inst_dds/phi_incr(8) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_inst_gen(0)/inst_dds/phi_incr(7) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_inst_gen(0)/inst_dds/phi_incr(6) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_inst_gen(0)/inst_dds/phi_incr(5) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_inst_gen(0)/inst_dds/phi_incr(4) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_inst_gen(0)/inst_dds/phi_incr(3) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_inst_gen(0)/inst_dds/phi_incr(2) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_inst_gen(0)/inst_dds/phi_incr(1) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_inst_gen(0)/inst_dds/phi_incr(0) {-radix decimal}} /synthi_top_tb/DUT/tone_generator_1/dds_inst_gen(0)/inst_dds/phi_incr
add wave -noupdate -format Analog-Step -height 74 -max 1023.0 -min -1024.0 -radix decimal -childformat {{/synthi_top_tb/DUT/tone_generator_1/dds_r_o(15) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_r_o(14) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_r_o(13) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_r_o(12) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_r_o(11) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_r_o(10) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_r_o(9) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_r_o(8) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_r_o(7) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_r_o(6) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_r_o(5) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_r_o(4) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_r_o(3) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_r_o(2) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_r_o(1) -radix decimal} {/synthi_top_tb/DUT/tone_generator_1/dds_r_o(0) -radix decimal}} -expand -subitemconfig {/synthi_top_tb/DUT/tone_generator_1/dds_r_o(15) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_r_o(14) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_r_o(13) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_r_o(12) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_r_o(11) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_r_o(10) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_r_o(9) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_r_o(8) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_r_o(7) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_r_o(6) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_r_o(5) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_r_o(4) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_r_o(3) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_r_o(2) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_r_o(1) {-radix decimal} /synthi_top_tb/DUT/tone_generator_1/dds_r_o(0) {-radix decimal}} /synthi_top_tb/DUT/tone_generator_1/dds_r_o
add wave -noupdate /synthi_top_tb/DUT/tone_generator_1/algorithm_i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5443994 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 456
configure wave -valuecolwidth 244
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
WaveRestoreZoom {0 ns} {8025611 ns}
