-------------------------------------------------------------------------------
-- Title      : EQ
-- Project    : 
-------------------------------------------------------------------------------
-- File       : EQ.vhd
-- Author     :   <mine8@LAPTOP-G548OMQT>
-- Company    : 
-- Created    : 2023-05-03
-- Last update: 2023-05-03
-- Platform   : 
-- Standard   : VHDL'08
-------------------------------------------------------------------------------
-- Description: das isch minner equalizer du gigu :)
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-05-03  1.0      mine8	Created
-------------------------------------------------------------------------------


-- pin and function description 
--
-- Sound_in takes the 16 bit sound signal from dds
-- atte_v sets the attenuation for frequency selected by atte_f
-- atte_f selects the frequency to be set by atte_f
--	f_in is the phi_increment from dds to determin frequency of sound_in
-- enable enables the EQ. If set to 0 sound signal wont be affected
-- reset_n resets the EQ to default values
-- clk clock input (6mhz)
-- sound_out sound signal output (16 bit)
--
-- atte_f frequency selection:
-- 0 = bass_deep; 1 = bass_deep; 2 =bass_low ; 3 = bass_mid; 4 = bass_high;
-- 5 = mid_low; 6 = mid_mid; 7 = mid_high; 8 = mid_vhigh
-- 9 = high_hend; 10 = high_vhend;
--
-- atte_v values from 0 to 7 where 0 is the loudest sound 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


--------------------            -----------------------------------------------------------

entity EQ is
  port (
    sound_in	:	in		std_logic_vector(15 downto 0); -- audio_signal input				-- Internal
    atte_v		:	in		std_logic_vector(2 downto 0);	-- level of attenuation for sound sig	--extern
	atte_f		:	in		std_logic_vector(4 downto 0);	-- what freq gets what atte lvl			--extern
    f_in			:	in  	std_logic_vector(18 downto 0);-- freq of audio in signal				--Internal
	enable		:	in		std_logic;-- enable the EQ (1=on;0=off)									--extern
	reset_n		:	in		std_logic;-- reset the EQ												--Internal
	clk			:	in		std_logic;-- clk for flip flop											--Internal
	sound_out	:	out	std_logic_vector(15 downto 0) -- audio_signal output					--Internal
    );

end entity EQ;

-------------------------------------------------------------------------------

architecture str of EQ is



signal atte_bass_deep , next_bass_deep	: std_logic_vector(2 downto 0);--0 - 40
signal atte_bass_low	 , next_bass_low	: std_logic_vector(2 downto 0);--41 - 80
signal atte_bass_mid	 , next_bass_mid	: std_logic_vector(2 downto 0);--81 - 160
signal atte_bass_high , next_bass_high	: std_logic_vector(2 downto 0);--160 - 300 50
signal atte_mid_low	 , next_mid_low	: std_logic_vector(2 downto 0);--301 - 600
signal atte_mid_mid	 , next_mid_mid	: std_logic_vector(2 downto 0);--601 - 1k2
signal atte_mid_high	 , next_mid_high	: std_logic_vector(2 downto 0);--1201 - 2400 
signal atte_mid_vhigh , next_mid_vhigh	: std_logic_vector(2 downto 0);--2401 - 5000
signal atte_high_hend , next_high_hend	: std_logic_vector(2 downto 0);--5001  - 10000
signal atte_high_vhend, next_high_vhend: std_logic_vector(2 downto 0);--10001 - 20000

-- phi_incr values coresponding to the top frequency of band
constant bass_deep		:	natural :=437; 
constant bass_low			:	natural :=874;			
constant bass_mid			:	natural :=1748;
constant bass_high		:	natural :=3277;
constant mid_low			:	natural :=6554;
constant mid_mid			:	natural :=13107;
constant mid_high			:	natural :=26214;
constant mid_vhigh		:	natural :=54613;
constant high_hend		:	natural :=109227;
constant high_vhend		:	natural :=218453;

  -----------------------------------------------------------------------------
  -- Internal signal declarations
  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  -- Component declarations
  -----------------------------------------------------------------------------

