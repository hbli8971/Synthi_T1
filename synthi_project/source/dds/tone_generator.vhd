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
    tone_on_i   : IN std_logic;
    note_i      : IN std_logic_vector(6 downto 0);
    step_i      : IN std_logic;
    velocity_i  : IN std_logic_vector(6 downto 0);
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
  
  -----------------------------------------------------------------------------
  -- Component declarations
  -----------------------------------------------------------------------------

  component dds is
    port (
      clk_6m   : in  std_logic;
      reset_n  : in  std_logic;
      phi_incr : in  std_logic_vector(N_CUM-1 downto 0);
      step     : in  std_logic;
      tone_on  : in  std_logic;
      attenu_i : in  std_logic_vector(2 downto 0);
      dds_o    : out std_logic_vector(N_AUDIO-1 downto 0));
  end component dds;


	 
signal dds_o  : std_logic_vector(N_AUDIO-1 downto 0);


begin

  -- instance "dds_1"
  dds_1: dds
    port map (
      clk_6m   => clk_6m,
      reset_n  => rst_n,
      phi_incr => LUT_midi2dds(to_integer(unsigned(note_i))),
      step     => step_i,
      tone_on  => tone_on_i,
      attenu_i => velocity_i(6 downto 4),
      dds_o    => dds_o);

      dds_l_o <= dds_o;
      dds_r_o <= dds_o;


end architecture str;

-------------------------------------------------------------------------------
