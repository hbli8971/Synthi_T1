-- Copyright (C) 2021  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- PROGRAM		"Quartus Prime"
-- VERSION		"Version 21.1.0 Build 842 10/21/2021 SJ Lite Edition"
-- CREATED		"Tue Dec  6 11:51:23 2022"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY uart_top IS 
	PORT
	(
		clk_6m 		:  IN  STD_LOGIC;
		reset_n 		:  IN  STD_LOGIC;
		serial_in 	:  IN  STD_LOGIC;
		rx_data 		:  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		rx_data_rdy :  OUT  STD_LOGIC;
		HEX0 			:  OUT  STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX1 			:  OUT  STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END uart_top;

ARCHITECTURE bdf_type OF uart_top IS

COMPONENT baud_tick
GENERIC (width : INTEGER);
	PORT(
			clk 			: IN STD_LOGIC;
			reset_n 		: IN STD_LOGIC;
			start_pulse : IN STD_LOGIC;
			baud_tick 	: OUT STD_LOGIC
		 );
END COMPONENT;

COMPONENT flanken_detekt_vhdl
	PORT(	
			data_in 			: IN STD_LOGIC;
			clk 				: IN STD_LOGIC;
			reset_n 			: IN STD_LOGIC;
			falling_pulse 	: OUT STD_LOGIC;
			rising_pulse 	: OUT STD_LOGIC
		 );
END COMPONENT;

COMPONENT uart_controller_fsm
	PORT(
			clk 				: IN STD_LOGIC;
			reset_n 			: IN STD_LOGIC;
			falling_pulse 	: IN STD_LOGIC;
			baud_tick 		: IN STD_LOGIC;
			bit_count 		: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			parallel_data 	: IN STD_LOGIC_VECTOR(9 DOWNTO 0);
			shift_enable 	: OUT STD_LOGIC;
			start_pulse 	: OUT STD_LOGIC;
			data_valid 		: OUT STD_LOGIC
		 );
END COMPONENT;

COMPONENT bit_counter
GENERIC (width : INTEGER);
	PORT(
			clk 			: IN STD_LOGIC;
			reset_n 		: IN STD_LOGIC;
			start_pulse : IN STD_LOGIC;
			baud_tick 	: IN STD_LOGIC;
			bit_count 	: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
		 );
END COMPONENT;

COMPONENT shiftreg_uart
GENERIC (width : INTEGER);
	PORT(
			clk 				: IN STD_LOGIC;
			reset_n 			: IN STD_LOGIC;
			load_in 			: IN STD_LOGIC;
			serial_in 		: IN STD_LOGIC;
			shift_enable 	: IN STD_LOGIC;
			parallel_in 	: IN STD_LOGIC_VECTOR(9 DOWNTO 0);
			serial_out 		: OUT STD_LOGIC;
			parallel_out 	: OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
		 );
END COMPONENT;

COMPONENT output_register
GENERIC (width : INTEGER);
	PORT(
			clk 			: IN STD_LOGIC;
			reset_n 		: IN STD_LOGIC;
			data_valid 	: IN STD_LOGIC;
			parallel_in : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
			hex_lsb_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			hex_msb_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
		 );
END COMPONENT;

COMPONENT vhdl_hex2sevseg
	PORT(
			data_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			seg_out : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
		 );
END COMPONENT;

SIGNAL	start_pulse_sig 	:  STD_LOGIC;
SIGNAL	baud_tick_sig 		:  STD_LOGIC;
SIGNAL	falling_pulse_sig :  STD_LOGIC;
SIGNAL	bit_count_sig 		:  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	parallel_data_sig :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	shift_enable_sig 	:  STD_LOGIC;
SIGNAL	data_valid_sig 	:  STD_LOGIC;
SIGNAL	load_in_sig 		:  STD_LOGIC;
SIGNAL	serial_in_sig 		:  STD_LOGIC;
SIGNAL	parallel_in_sig	:  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	hex_lsb_out_sig	:  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	hex_msb_out_sig	:  STD_LOGIC_VECTOR(3 DOWNTO 0);



BEGIN 

-- Signale auf GND setzen
load_in_sig <= '0';
serial_in_sig <= '0';
parallel_in_sig <= "0000000000";


inst_1 : baud_tick
GENERIC MAP(width => 6)
PORT MAP(
				clk 			=> clk_6m,
				reset_n 		=> reset_n,
				start_pulse => start_pulse_sig,
				baud_tick 	=> baud_tick_sig
				
		  );

inst_2 : flanken_detekt_vhdl
PORT MAP(
				data_in 			=> serial_in,
				clk 				=> clk_6m,
				reset_n 			=> reset_n,
				falling_pulse 	=> falling_pulse_sig
			);

inst_3 : uart_controller_fsm
PORT MAP(	
				clk 				=> clk_6m,
				reset_n 			=> reset_n,
				falling_pulse 	=> falling_pulse_sig,
				baud_tick 		=> baud_tick_sig,
				bit_count 		=> bit_count_sig,
				parallel_data 	=> parallel_data_sig,
				shift_enable 	=> shift_enable_sig,
				start_pulse 	=> start_pulse_sig,
				data_valid 		=> data_valid_sig
			);

inst_4 : bit_counter
GENERIC MAP(width => 4)
PORT MAP(
				clk 			=> clk_6m,
				reset_n 		=> reset_n,
				start_pulse => start_pulse_sig,
				baud_tick 	=> baud_tick_sig,
				bit_count 	=> bit_count_sig
			);

inst_5 : shiftreg_uart
GENERIC MAP(width => 10)
PORT MAP(
				clk 				=> clk_6m,
				reset_n 			=> reset_n,
				shift_enable 	=> shift_enable,
				load_in 			=> load_in_sig,
				serial_in 		=> serial_in_sig,
				parallel_in 	=> parallel_in_sig,
				parallel_out 	=> parallel_data_sig
			);
			
inst_6 : output_register
GENERIC MAP(width => 10)
PORT MAP(
				clk 			=> clk_6m,
				reset_n 		=> reset_n,
				data_valid 	=> data_valid_sig,
				parallel_in => parallel_in_sig,
				hex_lsb_out => hex_lsb_out_sig,
				hex_msb_out => hex_msb_out_sig
			); 
			
		 
inst_7 : vhdl_hex2sevseg
PORT MAP(
				data_in => hex_lsb_out_sig,
				seg_out => hex0
			);


inst_8 : vhdl_hex2sevseg
PORT MAP(
				data_in => hex_msb_out_sig,
				seg_out => hex1
			);
		 

END bdf_type;