begin  -- architecture str

	EQ_routine : process(all)
	VARIABLE freq_in : integer; --range 0 to 400000;
    begin
		freq_in := to_integer(unsigned(f_in));
		
		
		
		
		
      if(enable = '0') then
			sound_out <= sound_in;
		else 
			if freq_in > high_hend then	-- all over 10khz
				sound_out <= std_logic_vector(shift_right(signed(sound_in),to_integer(unsigned(atte_high_vhend)))); --std_logic_vector(shift_right(lut_val, 1));
			elsif freq_in > mid_vhigh then-- all between 10khz & 5khz
				sound_out <= std_logic_vector(shift_right(signed(sound_in),to_integer(unsigned(atte_high_hend))));
			elsif freq_in > mid_high then  -- 5-2,4
				sound_out <= std_logic_vector(shift_right(signed(sound_in),to_integer(unsigned(atte_mid_vhigh))));
			elsif freq_in > mid_mid then  -- 2,4 - 1,2
				sound_out <= std_logic_vector(shift_right(signed(sound_in),to_integer(unsigned(atte_mid_high))));
			elsif freq_in > mid_low then  -- 1,2 - 600
				sound_out <= std_logic_vector(shift_right(signed(sound_in),to_integer(unsigned(atte_mid_mid))));
			elsif freq_in > bass_high then -- 600-300
				sound_out <= std_logic_vector(shift_right(signed(sound_in),to_integer(unsigned(atte_mid_low))));
			elsif freq_in > bass_mid then --300-160
				sound_out <= std_logic_vector(shift_right(signed(sound_in),to_integer(unsigned(atte_bass_high))));
			elsif freq_in > bass_low then --160 - 80
				sound_out <= std_logic_vector(shift_right(signed(sound_in),to_integer(unsigned(atte_bass_mid))));
			elsif freq_in > bass_deep then --80 - 40
				sound_out <= std_logic_vector(shift_right(signed(sound_in),to_integer(unsigned(atte_bass_low))));
			else	--	all below 40
				sound_out <= std_logic_vector(shift_left(signed(sound_in),to_integer(unsigned(atte_bass_deep))));
			end if;
		end if;
    end process EQ_routine;
	 
	 
	read_n_store_data_routine : process(all)
	VARIABLE atte : integer range 0 to 10;
	 begin
		next_bass_deep		<=		atte_bass_deep	;
		next_bass_low	   <=    atte_bass_low	;	
		next_bass_mid	   <=    atte_bass_mid	;
		next_bass_high	   <=    atte_bass_high	;
		next_mid_low	   <=    atte_mid_low	;
		next_mid_mid	   <=    atte_mid_mid	;
		next_mid_high	   <=    atte_mid_high	;
		next_mid_vhigh	   <=    atte_mid_vhigh	;
		next_high_hend	   <=    atte_high_hend	;
		next_high_vhend   <=    atte_high_vhend;
		atte := to_integer(unsigned(atte_f));
		case atte is
			when 1 =>  next_bass_deep 		<= atte_v;
			when 2 =>  next_bass_low 		<= atte_v;
			when 3 =>  next_bass_mid 		<= atte_v;
			when 4 =>  next_bass_high 		<= atte_v;
			when 5 =>  next_mid_low 		<= atte_v;
			when 6 =>  next_mid_mid 		<= atte_v;
			when 7 =>  next_mid_high 		<= atte_v;
			when 8 =>  next_mid_vhigh 		<= atte_v;
			when 9 =>  next_high_hend 		<= atte_v;
			when 10 => next_high_vhend 	<= atte_v;
			when others => next_bass_deep <= atte_v;
		end case;	 
	end process read_n_store_data_routine;
	
	
	flip_flops : process(all)
  begin
    if reset_n = '0' then
		atte_bass_deep 	<= "011";
		atte_bass_low 		<= "011";
		atte_bass_mid 		<= "011";
		atte_bass_high 	<= "011";
		atte_mid_low		<= "011";
		atte_mid_mid 		<= "011";
		atte_mid_high 		<= "011";
		atte_mid_vhigh 	<= "011";
		atte_high_hend 	<= "011";
		atte_high_vhend 	<= "011";
    elsif rising_edge(clk) then
		atte_bass_deep 	<= next_bass_deep;
		atte_bass_low 		<= next_bass_low;
		atte_bass_mid 		<= next_bass_mid;
		atte_bass_high 	<= next_bass_high;
		atte_mid_low 		<= next_mid_low;
		atte_mid_mid 		<= next_mid_mid;
		atte_mid_high 		<= next_mid_high;
		atte_mid_vhigh 	<= next_mid_vhigh;
		atte_high_hend 	<= next_high_hend;
		atte_high_vhend 	<= next_high_vhend;
    end if;
  end process flip_flops;

  -----------------------------------------------------------------------------
  -- Component instantiations
  -----------------------------------------------------------------------------

end architecture str;

-------------------------------------------------------------------------------
