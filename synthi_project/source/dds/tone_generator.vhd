-------------------------------------------------------------------------------
-- Title      : tone_generator
-- Project    : 
-------------------------------------------------------------------------------
-- File       : tone_generator.vhd
-- Author     :   <andri@DESKTOP-03G9R51>
-- Company    : 
-- Created    : 2023-04-03
-- Last update: 2023-05-17
-- Platform   : 
-- Standard   : VHDL'08
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-04-03  1.0      andri	Created
-------------------------------------------------------------------------------

library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;
library work;
	use work.tone_gen_pkg.all;


-------------------------------------------------------------------------------

entity tone_generator is


	port (
		tone_on_i   : IN std_logic_vector(9 downto 0);
		note_i      : IN t_tone_array;
		step_i      : IN std_logic;
		velocity_i  : IN t_tone_array;
		clk_6m      : IN std_logic;
		rst_n       : IN std_logic;
		dds_l_o     : OUT std_logic_vector(N_AUDIO-1 downto 0);
		dds_r_o     : OUT std_logic_vector(N_AUDIO-1 downto 0);
		-- EQ
		atte_f_eq	: IN std_logic_vector(4 downto 0);
		atte_v_eq	: IN std_logic_vector(2 downto 0);
		enable_eq	: IN std_logic;
		-- BT
		rx_data		: IN STD_LOGIC_VECTOR(7 downto 0);
		rx_data_rdy	: IN STD_LOGIC;
		algo_mode	: OUT std_logic_vector(3 downto 0)
	);
	 
end entity tone_generator;

-------------------------------------------------------------------------------

architecture str of tone_generator is

  -----------------------------------------------------------------------------
  -- Internal signal declarations
  -----------------------------------------------------------------------------
	TYPE 		t_dds_o_array is array (0 to 9) of std_logic_vector(N_AUDIO-1 downto 0);
	TYPE 		algo_array is array (0 to 9) of std_logic_vector(3 downto 0); -- Algorithm array 
	SIGNAL 	dds_o_array : t_dds_o_array;
	SIGNAL	dds_o_array_eq : t_dds_o_array;
	SIGNAL	sum_reg, next_sum_reg: signed(N_AUDIO-1 downto 0);
	SIGNAL   enable_eq_int, next_enable_eq : std_logic;
	SIGNAL 	dds_o  : std_logic_vector(N_AUDIO-1 downto 0);
	SIGNAL 	sig_algo_mode : algo_array;
	
  -----------------------------------------------------------------------------
  -- Component declarations
  ----------------------------------------------------------------------------- 
	component EQ is
    port (
      sound_in  : in  std_logic_vector(15 downto 0);
      atte_v    : in  std_logic_vector(2 downto 0);
      atte_f    : in  std_logic_vector(4 downto 0);
      f_in      : in  std_logic_vector(18 downto 0);
      enable    : in  std_logic;
      reset_n   : in  std_logic;
      clk       : in  std_logic;
      sound_out : out std_logic_vector(15 downto 0));
  end component EQ;

begin -- architecture of tone_generator
	
	----------------------------------------------------
	-- INSTANCES
	----------------------------------------------------

  gen_inst_FM_DDS : for i in 0 to 9 generate -- generate 10 FM DDS instances
    inst_FM_DDS : entity work.FM_DDS
      port map (
			clk_6m   => clk_6m,
			reset_n  => rst_n,
			phi_incr => LUT_midi2dds(to_integer(unsigned(note_i(i)))),
			step     => step_i,
			tone_on  => tone_on_i(i),
			attenu_i => velocity_i(i)(6 downto 4),
			data			=> rx_data,
			data_rdy		=> rx_data_rdy,
			algo_mode_o	=> sig_algo_mode(i),
			dds_o    => dds_o_array(i)
      );
  end generate gen_inst_FM_DDS;
  
  eq_inst_gen : for i in 0 to 9 generate -- generate 10 EQ instances
	inst_EQ : EQ
		port map(
		sound_in  => dds_o_array(i),  
		atte_v    => atte_v_eq,
		atte_f    => atte_f_eq,
		f_in      => LUT_midi2dds(to_integer(unsigned(note_i(i)))),
		enable    => enable_eq,
		reset_n   => rst_n,
		clk       => clk_6m,
		sound_out => dds_o_array_eq(i)
		);
	end generate eq_inst_gen;
		
		
  
	-------------------------------
	-- Output Process
	-------------------------------
	comb_sum_output : process(all)
		variable var_sum : signed(N_AUDIO-1 downto 0);
		
	begin
		var_sum := (others => '0');
		if step_i = '1' then
			dds_sum_loop : for i in 0 to 9 loop
				var_sum := var_sum + signed(dds_o_array_eq(i));
			end loop dds_sum_loop;
			next_sum_reg <= var_sum;
		else
			next_sum_reg <= sum_reg;
		end if;
	end process comb_sum_output;
	
	
	reg_sum_output : process(all)
 	begin
		if rst_n = '0' then
			sum_reg <= (others => '0');
		elsif rising_edge(clk_6m) then
			sum_reg <= next_sum_reg;
		end if;
	end process reg_sum_output;
	
	dds_l_o <= std_logic_vector(sum_reg);
	dds_r_o <= std_logic_vector(sum_reg);
	algo_mode <= sig_algo_mode(0);

end architecture str;

-------------------------------------------------------------------------------
