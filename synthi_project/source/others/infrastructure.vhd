-------------------------------------------------------------------------------
-- Title      : infrastructure
-- Project    : 
-------------------------------------------------------------------------------
-- File       : infrastructure.vhd
-- Author     :   <mine8@LAPTOP-G548OMQT>
-- Company    : 
-- Created    : 2023-03-01
-- Last update: 2023-03-01
-- Platform   : 
-- Standard   : VHDL'08
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-03-01  1.0      mine8	Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------------------------------------------------

entity infrastructure is
  port (
    clock_50 : in STD_LOGIC;
    key_0 : in STD_LOGIC;
    usb_txd : in STD_LOGIC;
    clk_6m : out STD_LOGIC;
	 clk_12m: out STD_LOGIC;
    reset_n : out STD_LOGIC;
    usb_txd_sync : out STD_LOGIC;
	 ledr0 : out STD_LOGIC
    );

end entity infrastructure;

-------------------------------------------------------------------------------

architecture str of infrastructure is

  -----------------------------------------------------------------------------
  -- Internal signal declarations
  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  -- Component declarations
  -----------------------------------------------------------------------------

  component clock_sync is
    port (
      data_in  : in  std_logic;
      clk      : in  std_logic;
      sync_out : out std_logic);
  end component clock_sync;

  component signal_checker is
    port (
      clk, reset_n : in  std_logic;
      data_in      : in  std_logic;
      led_blink    : out std_logic);
  end component signal_checker;

  component modulo_divider is
    port (
      clk    : IN  std_logic;
      clk_6m : OUT std_logic;
		clk_12m : OUT std_logic);
  end component modulo_divider;
  
  SIGNAL	clk_6 :  STD_LOGIC;

begin  -- architecture str

  -----------------------------------------------------------------------------
  -- Component instantiations
  -----------------------------------------------------------------------------
	clk_6m <= clk_6;
  -- instance "clock_sync_1"
  clock_sync_1: clock_sync
    port map (
      data_in  => key_0,
      clk      => clk_6,
      sync_out => reset_n);

  -- instance "signal_checker_1"
  signal_checker_1: signal_checker
    port map (
      clk       => clock_50,
      reset_n   => key_0,
      data_in   => usb_txd,
      led_blink => ledr0
	);

  -- instance "modulo_divider_1"
  modulo_divider_1: modulo_divider
    port map (
      clk    => clock_50,
      clk_6m => clk_6,
		clk_12m => clk_12m);

  -- instance "clock_sync_2"
  clock_sync_2: clock_sync
    port map (
      data_in  => usb_txd,
      clk      => clk_6,
      sync_out => usb_txd_sync);

end architecture str;

-------------------------------------------------------------------------------
