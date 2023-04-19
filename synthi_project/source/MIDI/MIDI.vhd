-------------------------------------------------------------------------------
-- Title      : MIDI Processing
-- Project    : PM2 Synthesizer-Projekt
-------------------------------------------------------------------------------
-- File       : MIDI.vhd
-- Author     : <gerbedor>
-- Company    : 
-- Created    : 2023-04-05
-- Last update: 2023-04-05
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This block converts the MIDI input to be sent to the DDS.
-------------------------------------------------------------------------------
-- Copyright (c) 2023
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author   Description
-- 2023-04-05  1.0      gerbedor Created
-------------------------------------------------------------------------------

library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.numeric_std.all;

entity MIDI is
  
  port (
    clk_6m      : in  std_logic;
    reset_n     : in  std_logic;
    rx_data     : in  std_logic_vector(7 downto 0);
    rx_data_rdy : in  std_logic;
    note        : out std_logic_vector(6 downto 0);
    velocity    : out std_logic_vector(6 downto 0);
    note_valid	 : out std_logic
	 );

end entity MIDI;

architecture rtl of MIDI is

-------------------------------------------
-- Signals & Constants Declaration
-------------------------------------------
	type fsm_type is (st_wait_status, st_wait_data1, st_wait_data2);
	signal fsm_state, next_fsm_state: fsm_type;
	signal data1_reg : std_logic_vector(6 downto 0);
	signal data2_reg : std_logic_vector(6 downto 0);
	signal note_on	  : std_logic;


begin  -- architecture rtl

-------------------------------------------
-- Process for FlipFlops
-------------------------------------------
  flip_flop: process(all)
  begin  -- process flip_flop
		
		if reset_n = '0' then
			fsm_state <= st_wait_status;
			
		elsif rising_edge(clk_6m) then
			fsm_state <= next_fsm_state;
			
		end if;
		
  end process flip_flop;

-------------------------------------------
-- Process for MIDI_Automat
-------------------------------------------
  MIDI_Automat: process(all)
  
  begin  -- process MIDI_Automat
  
  --------------------------
  -- default statements
  note_on <= '0';
  data1_reg <= "0000000";
  data2_reg <= "0000000";
  next_fsm_state <= st_wait_status;
  --------------------------
  
		case fsm_state is
		-------------------------------------------
			when st_wait_status =>
		-------------------------------------------
				if rx_data(7) = '0' then -- MIDI in running status (no status byte)
					data1_reg <= rx_data(6 downto 0);  -- write MIDI-data in data1 register
					if rx_data_rdy = '1' then
						next_fsm_state <= st_wait_data2;
					end if;
				else -- MIDI in normal mode (status, data1, data2)
					if rx_data(6 downto 4) = "000" then -- if note off
						note_on <= '0';
					elsif rx_data(6 downto 4) = "001" then -- if note on
						note_on <= '1';
					end if;
					if (rx_data_rdy = '1') then
						next_fsm_state <= st_wait_data1;
					end if;
				end if;
		-------------------------------------------
			when st_wait_data1 =>
		-------------------------------------------
				data1_reg <= rx_data(6 downto 0);  -- write MIDI-data in data1 register
				if (rx_data_rdy = '1') then
					next_fsm_state <= st_wait_data2;
				end if;
		-------------------------------------------
			when st_wait_data2 =>
		-------------------------------------------
				data2_reg <= rx_data(6 downto 0);  -- write MIDI-data in data2 register
				
				if (rx_data_rdy = '1') then
					next_fsm_state <= st_wait_data2;
				end if;
		-------------------------------------------
			when others =>
				next_fsm_state <= fsm_state;
		-------------------------------------------
		end case;
  end process MIDI_Automat;
  
-------------------------------------------
-- Process Output MIDI
-------------------------------------------
	MIDI_Output : process(all)
	
	begin	-- process MIDI_Output
	
		note 			<= data1_reg;
		velocity 	<= data2_reg;
		note_valid 	<= note_on;
	
	end process MIDI_Output;
 
 
-------------------------------------------
end architecture rtl;	-- END Architecture
-------------------------------------------




