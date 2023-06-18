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
-- Description: 	Frequency-Modulation-Module to generate different instruments/sounds. 
-- 					Includes four oscillators that use different algorithms. 
--						Different modes are selected with bluetooth.
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
		data			: IN STD_LOGIC_VECTOR(7 downto 0);
		data_rdy		: IN STD_LOGIC;
		algo_mode_o	: out std_logic_vector(3 downto 0):= (others => '0');
		dds_o   		: out std_logic_vector(N_AUDIO-1 downto 0) -- Output Signal
		
	);
end entity FM_DDS;

architecture YEET of FM_DDS is

	-------------------------------------------
	-- Signals & Constants Declaration
	-------------------------------------------
	signal sig_phi_osc_1	: std_logic_vector(N_CUM-1 downto 0);
	signal sig_phi_osc_2	: std_logic_vector(N_CUM-1 downto 0);
	signal sig_phi_osc_3 : std_logic_vector(N_CUM-1 downto 0);
	signal sig_phi_osc_4 : std_logic_vector(N_CUM-1 downto 0);

	signal sig_osc_1		: std_logic_vector(N_AUDIO-1 downto 0);
	signal sig_osc_2		: std_logic_vector(N_AUDIO-1 downto 0);
	signal sig_osc_3		: std_logic_vector(N_AUDIO-1 downto 0);
	signal sig_osc_4		: std_logic_vector(N_AUDIO-1 downto 0);
	
	signal sig_OSC1_f		: std_logic_vector(3 downto 0);
	signal sig_OSC2_f		: std_logic_vector(3 downto 0);
	signal sig_OSC3_f		: std_logic_vector(3 downto 0);
	signal sig_OSC4_f		: std_logic_vector(3 downto 0);
	
	signal sig_OSC1_att	: std_logic_vector(2 downto 0);
	signal sig_OSC2_att	: std_logic_vector(2 downto 0);
	signal sig_OSC3_att	: std_logic_vector(2 downto 0);
	signal sig_OSC4_att	: std_logic_vector(2 downto 0);
	
	signal sig_algo_mode : std_logic_vector(3 downto 0);

	begin  -- architecture FM_DDS

	----------------------------------------------------
	-- INSTANCES
	----------------------------------------------------
	inst_BT_mod: entity work.FM_BT_module -- BLUETOOTH DATA
		port map (
			clk			=> clk_6m,
			reset_n		=> reset_n,
			rx_data		=> data,
			rx_data_rdy	=>	data_rdy,
			algo_mode_o	=> sig_algo_mode,
			f_OSC1_o 	=> sig_OSC1_f,
			f_OSC2_o 	=> sig_OSC2_f,
			f_OSC3_o 	=> sig_OSC3_f,
			f_OSC4_o 	=> sig_OSC4_f,
			att_OSC1_o 	=> sig_OSC1_att,
			att_OSC2_o 	=> sig_OSC2_att,
			att_OSC3_o	=> sig_OSC3_att,
			att_OSC4_o 	=> sig_OSC4_att
		);             

	inst_dds_carrier: entity work.dds -- OSCILLATOR 1
        port map (
            clk_6m     => clk_6m,
            reset_n    => reset_n,
            phi_incr   => sig_phi_osc_1,
            step       => step,
            tone_on    => tone_on,
            attenu_i   => sig_OSC1_att,
            dds_o      => sig_osc_1
        );
		  
	inst_dds_modulator1: entity work.dds -- OSCILLATOR 2
        port map (
            clk_6m     => clk_6m,
            reset_n    => reset_n,
            phi_incr   => sig_phi_osc_2,
            step       => step,
            tone_on    => tone_on,
            attenu_i   => sig_OSC2_att,
            dds_o      => sig_osc_2
        );
		  
	inst_dds_modulator2: entity work.dds -- OSCILLATOR 3
        port map (
            clk_6m     => clk_6m,
            reset_n    => reset_n,
            phi_incr   => sig_phi_osc_3,
            step       => step,
            tone_on    => tone_on,
            attenu_i   => sig_OSC3_att,
            dds_o      => sig_osc_3
        );

	inst_dds_modulator3: entity work.dds -- OSCILLATOR 4
        port map (
            clk_6m     => clk_6m,
            reset_n    => reset_n,
            phi_incr   => sig_phi_osc_4,
            step       => step,
            tone_on    => tone_on,
            attenu_i   => sig_OSC4_att,
            dds_o      => sig_osc_4
        );

	----------------------------------------------------
	-- algorithm mode
	----------------------------------------------------
		phi_carrier: process(all)
		
			VARIABLE algorithm : integer range 0 to 8;
			begin  -- process phi_carrier
				algorithm := to_integer(unsigned(sig_algo_mode));
						
						sig_phi_osc_2 <= std_logic_vector(shift_right(signed(phi_incr), 1));
						sig_phi_osc_3 <= std_logic_vector(shift_right(signed(phi_incr), 1));
						sig_phi_osc_4 <= std_logic_vector(shift_right(signed(phi_incr), 1));
						sig_phi_osc_1 <= phi_incr;
						dds_o <= sig_osc_1;
				
				case algorithm is

					when 0  =>
						-------------------------------------
						-- SINUS (OSC 1)
						-------------------------------------
						sig_phi_osc_1 <= phi_incr;
						dds_o <= sig_osc_1;

				   when 1  => 
						-------------------------------------
						-- ORGEL (car1, car2, car3, car4)
						-------------------------------------
						sig_phi_osc_1 <= phi_incr;
						sig_phi_osc_2 <= std_logic_vector(shift_left(signed(phi_incr), 1));
						sig_phi_osc_3 <= std_logic_vector(shift_left(signed(phi_incr), 2));
						sig_phi_osc_4 <= std_logic_vector(shift_right(signed(phi_incr), 1));
						dds_o <= std_logic_vector(signed(sig_osc_1) + signed(sig_osc_2) + signed(sig_osc_3) + signed(sig_osc_4)); 
					
					when 2  =>
						-------------------------------------
						-- BRASS (car1, mod1, mod2, mod3)
						-------------------------------------
						sig_phi_osc_1 <= std_logic_vector(shift_left(signed(phi_incr)+signed(sig_osc_2), to_integer(unsigned(sig_OSC1_f))));
						sig_phi_osc_2 <= std_logic_vector(shift_left(signed(phi_incr)+signed(sig_osc_3), to_integer(unsigned(sig_OSC2_f))));
						sig_phi_osc_3 <= std_logic_vector(signed(phi_incr) + shift_right(signed(sig_osc_4), to_integer(unsigned(sig_OSC3_f))));
						sig_phi_osc_4 <= std_logic_vector(shift_left(signed(phi_incr), to_integer(unsigned(sig_OSC4_f))));
						
						dds_o <= std_logic_vector(signed(sig_osc_1) + signed(sig_osc_2)); 
						
		         when 3  => -- FM Bluetooth					
						-------------------------------------
						-- BLUETOOTH (car1, car2, mod1, mod2)
						-------------------------------------
						sig_phi_osc_1 <= std_logic_vector(signed(phi_incr) + signed(sig_osc_2));
						sig_phi_osc_2 <= std_logic_vector(signed(phi_incr) + signed(sig_osc_2));
						sig_phi_osc_3 <= std_logic_vector(shift_left(signed(phi_incr), 2));
						sig_phi_osc_4 <= std_logic_vector(shift_right(signed(phi_incr), 1));
						
						
						dds_o <= sig_osc_1;

					when others => -- sinus	
					
						sig_phi_osc_1 <= phi_incr;
						dds_o <= sig_osc_1;
				end case;
	
			end process phi_carrier;
			
	----------------------------------------------------
	-- output
	----------------------------------------------------
		wave_fsm: process(all) 
			begin -- process wave_fsm
				algo_mode_o <= sig_algo_mode;
			end process wave_fsm;

end architecture YEET;

