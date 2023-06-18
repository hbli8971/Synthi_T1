-------------------------------------------------------------------------------
-- Title      : Bluetooth Module FM
-- Project    : 
-------------------------------------------------------------------------------
-- File       : FM_BT_modul.vhd
-- Author     : gerbedor
-- Company    : 
-- Created    : 2023-05-03
-- Last update: 2023-05-10
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 	Receives BT data and evaluates if data is needed for FM 
-- 					if so data is sent to FM. 
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-05-23  1.0      gerbedor	Created
-------------------------------------------------------------------------------

library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;
library work;
	use work.tone_gen_pkg.all;

entity FM_BT_module is
	port (
			clk			: in STD_LOGIC;
			reset_n		: in STD_LOGIC;
			rx_data		: in STD_LOGIC_VECTOR(7 downto 0); 	-- BT Data
			rx_data_rdy	: in STD_LOGIC;
			algo_mode_o	: out std_logic_vector(3 downto 0);
			f_OSC1_o 	: out std_logic_vector(3 downto 0);
			f_OSC2_o 	: out std_logic_vector(3 downto 0);
			f_OSC3_o 	: out std_logic_vector(3 downto 0);
			f_OSC4_o 	: out std_logic_vector(3 downto 0);
			att_OSC1_o 	: out std_logic_vector(2 downto 0);
			att_OSC2_o 	: out std_logic_vector(2 downto 0);
			att_OSC3_o	: out std_logic_vector(2 downto 0);
			att_OSC4_o 	: out std_logic_vector(2 downto 0)
	);
  end entity FM_BT_module;

