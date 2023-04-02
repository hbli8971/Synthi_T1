-------------------------------------------------------------------------------
-- Title      : i2s_master
-- Project    : 
-------------------------------------------------------------------------------
-- File       : i2s_master.vhd
-- Author     :   <mine8@LAPTOP-G548OMQT>
-- Company    : 
-- Created    : 2023-03-22
-- Last update: 2023-03-27
-- Platform   : 
-- Standard   : VHDL'08
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-03-22  1.0      mine8	Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------------------------------------------------

entity i2s_master is

  generic (
		width : positive := 16);
  port (
		dacdat_pr_i : IN  std_logic_vector(width-1 downto 0);
		dacdat_pl_i : IN  std_logic_vector(width-1 downto 0);
		clk_6m,reset: IN  std_logic;
		adcdat_s_i	: IN  std_logic;
		dacdat_s_o	: OUT std_logic;
		step_o		: OUT std_logic;
		ws_o			: OUT std_logic;
		adcdat_pl_o	: OUT std_logic_vector(width-1 downto 0);
		adcdat_pr_o	: OUT std_logic_vector(width-1 downto 0)
    );

end entity i2s_master;

-------------------------------------------------------------------------------

architecture str of i2s_master is

  -----------------------------------------------------------------------------
  -- Internal signal declarations
  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  -- Component declarations
  -----------------------------------------------------------------------------

  component i2s_frame_generator is
    generic (
      width : positive);
    port (
      clk_6m           : IN  std_logic;
      rst_n            : IN  std_logic;
      load             : OUT std_logic;
      shift_l, shift_r : OUT std_logic;
      ws               : OUT std_logic);
  end component i2s_frame_generator;

  component uni_shiftreg is
    generic (
      width : positive);
    port (
      load         : in  std_logic;
      enable       : in  std_logic;
      reset        : in  std_logic;
      clock        : in  std_logic;
      serial_in    : in  std_logic;
      parallel_in  : in  std_logic_vector(width-1 downto 0);
      serial_out   : out std_logic;
      parallel_out : out std_logic_vector(width-1 downto 0));
  end component uni_shiftreg;


  component mux_2_1 is
    port (
      a    : in  std_logic;
      b    : in  std_logic;
      ws_o : in  std_logic;
      y    : out std_logic);
  end component mux_2_1;
  
  signal load_intern : std_logic;
  signal ser_l_intern : std_logic;
  signal ser_r_intern : std_logic;
  signal ws_intern	 : std_logic;
  signal LOW_intern   : std_logic;
  signal en_l_intern	 : std_logic;
  signal en_r_intern  : std_logic;
  signal dummy1		 : std_logic_vector(15 downto 0);
  signal dummy2		 : std_logic_vector(15 downto 0);
  signal dummy3		 : std_logic;
  signal dummy4		 : std_logic;
  
begin  -- architecture str
step_o <=load_intern;
ws_o <= ws_intern;
LOW_intern <= '0';
  -----------------------------------------------------------------------------
  -- Component instantiations
  -----------------------------------------------------------------------------

  -- instance "i2s_frame_generator_1"
  i2s_frame_generator_1: i2s_frame_generator
    generic map (
      width => width)
    port map (
      clk_6m  => clk_6m,--
      rst_n   => reset,--
      load    => load_intern,--
      shift_l => en_l_intern,--
      shift_r => en_r_intern,--
      ws      => ws_intern);--

  -- instance "shift_register_1" piso
  uni_shiftreg_1: uni_shiftreg
    generic map (
      width => width)
    port map (
      load         => load_intern,--
      enable       => en_l_intern,--
      reset        => reset,--
      clock        => clk_6m,--
      serial_in    => LOW_intern,--
      parallel_in  => dacdat_pl_i,--
      serial_out   => ser_l_intern,--
      parallel_out => dummy1);--*

		 -- instance "shift_register_2" piso
  uni_shiftreg_2: uni_shiftreg
    generic map (
      width => width)
    port map (
      load         => load_intern,--
      enable       => en_r_intern,--
      reset        => reset,--
      clock        => clk_6m,--
      serial_in    => LOW_intern,--
      parallel_in  => dacdat_pr_i,--
      serial_out   => ser_r_intern,--
      parallel_out => dummy2);--*

		 -- instance "shift_register_3" sipo
  uni_shiftreg_3: uni_shiftreg
    generic map (
      width => width)
    port map (
      load         => load_intern,--
      enable       => en_l_intern,--
      reset        => reset,--
      clock        => clk_6m,--
      serial_in    => adcdat_s_i,--
      parallel_in  => dummy1, --
      serial_out   => dummy3,--*
      parallel_out => adcdat_pl_o);--

		 -- instance "shift_register_4" sipo
  uni_shiftreg_4: uni_shiftreg
    generic map (
      width => width)
    port map (
      load         => load_intern,--
      enable       => en_r_intern,--
      reset        => reset,--
      clock        => clk_6m,--
      serial_in    => adcdat_s_i,--
      parallel_in  => dummy2,
      serial_out   => dummy4,--*
      parallel_out => adcdat_pr_o);--

  -- instance "mux_2_1_1"
  mux_2_1_1: mux_2_1
    port map (
      a    => ser_l_intern,
      b    => ser_r_intern,
      ws_o => ws_intern,
      y    => dacdat_s_o);

end architecture str;

-------------------------------------------------------------------------------
