-------------------------------------------------------------------------------
-- Title      : FM DDS
-- Project    : 
-------------------------------------------------------------------------------
-- File       : FM_DDS.vhd
-- Author     : gerbedor
-- Company    : 
-- Created    : 2023-05-03
-- Last update: 2023-05-10
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 	Frequency Modulation Module to generate funky sounds. 
-- 					Includes Carrier and Modulator component and operation to add 
--						them togehter
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-05-03  1.0      gerbedor	Created
-------------------------------------------------------------------------------

library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;
library work;
	use work.tone_gen_pkg.all;

entity FM_DDS is
  port (
		clk_6m    	: in std_logic;
		reset_n   	: in std_logic;
		phi_incr  	: in std_logic_vector(N_CUM-1 downto 0);
		step      	: in std_logic;
		tone_on   	: in std_logic;
		attenu_i  	: in std_logic_vector(2 downto 0);
		fm_ratio		: in std_logic_vector(3 downto 0);
		fm_depth		: in std_logic_vector(2 downto 0);
		algorithm_i : in std_logic_vector(1 downto 0);
--		BT_data		: in std_logic_vector(7 downto 0);
		dds_o   		: out std_logic_vector(N_AUDIO-1 downto 0)
	);
end entity FM_DDS;

architecture YEET of FM_DDS is

	-------------------------------------------
	-- Signals & Constants Declaration
	-------------------------------------------
	signal sig_phi_mod	: std_logic_vector(N_CUM-1 downto 0);
	signal sig_phi_car	: std_logic_vector(N_CUM-1 downto 0);
	signal sig_phi_mod_1	: std_logic_vector(N_CUM-1 downto 0);
	signal sig_phi_mod_2 : std_logic_vector(N_CUM-1 downto 0);
	signal sig_phi_mod_3 : std_logic_vector(N_CUM-1 downto 0);
	signal sig_mod			: std_logic_vector(N_AUDIO-1 downto 0);
	signal sig_car			: std_logic_vector(N_AUDIO-1 downto 0);
	signal sig_mod_1		: std_logic_vector(N_AUDIO-1 downto 0);
	signal sig_mod_2		: std_logic_vector(N_AUDIO-1 downto 0);
	signal sig_mod_3		: std_logic_vector(N_AUDIO-1 downto 0);

	----------------------------------------------------
	-- COMPONENTS
	----------------------------------------------------
--	component FM_BT_module is
--		port (
--			clk_6m    	: in std_logic;
--			reset_n   	: in std_logic
--			--BT_data_i	: in std_logic_vector(15 downto 0);
--			--BT_data_o	: out std_logic_vector(15 downto 0)
--		);
--	end component FM_BT_module;

	begin  -- architecture FM_DDS

	----------------------------------------------------
	-- INSTANCES
	----------------------------------------------------
--	inst_BT_mod: FM_BT_module -- BT MODULE
--		port map (
--			clk_6m     	=> clk_6m,
--			reset_n    	=> reset_n
--			--BT_data_i 	=> BT_data,
--			--BT_data_o	=> …
--		);

	inst_dds_carrier: entity work.dds -- OSC1
        port map (
            clk_6m     => clk_6m,
            reset_n    => reset_n,
            phi_incr   => sig_phi_car,
            step       => step,
            tone_on    => tone_on,
            attenu_i   => attenu_i,
            dds_o      => sig_car
        );
		  
	inst_dds_modulator1: entity work.dds -- OSC2
        port map (
            clk_6m     => clk_6m,
            reset_n    => reset_n,
            phi_incr   => sig_phi_mod_1,
            step       => step,
            tone_on    => tone_on,
            attenu_i   => fm_depth,
            dds_o      => sig_mod_1
        );
		  
	inst_dds_modulator2: entity work.dds -- OSC3
        port map (
            clk_6m     => clk_6m,
            reset_n    => reset_n,
            phi_incr   => sig_phi_mod_2,
            step       => step,
            tone_on    => tone_on,
            attenu_i   => fm_depth,
            dds_o      => sig_mod_2
        );

	inst_dds_modulator3: entity work.dds -- OSC4
        port map (
            clk_6m     => clk_6m,
            reset_n    => reset_n,
            phi_incr   => sig_phi_mod_3,
            step       => step,
            tone_on    => tone_on,
            attenu_i   => fm_depth,
            dds_o      => sig_mod_3
        );

	----------------------------------------------------
	-- algorithm mode
	----------------------------------------------------
		phi_carrier: process(all)
			VARIABLE algorithm : integer range 0 to 8;
			begin  -- process phi_carrier
				algorithm := to_integer(unsigned(algorithm_i));
						
						sig_phi_mod_1 <= std_logic_vector(shift_right(signed(phi_incr), 1));
						sig_phi_mod_2 <= std_logic_vector(shift_right(signed(phi_incr), 1));
						sig_phi_mod_3 <= std_logic_vector(shift_right(signed(phi_incr), 1));
						sig_phi_car <= phi_incr;
						dds_o <= sig_car;
				
				case algorithm is
						-------------------------------------
						-- SINUS (OSC 1)
						-------------------------------------
					when 0  =>
				
						sig_phi_car <= phi_incr;
						dds_o <= sig_car;
						-------------------------------------
						-- ORGEL (car1, car2, car3, car4)
						-------------------------------------
				   when 1  =>
						
						sig_phi_car <= phi_incr;
						sig_phi_mod_1 <= std_logic_vector(shift_left(signed(phi_incr), 1));
						sig_phi_mod_2 <= std_logic_vector(shift_left(signed(phi_incr), 2));
						sig_phi_mod_3 <= std_logic_vector(shift_right(signed(phi_incr), 1));
						dds_o <= std_logic_vector(signed(sig_car) + signed(sig_mod_1) + signed(sig_mod_2) + signed(sig_mod_3)); 
						
			      when 2  => -- FM mod 1 						
						
						sig_phi_mod_1 <= std_logic_vector(signed(phi_incr) + signed(sig_mod_2));
						sig_phi_mod_2 <= std_logic_vector(shift_left(signed(phi_incr), 2));
						sig_phi_mod_3 <= std_logic_vector(shift_right(signed(phi_incr), 1));
						sig_phi_car <= std_logic_vector(signed(phi_incr) + signed(sig_mod_1));
						dds_o <= sig_car;
						
		         when 3  => -- FM mod 2						
						
						sig_phi_mod_2 <= std_logic_vector(shift_left(signed(phi_incr), 2));
						sig_phi_mod_3 <= std_logic_vector(shift_right(signed(phi_incr), 1));
						sig_phi_mod_1 <= std_logic_vector(signed(phi_incr) + signed(sig_mod_1));
						sig_phi_car <= std_logic_vector(signed(phi_incr) + signed(sig_mod_1));
						dds_o <= sig_car;

					when others => -- sinus						

						sig_phi_mod_1 <= std_logic_vector(shift_left(signed(phi_incr), 1));
						sig_phi_mod_2 <= std_logic_vector(shift_left(signed(phi_incr), 2));
						sig_phi_mod_3 <= std_logic_vector(shift_right(signed(phi_incr), 1));
						sig_phi_car <= phi_incr;
						dds_o <= sig_car;
				end case;
	
			end process phi_carrier;
			
	----------------------------------------------------
	-- output
	----------------------------------------------------
		wave_fsm: process(all) 
			begin -- process wave_fsm
			
			end process wave_fsm;

end architecture YEET;

