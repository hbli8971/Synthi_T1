-------------------------------------------------------------------------------
-- Title      : Testbench for design "synthi_top"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : synthi_top_tb.vhd
-- Author     :   <mine8@LAPTOP-G548OMQT>
-- Company    : 
-- Created    : 2023-03-15
-- Last update: 2023-03-15
-- Platform   : 
-- Standard   : VHDL'08
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-03-15  1.0      mine8	Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;
use std.textio.all;
use work.simulation_pkg.all;
use work.standard_driver_pkg.all;
use work.user_driver_pkg.all;


-------------------------------------------------------------------------------

entity synthi_top_tb is

end entity synthi_top_tb;

-------------------------------------------------------------------------------

architecture struct of synthi_top_tb is

  component synthi_top is
    port (
      CLOCK_50    : in    std_logic;
      KEY_0       : in    std_logic;
      KEY_1       : in    std_logic;
      SW          : in    std_logic_vector(9 downto 0);
      USB_RXD     : in    std_logic;
      USB_TXD     : in    std_logic;
      BT_RXD      : in    std_logic;
      BT_TXD      : in    std_logic;
      BT_RST_N    : in    std_logic;
      AUD_XCK     : out   std_logic;
      AUD_DACDAT  : out   std_logic;
      AUD_BCLK    : out   std_logic;
      AUD_DACLRCK : out   std_logic;
      AUD_ADCLRCK : out   std_logic;
      AUD_ADCDAT  : in    std_logic;
      AUD_SCLK    : out   std_logic;
      AUD_SDAT    : inout std_logic;
      HEX0        : out   std_logic_vector(6 downto 0);
      HEX1        : out   std_logic_vector(6 downto 0);
      LEDR_0      : out   std_logic;
      LEDR_1      : out   std_logic;
      LEDR_2      : out   std_logic;
      LEDR_3      : out   std_logic;
      LEDR_4      : out   std_logic;
      LEDR_5      : out   std_logic;
      LEDR_6      : out   std_logic;
      LEDR_7      : out   std_logic;
      LEDR_8      : out   std_logic;
      LEDR_9      : out   std_logic);
  end component synthi_top;

  -- component ports
  signal CLOCK_50    : std_logic;
  signal KEY_0       : std_logic;
  signal KEY_1       : std_logic;
  signal SW          : std_logic_vector(9 downto 0);
  signal USB_RXD     : std_logic;
  signal USB_TXD     : std_logic;
  signal BT_RXD      : std_logic;
  signal BT_TXD      : std_logic;
  signal BT_RST_N    : std_logic;
  signal AUD_XCK     : std_logic;
  signal AUD_DACDAT  : std_logic;
  signal AUD_BCLK    : std_logic;
  signal AUD_DACLRCK : std_logic;
  signal AUD_ADCLRCK : std_logic;
  signal AUD_ADCDAT  : std_logic;
  signal AUD_SCLK    : std_logic;
  signal AUD_SDAT    : std_logic;
  signal HEX0        : std_logic_vector(6 downto 0);
  signal HEX1        : std_logic_vector(6 downto 0);
  signal LEDR_0      : std_logic;
  signal LEDR_1      : std_logic;
  signal LEDR_2      : std_logic;
  signal LEDR_3      : std_logic;
  signal LEDR_4      : std_logic;
  signal LEDR_5      : std_logic;
  signal LEDR_6      : std_logic;
  signal LEDR_7      : std_logic;
  signal LEDR_8      : std_logic;
  signal LEDR_9      : std_logic;

  constant clock_freq   : natural := 50_000_000;
  constant clock_period : time    := 1000 ms/clock_freq;

