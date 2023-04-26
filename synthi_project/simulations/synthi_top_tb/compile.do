# create work library
vlib work

# compile project files
vcom -2008 -explicit -work work ../../support/simulation_pkg.vhd
vcom -2008 -explicit -work work ../../support/standard_driver_pkg.vhd
vcom -2008 -explicit -work work ../../support/user_driver_pkg.vhd

# others
vcom -2008 -explicit -work work ../../../source/others/modulo_divider.vhd
vcom -2008 -explicit -work work ../../../source/others/clock_sync.vhd
vcom -2008 -explicit -work work ../../../source/others/infrastructure.vhd
vcom -2008 -explicit -work work ../../../source/others/flanken_detekt_vhdl.vhd
vcom -2008 -explicit -work work ../../../source/others/baud_tick.vhd
vcom -2008 -explicit -work work ../../../source/others/vhdl_hex2sevseg.vhd
vcom -2008 -explicit -work work ../../../source/others/uart_controller_fsm.vhd
vcom -2008 -explicit -work work ../../../source/others/signal_checker.vhd
vcom -2008 -explicit -work work ../../../source/others/shiftreg_uart.vhd
vcom -2008 -explicit -work work ../../../source/others/output_register.vhd
vcom -2008 -explicit -work work ../../../source/others/bit_counter.vhd



# I2C
vcom -2008 -explicit -work work ../../../source/i2c/reg_table_pkg.vhd
vcom -2008 -explicit -work work ../../../source/i2c/i2c_slave_bfm.vhd
vcom -2008 -explicit -work work ../../../source/i2c/codec_controller.vhd
vcom -2008 -explicit -work work ../../../source/i2c/i2c_master.vhd


# I2S
vcom -2008 -explicit -work work ../../../source/i2s/i2s_frame_generator.vhd
vcom -2008 -explicit -work work ../../../source/i2s/i2s_master.vhd
vcom -2008 -explicit -work work ../../../source/i2s/mux_2_1.vhd
vcom -2008 -explicit -work work ../../../source/i2s/path_ctrl.vhd
vcom -2008 -explicit -work work ../../../source/i2s/uni_shiftreg.vhd

# DDS
vcom -2008 -explicit -work work ../../../source/dds/tone_gen_pkg.vhd
vcom -2008 -explicit -work work ../../../source/dds/dds.vhd
vcom -2008 -explicit -work work ../../../source/dds/tone_generator.vhd

# MIDI 
vcom -2008 -explicit -work work ../../../source/MIDI/MIDI.vhd



# Top_files
vcom -2008 -explicit -work work ../../../source/Top_files/uart_top.vhd
vcom -2008 -explicit -work work ../../../source/Top_files/synthi_top.vhd
vcom -2008 -explicit -work work ../../../source/Top_files/synthi_top_tb.vhd


# run the simulation (Achten Sie darauf, dass work.file_top_tb keine
# .vhdl Datei ist, sondern der Name der Testbench Entity)
vsim -voptargs=+acc -t 1ns -lib work work.synthi_top_tb
do ./wave.do
run 3 ms
