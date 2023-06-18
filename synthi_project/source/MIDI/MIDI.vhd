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
	use work.tone_gen_pkg.all;

entity MIDI is
  
  port (
    clk_6m      : in  std_logic;
    reset_n     : in  std_logic;
    rx_data     : in  std_logic_vector(7 downto 0);
    rx_data_rdy : in  std_logic;
    note        : out t_tone_array;
    velocity    : out t_tone_array;
    note_valid	 : out std_logic_vector(9 downto 0)
	 );

end entity MIDI;

architecture rtl of MIDI is

-------------------------------------------
-- Signals & Constants Declaration
-------------------------------------------
	type fsm_type is (st_wait_status, st_wait_data1, st_wait_data2);
	signal fsm_state, next_fsm_state: fsm_type;
	signal status_reg, next_status_reg : std_logic_vector(7 downto 0);
	signal data1_reg, next_data1_reg : std_logic_vector(6 downto 0);
	signal data2_reg, next_data2_reg : std_logic_vector(6 downto 0);
	signal note_on, next_note_on	  : std_logic;
	
	signal reg_tone_on, next_reg_tone_on	: std_logic_vector(9 downto 0);
	signal new_data_flag, next_new_data_flag: std_logic;
	signal reg_note, next_reg_note	: t_tone_array;
	signal reg_velocity, next_reg_velocity : t_tone_array;
	signal output_velocity, output_note : t_tone_array;


begin  -- architecture rtl

-------------------------------------------
-- Process for FlipFlops
-------------------------------------------
  flip_flop: process(all)
  begin  -- process flip_flop
		
		if reset_n = '0' then
			fsm_state <= st_wait_status;
			data1_reg <= (others => '0');
			data2_reg <= (others => '0');
			status_reg <= (others => '0');
			note_on <= '0';
			reg_tone_on <= "0000000000";
			new_data_flag <= '0';
			for i in 0 to 9 loop
				reg_note (i) <= "0000000";
				reg_velocity(i) <= "0000000";
			end loop;
		elsif rising_edge(clk_6m) then
			fsm_state <= next_fsm_state;
			status_reg<= next_status_reg;
			data1_reg <= next_data1_reg;
			data2_reg <= next_data2_reg;
			note_on <= next_note_on;
			new_data_flag <= next_new_data_flag;
			reg_tone_on <= next_reg_tone_on;
			for i in 0 to 9 loop
				reg_note (i) <= next_reg_note(i);
				reg_velocity(i) <= next_reg_velocity(i);
			end loop;
		end if;
		
  end process flip_flop;

-------------------------------------------
-- Process for MIDI_Automat
-------------------------------------------
  MIDI_Automat: process(all)
  
  begin  -- process MIDI_Automat
  
  --------------------------
  -- default statements
  next_note_on 		<= note_on;
  next_status_reg 	<= status_reg;
  next_data1_reg 		<= data1_reg;
  next_data2_reg 		<= data2_reg;
  next_fsm_state 		<= fsm_state;
  next_new_data_flag <= '0';
  
  --------------------------
  
		case fsm_state is
		-------------------------------------------
			when st_wait_status =>
		-------------------------------------------			
	
			if rx_data_rdy = '1' then
				next_status_reg <= rx_data;
				if rx_data(7) = '0' then -- MIDI in running status (no status byte)
					next_data1_reg <= rx_data(6 downto 0);  -- write MIDI-data in data1 register
					if rx_data_rdy = '1'then------------- FEHLER
						next_fsm_state <= st_wait_data2;
					end if;
				else -- MIDI in normal mode (status, data1, data2)
					if rx_data(6 downto 4) = "000" then -- if note off
						next_note_on <= '0';
					elsif rx_data(6 downto 4) = "001" then -- if note on
						next_note_on <= '1';
					end if;
					if (rx_data_rdy = '1') then ---------- FEHLER
						next_fsm_state <= st_wait_data1;
					end if;
				end if;
			end if;
			

		-------------------------------------------
			when st_wait_data1 =>
		-------------------------------------------
				
				if (rx_data_rdy = '1') then
					next_fsm_state <= st_wait_data2;
					next_data1_reg <= rx_data(6 downto 0);  -- write MIDI-data in data1 register
				end if;

		-------------------------------------------
			when st_wait_data2 =>
		-------------------------------------------

				if (rx_data_rdy = '1') then
					next_new_data_flag <= '1';
					next_fsm_state <= st_wait_status;
					next_data2_reg <= rx_data(6 downto 0);  -- write MIDI-data in data2 register
				end if;
		-------------------------------------------
			when others =>
				next_fsm_state <= st_wait_status;
		-------------------------------------------
		end case;
  end process MIDI_Automat;
  

  TEST : process(all)
	variable note_available : std_logic := '0';
	variable note_written	: std_logic := '0';
	

 	begin
	
	--default statements
	next_reg_note		<= reg_note;
	next_reg_velocity	<= reg_velocity;
	next_reg_tone_on	<= reg_tone_on;
	

	
		if (new_data_flag) then
			note_available := '0';
			note_written   := '0';
		-------------------------------------------
		-- CKECK IF NOTE IS ALREADY ENTERED IN MIDI ARRAY
		-------------------------------------------
			for i in 0 to 9 loop
				if reg_note(i) = data1_reg and reg_tone_on(i)='1' then  --found a matchung note
					note_available := '1';
					if status_reg(6 downto 4)= "000" then --note off
						next_reg_tone_on(i) <= '0'; --turn note off
					elsif status_reg(6 downto 4) = "001" and data2_reg = "0000000" then
						next_reg_tone_on(i)<='0'; -- turn off note if velocity is 0
					end if;
				end if;
			end loop;
			

			if note_available='0' then --if there is not yet an entry for the note, look for an emty space and write it
				for i in 0 to 9 loop
					if note_written='0' then -- if the note already written, ignore the remaining loop runs

						if(reg_tone_on(i)='0' or i=9) and status_reg(6 downto 4) = "001" then
							next_reg_note(i) <= data1_reg;
							next_reg_velocity(i) <= data2_reg;
							next_reg_tone_on(i) <= '1';
							note_written := '1';
						end if;
					end if;
				end loop;
			end if;
		end if;
	end process TEST;
  
-------------------------------------------
-- Process Output MIDI
-------------------------------------------
	MIDI_Output : process(all)
	
	begin	-- process MIDI_Output
	for i in 0 to 9 loop
	output_note(i) <= reg_note(i);
	output_velocity(i) <= reg_velocity(i);
	end loop;
	
		note			<= output_note;
		velocity 	<= output_velocity;
		note_valid 	<= reg_tone_on;
	
	end process MIDI_Output;
 
 
-------------------------------------------
end architecture rtl;	-- END Architecture
-------------------------------------------