begin  -- architecture struct

  -- component instantiation
  DUT: synthi_top
    port map (
      CLOCK_50    => CLOCK_50,
      KEY_0       => KEY_0,
      KEY_1       => KEY_1,
      SW          => SW,
      USB_RXD     => USB_RXD,
      USB_TXD     => USB_TXD,
      BT_RXD      => BT_RXD,
      BT_TXD      => BT_TXD,
      BT_RST_N    => BT_RST_N,
      AUD_XCK     => AUD_XCK,
      AUD_DACDAT  => AUD_DACDAT,
      AUD_BCLK    => AUD_BCLK,
      AUD_DACLRCK => AUD_DACLRCK,
      AUD_ADCLRCK => AUD_ADCLRCK,
      AUD_ADCDAT  => AUD_ADCDAT,
      AUD_SCLK    => AUD_SCLK,
      AUD_SDAT    => AUD_SDAT,
      HEX0        => HEX0,
      HEX1        => HEX1,
      LEDR_0      => LEDR_0,
      LEDR_1      => LEDR_1,
      LEDR_2      => LEDR_2,
      LEDR_3      => LEDR_3,
      LEDR_4      => LEDR_4,
      LEDR_5      => LEDR_5,
      LEDR_6      => LEDR_6,
      LEDR_7      => LEDR_7,
      LEDR_8      => LEDR_8,
      LEDR_9      => LEDR_9);



  readcmd : process
    -- This process loops through a file and reads one line
    -- at a time, parsing the line to get the values and
    -- expected result.

    variable cmd          : line;  --stores test command
    variable line_in      : line; --stores the to be processed line     
    variable tv           : test_vect; --stores arguments 1 to 4
    variable lincnt       : integer := 0;  --counts line number in testcase file
    variable fail_counter : integer := 0;--counts failed tests



  begin
    -------------------------------------
    -- Open the Input and output files
    -------------------------------------
    FILE_OPEN(cmdfile, "../testcase.dat", read_mode);
    FILE_OPEN(outfile, "../results.dat", write_mode);

    -------------------------------------
    -- Start the loop
    -------------------------------------


    loop

      --------------------------------------------------------------------------
      -- Check for end of test file and print out results at the end
      --------------------------------------------------------------------------


      if endfile(cmdfile) then          -- Check EOF
        end_simulation(fail_counter);
        exit;
      end if;

      --------------------------------------------------------------------------
      -- Read all the argumnents and commands
      --------------------------------------------------------------------------

      readline(cmdfile, line_in);       -- Read a line from the file
      lincnt := lincnt + 1;


      next when line_in'length = 0;     -- Skip empty lines
      next when line_in.all(1) = '#';   -- Skip lines starting with #

      read_arguments(lincnt, tv, line_in, cmd);
      tv.clock_period := clock_period;  -- set clock period for driver calls

      -------------------------------------
      -- Reset the circuit
      -------------------------------------

      if cmd.all = "reset_target" then
        rst_sim(tv, key_0);
      elsif cmd.all = "run_simulation_for" then
        run_sim(tv);
      elsif cmd.all = "uart_send_data" then
        uar_sim(tv, USB_TXD); 
      elsif cmd.all = "check_display_hex0" then
        hex_chk(tv, hex0);
      elsif cmd.all = "check_display_hex0" then
        hex_chk(tv, hex0);
      elsif cmd.all = "check_display_hex1" then
        hex_chk(tv, hex1);

        -- add further test commands below here


      else
        assert false
          report "NO MATCHING COMMAND FOUND IN 'testcase.dat' AT LINE: "& integer'image(lincnt)
          severity error;
      end if;

      if tv.fail_flag = true then --count failures in tests
        fail_counter := fail_counter + 1;
      else fail_counter := fail_counter;
      end if;

    end loop; --finished processing command line

    wait; -- to avoid infinite loop simulator warning

  end process;

  clkgen : process
  begin
    clock_50 <= '0';
    wait for clock_period/2;
    clock_50 <= '1';
    wait for clock_period/2;

  end process clkgen;

  

end architecture struct;

-------------------------------------------------------------------------------