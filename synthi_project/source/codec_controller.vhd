--------------------------------------------------------------------
--
-- Project     : Audio_Synth
--
-- File Name   : codec_controller.vhd
-- Description : Controller to define Audio Codec Configuration via I2C
--                                      
-- Features:    Der Baustein wartet bis das reset_n signal inaktiv wird.
--              Danach sendet dieser Codec Konfigurierungsdaten an
--              den Baustein i2c_Master
--                              
--------------------------------------------------------------------
-- Change History
-- Date     |Name      |Modification
------------|----------|--------------------------------------------
-- 06.03.19 | gelk     | Prepared template for students
-- 21.03.23 | gerbedor | added codec control logic
--------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.reg_table_pkg.all;


entity codec_controller is

  port (
    mode         : in  std_logic_vector(2 downto 0);  -- Inputs to choose Audio_MODE
    write_done_i : in  std_logic;       -- Input from i2c register write_done
    ack_error_i  : in  std_logic;       -- Inputs to check the transmission
    clk          : in  std_logic;
    reset_n      : in  std_logic;
    write_o      : out std_logic;       -- Output to i2c to start transmission 
    write_data_o : out std_logic_vector(15 downto 0)  -- Data_Output
    );
end codec_controller;


-- Architecture Declaration
-------------------------------------------
architecture rtl of codec_controller is
-- Signals & Constants Declaration
-------------------------------------------
	type fsm_type is (st_idle, st_wait_write, st_end);
	signal fsm_state, next_fsm_state: fsm_type;
	signal count, next_count : integer;

-- Begin Architecture
-------------------------------------------
begin

-------------------------------------------
-- Process for FlipFlops
-------------------------------------------
	flip_flops : process(all)
		begin
			if reset_n = '0' then
				fsm_state <= st_idle;

			elsif rising_edge(clk) then
				fsm_state <= next_fsm_state;

			end if;
	end process flip_flops;
  
-------------------------------------------
-- Process for Codec Control Automat (FSM)
-------------------------------------------
	Codec_Control_Automat : process(all)
		begin
			-- default statements (hold current value)
			next_fsm_state <= fsm_state;
			count <= 0;

			case fsm_state is
				when st_idle =>
					next_fsm_state <= st_wait_write;
				when st_wait_write =>
					if write_done_i = '1' then
						if count<9 then
							next_count <= count+1;
							next_fsm_state <= st_idle;
						elsif count>=9 or ack_error_i='1' then
							next_fsm_state <= st_end;
						end if;
					end if;
				when others => 
					next_fsm_state <= fsm_state;
			end case;
		end process;
		
-------------------------------------------
-- Process Output Codec Controller
-------------------------------------------
	Codec_Control_Output : process(all)
	begin
		-- default statements
		write_data_o(15 downto 0) <= "0000000000000000"; -- (others => '0');
		write_o <= '0';
	
		case fsm_state is
			when st_idle =>
				write_o <= '1';
			when st_wait_write =>
				case mode is
					when	"001" => write_data_o <= "000" & std_logic_vector(to_unsigned(count, 4)) & C_W8731_ANALOG_BYPASS(count);		
					when 	"011" => write_data_o <= "000" & std_logic_vector(to_unsigned(count, 4)) & C_W8731_ANALOG_MUTE_LEFT(count);
					when	"101" => write_data_o <= "000" & std_logic_vector(to_unsigned(count, 4)) & C_W8731_ANALOG_MUTE_RIGHT(count);
					when	"111"	=> write_data_o <= "000" & std_logic_vector(to_unsigned(count, 4)) & C_W8731_ANALOG_MUTE_BOTH(count);
					when others => write_data_o <= "000" & std_logic_vector(to_unsigned(count, 4)) & C_W8731_ADC_DAC_0DB_48K(count);
				end case;
			when others => NULL;
		end case;
	end process Codec_Control_Output;
	
-- End Architecture 
-------------------------------------------
end rtl;
