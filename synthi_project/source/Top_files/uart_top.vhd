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
-- CREATED		"Wed Feb 22 10:24:19 2023"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY uart_top IS 
	PORT
	(
		clk_6m :  IN  STD_LOGIC;
		reset_n :  IN  STD_LOGIC;
		serial_in :  IN  STD_LOGIC;
		rx_data :  OUT  STD_LOGIC_VECTOR(7 downto 0);
		rx_data_rdy :  OUT  STD_LOGIC;
		hex0 :  OUT  STD_LOGIC_VECTOR(6 DOWNTO 0);
		hex1 :  OUT  STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END uart_top;

ARCHITECTURE bdf_type OF uart_top IS 

COMPONENT baud_tick
GENERIC (width : INTEGER
			);
	PORT(clk : IN STD_LOGIC;
		 reset_n : IN STD_LOGIC;
		 start_bit : IN STD_LOGIC;
		 baud_tick : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT shiftreg_uart
GENERIC (width : INTEGER
			);
	PORT(clk : IN STD_LOGIC;
		 reset_n : IN STD_LOGIC;
		 serial_in : IN STD_LOGIC;
		 load_in : IN STD_LOGIC;
		 shift_enable : IN STD_LOGIC;
		 parallel_in : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 serial_out : OUT STD_LOGIC;
		 parallel_out : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
	);
END COMPONENT;

COMPONENT vhdl_hex2sevseg
	PORT(data_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 seg_o : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		 lt_n : IN std_logic;
		 blank_n : IN std_logic;
		 rbi_n : IN std_logic
		 
		 
	);
END COMPONENT;

COMPONENT flanken_detekt_vhdl
	PORT(data_in : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 reset_n : IN STD_LOGIC;
		 rising_pulse : OUT STD_LOGIC;
		 falling_pulse : OUT STD_LOGIC
	);
END COMPONENT;


COMPONENT bit_counter
GENERIC (width : INTEGER
			);
	PORT(clk : IN STD_LOGIC;
		 reset_n : IN STD_LOGIC;
		 start_bit : IN STD_LOGIC;
		 baud_tick : IN STD_LOGIC;
		 bit_count : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;

COMPONENT uart_controller_fsm
	PORT(clk : IN STD_LOGIC;
		 reset_n : IN STD_LOGIC;
		 falling_pulse : IN STD_LOGIC;
		 baud_tick : IN STD_LOGIC;
		 bit_count : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 parallel_data : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 shift_enable : OUT STD_LOGIC;
		 start_bit : OUT STD_LOGIC;
		 data_valid : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT output_register
GENERIC (width : INTEGER
			);
	PORT(clk : IN STD_LOGIC;
		 data_valid : IN STD_LOGIC;
		 reset_n : IN STD_LOGIC;
		 parallel_in : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 hex_lsb_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		 hex_msb_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	start_bit_sig :  STD_LOGIC;
SIGNAL	baud_tick1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC_VECTOR(0 TO 9);
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	bit_count :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	reset :  STD_LOGIC;
SIGNAL	shift_enable :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_6 :  STD_LOGIC;
SIGNAL 	bit_data : STD_LOGIC_VECTOR(9 downto 0);
SIGNAL   data_ready : STD_LOGIC;
SIGNAL	LT_sig:STD_LOGIC;
SIGNAL	blank_sig:STD_LOGIC;
SIGNAL	rbi_sig:STD_LOGIC;

BEGIN 
SYNTHESIZED_WIRE_1 <= '0';
SYNTHESIZED_WIRE_2 <= "0000000000";
rx_data <= bit_data(8 downto 1);
rx_data_rdy <= data_ready;
reset <= reset_n;
LT_sig<='0';
blank_sig<='0';
rbi_sig<='0';


b2v_inst : baud_tick
GENERIC MAP(width => 8)
--GENERIC MAP(width => 6) -- 4 PC
PORT MAP(clk => clk_6m,
		 reset_n => reset,
		 start_bit => start_bit_sig,		
		 baud_tick => baud_tick1);


b2v_inst1 : shiftreg_uart
GENERIC MAP(width => 10
			)
PORT MAP(clk => clk_6m,
		 reset_n => reset,
		 serial_in => serial_in,
		 load_in => SYNTHESIZED_WIRE_1,
		 shift_enable => shift_enable,
		 parallel_in => SYNTHESIZED_WIRE_2,
		 parallel_out => bit_data);




b2v_inst16 : vhdl_hex2sevseg
PORT MAP(data_in => SYNTHESIZED_WIRE_3,
		 seg_o => hex0,
		 lt_n => LT_sig,
		 blank_n => blank_sig,
		 rbi_n => rbi_sig);


b2v_inst17 : vhdl_hex2sevseg
PORT MAP(data_in => SYNTHESIZED_WIRE_4,
		 seg_o => hex1,
		 lt_n => LT_sig,
		 blank_n => blank_sig,
		 rbi_n => rbi_sig);

b2v_inst18 : flanken_detekt_vhdl
PORT MAP(data_in => serial_in,
		 clk => clk_6m,
		 reset_n => reset,
		 falling_pulse => SYNTHESIZED_WIRE_6);


b2v_inst6 : bit_counter
GENERIC MAP(width => 4
			)
PORT MAP(clk => clk_6m,
		 reset_n => reset,
		 start_bit => start_bit_sig,
		 baud_tick => baud_tick1,
		 bit_count => bit_count);


b2v_inst7 : uart_controller_fsm
PORT MAP(clk => clk_6m,
		 reset_n => reset,
		 falling_pulse => SYNTHESIZED_WIRE_6,
		 baud_tick => baud_tick1,
		 bit_count => bit_count,
		 parallel_data => bit_data,
		 shift_enable => shift_enable,
		 start_bit => start_bit_sig,
		 data_valid => data_ready);


b2v_inst8 : output_register
GENERIC MAP(width => 10
			)
PORT MAP(clk => clk_6m,
		 data_valid => data_ready,
		 reset_n => reset,
		 parallel_in => bit_data,
		 hex_lsb_out => SYNTHESIZED_WIRE_4,
		 hex_msb_out => SYNTHESIZED_WIRE_3);



END bdf_type;