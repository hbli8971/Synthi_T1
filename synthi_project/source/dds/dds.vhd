-------------------------------------------------------------------------------
-- Title      : dds
-- Project    : 
-------------------------------------------------------------------------------
-- File       : dds.vhd
-- Author     : 
-- Company    : 
-- Created    : 2023-04-03
-- Last update: 2023-04-15
-- Platform   : 
-- Standard   : VHDL'08
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-04-03  1.0      andri	  Created
------------------------------------------------------------------------------- 

library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;
library work;
	use work.tone_gen_pkg.all;

-------------------------------------------------------------------------------

entity dds is
	port (
		clk_6m    : in std_logic;
		reset_n   : in std_logic;
		phi_incr  : in std_logic_vector(N_CUM-1 downto 0);
		step      : in std_logic;
		tone_on   : in std_logic;
		attenu_i  : in std_logic_vector(2 downto 0);
		dds_o     : out std_logic_vector(N_AUDIO-1 downto 0)
	);
end entity dds;

-------------------------------------------------------------------------------

architecture rtl of dds is

	SIGNAL 	count, next_count, count_o: 	unsigned(N_CUM-1 downto 0);
	SIGNAL   lut_val  :	signed(N_AUDIO-1 downto 0);
	type		t_dds_o_array is array (0 to 9) of std_logic_vector(N_AUDIO-1 downto 0);



begin
	
	-------------------------------
	-- FlipFlop Process
	-------------------------------
	flip_flops : PROCESS(all)
	BEGIN
		IF reset_n = '0' THEN
			count <= to_unsigned(0,N_CUM);
		ELSIF rising_edge(clk_6m) THEN
			count <= next_count;
		END IF;
	END PROCESS flip_flops;
	
	-------------------------------
	-- Phase Counter Process
	-------------------------------
	counter_register : PROCESS(all)
		VARIABLE lut_addr : integer range 0 to L-1;
	BEGIN
	
		IF (step = '1') THEN
			next_count <= count + unsigned(phi_incr);
      ELSE
			next_count <= count;
		END IF;
    
		lut_addr	:= to_integer(count_o(N_CUM-1 downto N_CUM - N_LUT));
		lut_val 	<= to_signed(LUT(lut_addr), N_AUDIO);
		
	END PROCESS counter_register;

	-------------------------------
	-- Attenuator Process
	-------------------------------
	attenuator : PROCESS(all)
		VARIABLE atte : integer range 0 to 8;

	BEGIN
		atte := to_integer(unsigned(attenu_i));
	
		case atte is
			when 7      => dds_o <= std_logic_vector(lut_val);
			when 6      => dds_o <= std_logic_vector(shift_right(lut_val, 1));
			when 5      => dds_o <= std_logic_vector(shift_right(lut_val, 2));
			when 4      => dds_o <= std_logic_vector(shift_right(lut_val, 3));
			when 3      => dds_o <= std_logic_vector(shift_right(lut_val, 4));
			when 2      => dds_o <= std_logic_vector(shift_right(lut_val, 5));
			when 1      => dds_o <= std_logic_vector(shift_right(lut_val, 6));
			when others => dds_o <= std_logic_vector(shift_right(lut_val, 7));
		end case;
		
	END PROCESS attenuator;

	-------------------------------
	-- Output Process
	-------------------------------
	output_logic : process(all)
   BEGIN
		if tone_on = '1' then
			count_o <= count;
		else
			count_o <= (others => '0');
		end if;
	END PROCESS output_logic;
	
-------------------------------------------------------------------------------
end architecture rtl; 
-------------------------------------------------------------------------------
