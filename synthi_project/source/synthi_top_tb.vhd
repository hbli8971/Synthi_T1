-------------------------------------------------------------------------------
-- Title      : Testbench for design "synthi_top"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : synthi_top_tb.vhd
-- Author     :   <mine8@LAPTOP-G548OMQT>
-- Company    : 
-- Created    : 2023-03-15
-- Last update: 2023-03-22
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

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.ALL;
USE std.textio.ALL;
USE work.simulation_pkg.ALL;
USE work.standard_driver_pkg.ALL;
USE work.user_driver_pkg.ALL;
-------------------------------------------------------------------------------

ENTITY synthi_top_tb IS

END ENTITY synthi_top_tb;

-------------------------------------------------------------------------------

ARCHITECTURE struct OF synthi_top_tb IS

  COMPONENT synthi_top IS
    PORT (
      CLOCK_50 : IN STD_LOGIC;
      KEY_0 : IN STD_LOGIC;
      KEY_1 : IN STD_LOGIC;
      SW : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
      USB_RXD : IN STD_LOGIC;
      USB_TXD : IN STD_LOGIC;
      BT_RXD : IN STD_LOGIC;
      BT_TXD : IN STD_LOGIC;
      BT_RST_N : IN STD_LOGIC;
      AUD_XCK : OUT STD_LOGIC;
      AUD_DACDAT : OUT STD_LOGIC;
      AUD_BCLK : OUT STD_LOGIC;
      AUD_DACLRCK : OUT STD_LOGIC;
      AUD_ADCLRCK : OUT STD_LOGIC;
      AUD_ADCDAT : IN STD_LOGIC;
      AUD_SCLK : OUT STD_LOGIC;
      AUD_SDAT : INOUT STD_LOGIC;
      HEX0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
      HEX1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
      LEDR_0 : OUT STD_LOGIC;
      LEDR_1 : OUT STD_LOGIC;
      LEDR_2 : OUT STD_LOGIC;
      LEDR_3 : OUT STD_LOGIC;
      LEDR_4 : OUT STD_LOGIC;
      LEDR_5 : OUT STD_LOGIC;
      LEDR_6 : OUT STD_LOGIC;
      LEDR_7 : OUT STD_LOGIC;
      LEDR_8 : OUT STD_LOGIC;
      LEDR_9 : OUT STD_LOGIC);
  END COMPONENT synthi_top;

  -- component ports
  SIGNAL CLOCK_50 : STD_LOGIC;
  SIGNAL KEY_0 : STD_LOGIC;
  SIGNAL KEY_1 : STD_LOGIC;
  SIGNAL SW : STD_LOGIC_VECTOR(9 DOWNTO 0);
  SIGNAL USB_RXD : STD_LOGIC;
  SIGNAL USB_TXD : STD_LOGIC;
  SIGNAL BT_RXD : STD_LOGIC;
  SIGNAL BT_TXD : STD_LOGIC;
  SIGNAL BT_RST_N : STD_LOGIC;
  SIGNAL AUD_XCK : STD_LOGIC;
  SIGNAL AUD_DACDAT : STD_LOGIC;
  SIGNAL AUD_BCLK : STD_LOGIC;
  SIGNAL AUD_DACLRCK : STD_LOGIC;
  SIGNAL AUD_ADCLRCK : STD_LOGIC;
  SIGNAL AUD_ADCDAT : STD_LOGIC;
  SIGNAL AUD_SCLK : STD_LOGIC;
  SIGNAL AUD_SDAT : STD_LOGIC;
  SIGNAL HEX0 : STD_LOGIC_VECTOR(6 DOWNTO 0);
  SIGNAL HEX1 : STD_LOGIC_VECTOR(6 DOWNTO 0);
  SIGNAL LEDR_0 : STD_LOGIC;
  SIGNAL LEDR_1 : STD_LOGIC;
  SIGNAL LEDR_2 : STD_LOGIC;
  SIGNAL LEDR_3 : STD_LOGIC;
  SIGNAL LEDR_4 : STD_LOGIC;
  SIGNAL LEDR_5 : STD_LOGIC;
  SIGNAL LEDR_6 : STD_LOGIC;
  SIGNAL LEDR_7 : STD_LOGIC;
  SIGNAL LEDR_8 : STD_LOGIC;
  SIGNAL LEDR_9 : STD_LOGIC;
  SIGNAL gpi_signals : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL reg_data0 : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL reg_data1 : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL reg_data2 : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL reg_data3 : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL reg_data4 : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL reg_data5 : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL reg_data6 : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL reg_data7 : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL reg_data8 : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL reg_data9 : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL dacdat_check : std_logic_vector(31 downto 0);
  SIGNAL I2C_SCLK : STD_LOGIC;
  SIGNAL I2C_SDAT : STD_LOGIC;
  CONSTANT clock_freq : NATURAL := 50_000_000;
  CONSTANT clock_period : TIME := 1000 ms/clock_freq;

  COMPONENT i2c_slave_bfm IS
    GENERIC (
      verbose : BOOLEAN);
    PORT (
      AUD_XCK : IN STD_LOGIC;
      I2C_SDAT : INOUT STD_LOGIC := 'H';
      I2C_SCLK : INOUT STD_LOGIC := 'H';
      reg_data0 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      reg_data1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      reg_data2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      reg_data3 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      reg_data4 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      reg_data5 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      reg_data6 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      reg_data7 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      reg_data8 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      reg_data9 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
  END COMPONENT i2c_slave_bfm;
BEGIN -- architecture struct

  -- component instantiation
  DUT : synthi_top
  PORT MAP(
    CLOCK_50 => CLOCK_50,
    KEY_0 => KEY_0,
    KEY_1 => KEY_1,
    SW => SW,
    USB_RXD => USB_RXD,
    USB_TXD => USB_TXD,
    BT_RXD => BT_RXD,
    BT_TXD => BT_TXD,
    BT_RST_N => BT_RST_N,
    AUD_XCK => AUD_XCK,
    AUD_DACDAT => AUD_DACDAT,
    AUD_BCLK => AUD_BCLK,
    AUD_DACLRCK => AUD_DACLRCK,
    AUD_ADCLRCK => AUD_ADCLRCK,
    AUD_ADCDAT => AUD_ADCDAT,
    AUD_SCLK => I2C_SCLK,
    AUD_SDAT => I2C_SDAT,
    HEX0 => HEX0,
    HEX1 => HEX1,
    LEDR_0 => LEDR_0,
    LEDR_1 => LEDR_1,
    LEDR_2 => LEDR_2,
    LEDR_3 => LEDR_3,
    LEDR_4 => LEDR_4,
    LEDR_5 => LEDR_5,
    LEDR_6 => LEDR_6,
    LEDR_7 => LEDR_7,
    LEDR_8 => LEDR_8,
    LEDR_9 => LEDR_9);

  -- instance "i2c_slave_bfm_1"
  i2c_slave_bfm_1 : i2c_slave_bfm
  GENERIC MAP(
    verbose => false)
  PORT MAP(
    AUD_XCK => AUD_XCK,
    I2C_SDAT => I2C_SDAT,
    I2C_SCLK => I2C_SCLK,
    reg_data0 => reg_data0,
    reg_data1 => reg_data1,
    reg_data2 => reg_data2,
    reg_data3 => reg_data3,
    reg_data4 => reg_data4,
    reg_data5 => reg_data5,
    reg_data6 => reg_data6,
    reg_data7 => reg_data7,
    reg_data8 => reg_data8,
    reg_data9 => reg_data9);

  readcmd : PROCESS
    -- This process loops through a file and reads one line
    -- at a time, parsing the line to get the values and
    -- expected result.

    VARIABLE cmd : line; --stores test command
    VARIABLE line_in : line; --stores the to be processed line     
    VARIABLE tv : test_vect; --stores arguments 1 to 4
    VARIABLE lincnt : INTEGER := 0; --counts line number in testcase file
    VARIABLE fail_counter : INTEGER := 0;--counts failed tests

  BEGIN
    -------------------------------------
    -- Open the Input and output files
    -------------------------------------
    FILE_OPEN(cmdfile, "../testcase.dat", read_mode);
    FILE_OPEN(outfile, "../results.dat", write_mode);

    -------------------------------------
    -- Start the loop
    -------------------------------------
    LOOP

      --------------------------------------------------------------------------
      -- Check for end of test file and print out results at the end
      --------------------------------------------------------------------------
      IF endfile(cmdfile) THEN -- Check EOF
        end_simulation(fail_counter);
        EXIT;
      END IF;

      --------------------------------------------------------------------------
      -- Read all the argumnents and commands
      --------------------------------------------------------------------------

      readline(cmdfile, line_in); -- Read a line from the file
      lincnt := lincnt + 1;
      NEXT WHEN line_in'length = 0; -- Skip empty lines
      NEXT WHEN line_in.ALL(1) = '#'; -- Skip lines starting with #

      read_arguments(lincnt, tv, line_in, cmd);
      tv.clock_period := clock_period; -- set clock period for driver calls

      -------------------------------------
      -- Reset the circuit
      -------------------------------------

      IF cmd.ALL = "reset_target" THEN
        rst_sim(tv, key_0);
      ELSIF cmd.ALL = "run_simulation_for" THEN
        run_sim(tv);
      ELSIF cmd.ALL = "uart_send_data" THEN
        uar_sim(tv, USB_TXD);
      ELSIF cmd.ALL = "check_display_hex0" THEN
        hex_chk(tv, hex0);
      ELSIF cmd.ALL = "check_display_hex0" THEN
        hex_chk(tv, hex0);
      ELSIF cmd.ALL = "check_display_hex1" THEN
        hex_chk(tv, hex1);
      ELSIF cmd.ALL = "check_i2c_reg_0" THEN
        gpo_chk(tv, reg_data0);
      ELSIF cmd.ALL = "check_i2c_reg_1" THEN
        gpo_chk(tv, reg_data1);
      ELSIF cmd.ALL = "check_i2c_reg_2" THEN
        gpo_chk(tv, reg_data2);
      ELSIF cmd.ALL = "set_switches" THEN
        gpi_sim(tv, gpi_signals);
        -- add further test commands below here
       -- sw (3) <= gpi_signals(1);
      ELSIF cmd.ALL = "send_i2s" THEN
        i2s_sim(tv, AUD_ADCLRCK, AUD_BCLK, AUD_ADCDAT);
      ELSIF cmd.ALL = "check_i2s" THEN
        i2s_chk(tv,AUD_DACLRCK,AUD_BCLK,AUD_DACDAT,dacdat_check);

      ELSE
        ASSERT false
        REPORT "NO MATCHING COMMAND FOUND IN 'testcase.dat' AT LINE: " & INTEGER'image(lincnt)
          SEVERITY error;
      END IF;

      IF tv.fail_flag = true THEN --count failures in tests
        fail_counter := fail_counter + 1;
      ELSE
        fail_counter := fail_counter;
      END IF;

    END LOOP; --finished processing command line

    WAIT; -- to avoid infinite loop simulator warning

  END PROCESS;

  clkgen : PROCESS
  BEGIN
    clock_50 <= '0';
    WAIT FOR clock_period/2;
    clock_50 <= '1';
    WAIT FOR clock_period/2;

  END PROCESS clkgen;
  SW(9 DOWNTO 0) <= gpi_signals(9 DOWNTO 0);

  
 
END ARCHITECTURE struct;

-------------------------------------------------------------------------------