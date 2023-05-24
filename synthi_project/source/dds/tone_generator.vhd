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
	 fm_ratio	 : IN std_logic_vector(3 downto 0);
	 fm_depth	 : IN std_logic_vector(2 downto 0);
	 algorithm_i : IN std_logic_vector(1 downto 0);
	 
	 atte_f_eq	 : IN std_logic_vector(4 downto 0);
	 atte_v_eq	 : IN std_logic_vector(2 downto 0);
	 enable_eq	 : IN std_logic

    );

end entity tone_generator;

-------------------------------------------------------------------------------

architecture str of tone_generator is

  -----------------------------------------------------------------------------
  -- Internal signal declarations
  -----------------------------------------------------------------------------
	type 		t_dds_o_array is array (0 to 9) of std_logic_vector(N_AUDIO-1 downto 0);
	signal 	dds_o_array : t_dds_o_array;
	signal	dds_o_array_eq : t_dds_o_array;
	SIGNAL	sum_reg, next_sum_reg: signed(N_AUDIO-1 downto 0);
	signal   enable_eq_int, next_enable_eq : std_logic;
	--signal   atte_f_intern : std_logic_vector(4 downto 0);
	--signal	atte_v_intern : std_logic_vector(2 downto 0);
  -----------------------------------------------------------------------------
  -- Component declarations
  -----------------------------------------------------------------------------
--
--  component dds is
--    port (
--      clk_6m     : in  std_logic;
--      reset_n    : in  std_logic;
--      phi_incr   : in  std_logic_vector(N_CUM-1 downto 0);
--      step       : in  std_logic;
--      tone_on	  : in  std_logic;
--      attenu_i   : in  std_logic_vector(2 downto 0);
--      dds_o      : out std_logic_vector(N_AUDIO-1 downto 0));
--  end component dds;
--  
  
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

	 
signal dds_o  : std_logic_vector(N_AUDIO-1 downto 0);

  


begin

  -- instance "dds"
  dds_inst_gen : for i in 0 to 9 generate
    inst_dds : entity work.FM_DDS
      port map (
        clk_6m   => clk_6m,
        reset_n  => rst_n,
        phi_incr => LUT_midi2dds(to_integer(unsigned(note_i(i)))),
        step     => step_i,
        tone_on  => tone_on_i(i),
        attenu_i => velocity_i(i)(6 downto 4),
			fm_ratio => fm_ratio,
			fm_depth => fm_depth,
			algorithm_i => algorithm_i,
        dds_o    => dds_o_array(i)
      );
  end generate dds_inst_gen;
  
  eq_inst_gen : for i in 0 to 9 generate
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
			--enable_eq_int <= '0';
		elsif rising_edge(clk_6m) then
			sum_reg <= next_sum_reg;
			--enable_eq_int <= next_enable_eq;
		end if;
	end process reg_sum_output;
	dds_l_o <= std_logic_vector(sum_reg);
	dds_r_o <= std_logic_vector(sum_reg);

end architecture str;

-------------------------------------------------------------------------------