architecture YEET of FM_BT_module is

	-------------------------------------------
	-- Internal type/signal declarations
	-------------------------------------------
	type fsm_type is (st_idle, st_byte1, st_byte2);  -- st_check_rx is also used for storage
	
	signal fsm_state, next_fsm_state : fsm_type;
	signal ctrl_reg, next_ctrl_reg, data1_reg, next_data1_reg, data2_reg, next_data2_reg : STD_LOGIC_VECTOR(7 downto 0);
	signal data_rdy, next_data_rdy	: STD_LOGIC;
	signal algo_mode, next_algo_mode : std_logic_vector(3 downto 0);
	
	signal f_OSC1, next_f_OSC1, f_OSC2, next_f_OSC2, f_OSC3, next_f_OSC3, f_OSC4, next_f_OSC4 : STD_LOGIC_VECTOR(3 downto 0); -- Osclillator frequencies
	signal att_OSC1, next_att_OSC1, att_OSC2, next_att_OSC2, att_OSC3, next_att_OSC3, att_OSC4, next_att_OSC4 : STD_LOGIC_VECTOR(2 downto 0); -- Osclillator attenuate
	
	BEGIN -- architecture of FM_BT_module
	
	-------------------------------------------
	-- Process for FlipFlop
	-------------------------------------------
	flip_flops : process(all)
	begin
		if reset_n = '0' then
			fsm_state 	<= st_idle;
			ctrl_reg 	<= x"80";
			data1_reg 	<= x"00";
			data2_reg 	<= x"00";
			data_rdy		<= '0';
			f_OSC1 <= X"0";
			f_OSC2 <= X"0";
			f_OSC3 <= X"0";
			f_OSC4 <= X"0";
			att_OSC1 <= "000";
			att_OSC2 <= "000";
			att_OSC3 <= "000";
			att_OSC4 <= "000";
		elsif rising_edge(clk) then
			fsm_state 	<= next_fsm_state;
			ctrl_reg  	<= next_ctrl_reg;
			data1_reg 	<= next_data1_reg;
			data2_reg 	<= next_data2_reg;
			data_rdy		<= next_data_rdy;
			algo_mode 	<= next_algo_mode;
			f_OSC1 		<= next_f_OSC1;
			f_OSC2 		<= next_f_OSC2;
         f_OSC3 		<= next_f_OSC3;
			f_OSC4 		<= next_f_OSC4;
			att_OSC1 	<= next_att_OSC1;
			att_OSC2 	<= next_att_OSC2;
			att_OSC3 	<= next_att_OSC3;
			att_OSC4 	<= next_att_OSC4;
    end if;
  end process flip_flops;
  
 	-------------------------------------------
	-- Process for receiving bluetooth data
	-------------------------------------------
   state_logic : process (all)
	begin
    -- default statements (hold current value)
    next_fsm_state 	<= fsm_state;
	 next_ctrl_reg 	<= ctrl_reg;
	 next_data1_reg 	<= data1_reg;
	 next_data2_reg 	<= data2_reg;
	 next_data_rdy  	<= data_rdy;
	 
	if data_rdy = '1' then 
		next_data_rdy <= '0'; 
	end if;
	 
		case fsm_state is
			when st_idle =>
				if rx_data_rdy then
					next_ctrl_reg <= rx_data; -- control byte (1 Byte)
					next_fsm_state <= st_byte1;
				end if;
       
			when st_byte1 => 
			
				if rx_data_rdy then 
					next_data1_reg <= rx_data; -- data 1 (1 Byte)
					next_fsm_state <= st_byte2;
				end if;
          
			when st_byte2 =>
			
				if rx_data_rdy then 
					next_data2_reg <= rx_data; -- data 2 (1 Byte)
					next_data_rdy <= '1';
					next_fsm_state <= st_idle;
				end if;
			
			when others =>
				next_fsm_state <= fsm_state;

		end case;
	end process state_logic;

	-------------------------------------------
	-- Process for bluetooth data logic
	-------------------------------------------
	BT_logic: process(all)
	
		begin  -- process BT_logic
		
		-- default statements (hold current value)
		next_algo_mode <= algo_mode;
		next_f_OSC1 <= f_OSC1;
		next_f_OSC2 <= f_OSC2;
		next_f_OSC3 <= f_OSC3;
		next_f_OSC4 <= f_OSC4;
		next_att_OSC1 <= att_OSC1;
		next_att_OSC2 <= att_OSC2;
		next_att_OSC3 <= att_OSC3;
		next_att_OSC4 <= att_OSC4;
		
		next_f_OSC1 <= "0000";
		next_f_OSC2 <= "0000";
		next_f_OSC3 <= "0000";
      next_f_OSC4 <= "0000";
		next_att_OSC1 <= "000";
		next_att_OSC2 <= "000";
		next_att_OSC3 <= "000";
		next_att_OSC4 <= "000";
		
		if (data_rdy = '1') then
			case ctrl_reg is
				when X"80" => -- select algorithm mode
					next_algo_mode <= data1_reg(3 downto 0);
					
				when X"F1" => -- select oscillator 1 frequency
					next_f_OSC1 <= data1_reg(3 downto 0);
				
				when X"F2" => -- select oscillator 2 frequency
					next_f_OSC2 <= data1_reg(3 downto 0);
					
				when X"F3" => -- select oscillator 3 frequency
					next_f_OSC3 <= data1_reg(3 downto 0);
					
				when X"F4" => -- select oscillator 4 frequency
					next_f_OSC4 <= data1_reg(3 downto 0);
					
				when X"A1" => -- select oscillator 1 attenuate
					next_att_OSC1 <= data1_reg(2 downto 0);
					
				when X"A2" => -- select oscillator 2 attenuate
					next_att_OSC2 <= data1_reg(2 downto 0);
					
				when X"A3" => -- select oscillator 3 attenuate
					next_att_OSC3 <= data1_reg(2 downto 0);
					
				when X"A4" => -- select oscillator 4 attenuate
					next_att_OSC4 <= data1_reg(2 downto 0);
				when others => 
					next_algo_mode <= algo_mode;
					next_f_OSC1 <= f_OSC1;
					next_f_OSC2 <= f_OSC2;
					next_f_OSC3 <= f_OSC3;
					next_f_OSC4 <= f_OSC4;
					next_att_OSC1 <= att_OSC1;
					next_att_OSC2 <= att_OSC2;
					next_att_OSC3 <= att_OSC3;
					next_att_OSC4 <= att_OSC4;
			end case;
		end if;
		
		-- Write data to output
		
		algo_mode_o <= algo_mode;
		
		f_OSC1_o	<= f_OSC1;
		f_OSC2_o	<= f_OSC2;
		f_OSC3_o	<= f_OSC3;
		f_OSC4_o	<= f_OSC4;
		
		att_OSC1_o	<= att_OSC1;
		att_OSC2_o	<= att_OSC2;
		att_OSC3_o	<= att_OSC3;
		att_OSC4_o	<= att_OSC4;
		
	end process BT_logic;

end architecture YEET;