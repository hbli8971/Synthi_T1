-------------------------------------------------------------------------------
-- Title      : tone_generator
-- Project    : 
-------------------------------------------------------------------------------
-- File       : tone_generator.vhd
-- Author     :   <andri@DESKTOP-03G9R51>
-- Company    : 
-- Created    : 2023-04-03
-- Last update: 2023-04-11
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
    dds_r_o     : OUT std_logic_vector(N_AUDIO-1 downto 0)

    );

end entity tone_generator;

-------------------------------------------------------------------------------

architecture str of tone_generator is

  -----------------------------------------------------------------------------
  -- Internal signal declarations
  -----------------------------------------------------------------------------
	type 		t_dds_o_array is array (0 to 9) of std_logic_vector(N_AUDIO-1 downto 0);
	signal 	dds_o_array : t_dds_o_array;
	SIGNAL	sum_reg, next_sum_reg:		unsigned(N_AUDIO-1 downto 0);
  -----------------------------------------------------------------------------
  -- Component declarations
  -----------------------------------------------------------------------------

  component dds is
    port (
      clk_6m     : in  std_logic;
      reset_n    : in  std_logic;
      phi_incr   : in  std_logic_vector(N_CUM-1 downto 0);
      step       : in  std_logic;
      tone_on	  : in  std_logic;
      attenu_i   : in  std_logic_vector(2 downto 0);
      dds_o      : out std_logic_vector(N_AUDIO-1 downto 0));
  end component dds;


	 
signal dds_o  : std_logic_vector(N_AUDIO-1 downto 0);


begin

  -- instance "dds"
  dds_inst_gen : for i in 0 to 9 generate
    inst_dds : dds
      port map (
        clk_6m   => clk_6m,
        reset_n  => rst_n,
        phi_incr => LUT_midi2dds(to_integer(unsigned(note_i(i)))),
        step     => step_i,
        tone_on  => tone_on_i(i),
        attenu_i => velocity_i(i)(6 downto 4),
        dds_o    => dds_o_array(i)

        --dds_l_o <= dds_o;
        --dds_r_o <= dds_o;
      );
  end generate dds_inst_gen;
  
	-------------------------------
	-- Output Process
	-------------------------------
	comb_sum_output : process(all)
		variable var_sum : signed(N_AUDIO-1 downto 0);
		
	begin
		var_sum := (others => '0');
		if step_i = '1' then
			dds_sum_loop : for i in 0 to 9 loop
				var_sum := var_sum + signed(dds_o_array(i));
			end loop dds_sum_loop;
			next_sum_reg <= sum_reg;
		else
			next_sum_reg <= sum_reg;
		end if;
	end process comb_sum_output;
	
	reg_sum_output : process(clk_6m, rst_n)
 	begin
		if rst_n = '0' then
			sum_reg <= (others => '0');
		elsif rising_edge(clk_6m) then
			sum_reg <= next_sum_reg;
		end if;
	

	
	end process reg_sum_output;
	
	dds_l_o <= std_logic_vector(sum_reg);
	dds_r_o <= std_logic_vector(sum_reg);

end architecture str;

-------------------------------------------------------------------------------
