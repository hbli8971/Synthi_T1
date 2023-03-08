
--
-- Project     : DT
--
-- File Name   : vhdl_template
-- Description : Template for DT lessons
--
-- Features:     
--
--------------------------------------------------------------------
-- Change History
-- Date     |Name      |Modification
------------|----------|--------------------------------------------
-- 15.10.14 |  dqtm    | file created
-- 15.10.14 |  rosn    | small changes, comments
-- 11.10.19 |  gelk    | adapted for 2025

--------------------------------------------------------------------

-- Library & Use Statements
library ieee;
use ieee.std_logic_1164.all;

-- Entity Declaration 
ENTITY vhdl_hex2sevseg IS
	PORT(
		data_in : IN std_logic_vector(3 downto 0);
		seg_o : OUT std_logic_vector(6 downto 0);
		
		lt_n 	  : IN std_logic := '0';
		blank_n : IN std_logic := '0';
		
		rbi_n   : IN std_logic   := '0';
		rbo_n   : OUT std_logic  := '0'
		
	);
END vhdl_hex2sevseg ;

-- Architecture Declaration 
architecture comb of vhdl_hex2sevseg is

	-- Signals & Constants Declaration
	CONSTANT disp_dark : std_logic_vector(6 downto 0):= "0000000";
	CONSTANT disp_0 : std_logic_vector(6 downto 0):= "0111111";
	CONSTANT disp_1 : std_logic_vector(6 downto 0):= "0000110";
	CONSTANT disp_2 : std_logic_vector(6 downto 0):= "1011011";
	CONSTANT disp_3 : std_logic_vector(6 downto 0):= "1001111";
	CONSTANT disp_4 : std_logic_vector(6 downto 0):= "1100110";
	CONSTANT disp_5 : std_logic_vector(6 downto 0):= "1101101";
	CONSTANT disp_6 : std_logic_vector(6 downto 0):= "1111101";
	CONSTANT disp_7 : std_logic_vector(6 downto 0):= "0000111";
	CONSTANT disp_8 : std_logic_vector(6 downto 0):= "1111111";
	CONSTANT disp_9 : std_logic_vector(6 downto 0):= "1101111";
	CONSTANT disp_a : std_logic_vector(6 downto 0):= "1110111";
	CONSTANT disp_b : std_logic_vector(6 downto 0):= "1111100";
	CONSTANT disp_c : std_logic_vector(6 downto 0):= "0111001";
	CONSTANT disp_d : std_logic_vector(6 downto 0):= "1011110";
	CONSTANT disp_e : std_logic_vector(6 downto 0):= "1111001";
	CONSTANT disp_f : std_logic_vector(6 downto 0):= "1110001";


-- Begin Architecture
begin
hex2seven : PROCESS (all) IS
	BEGIN
		seg_o <= not(disp_dark);
		rbo_n <= '1';
		
		--Check inputs
		IF (blank_n = '1') THEN 
			IF(lt_n = '0') THEN 
				seg_o <= not(disp_8);
			ELSE
				CASE data_in IS
					when x"0" => IF(rbi_n = '1') THEN seg_o <= not(disp_0); ELSE rbo_n <= '0'; END IF;
					when x"1" => seg_o <= not(disp_1);
					when x"2" => seg_o <= not(disp_2);
					when x"3" => seg_o <= not(disp_3);
					when x"4" => seg_o <= not(disp_4);
					when x"5" => seg_o <= not(disp_5);
					when x"6" => seg_o <= not(disp_6);
					when x"7" => seg_o <= not(disp_7);
					when x"8" => seg_o <= not(disp_8);
					when x"9" => seg_o <= not(disp_9);
					when x"a" => seg_o <= not(disp_a);
					when x"b" => seg_o <= not(disp_b);
					when x"c" => seg_o <= not(disp_c);
					when x"d" => seg_o <= not(disp_d);
					when x"e" => seg_o <= not(disp_e);		
					when others => seg_o <= not(disp_f);
				END CASE;
			END IF;
		END IF;
	END PROCESS hex2seven;
END comb;

