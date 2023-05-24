-------------------------------------------------------------------------------
-- Title      : EQ_ctrl
-- Project    : 
-------------------------------------------------------------------------------
-- File       : EQ_ctrl.vhd
-- Author     :   <mine8@LAPTOP-G548OMQT>
-- Company    : 
-- Created    : 2023-05-10
-- Last update: 2023-05-10
-- Platform   : 
-- Standard   : VHDL'08
-------------------------------------------------------------------------------
-- Description: controler for EQ
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-05-10  1.0      mine8	Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

-------------------------------------------------------------------------------

entity EQ_top is

  --generic ();

  port (
		Serial_in_BT	:	IN STD_LOGIC;	                   -- data from BT module
		clk_6m			:	IN STD_LOGIC;	                   -- clk_6m input 
		reset_n			:	IN STD_LOGIC;	                   -- reset 
		atte_freqency	:	OUT STD_LOGIC_VECTOR(4 downto 0); -- selects freq to be set 
		atte_value		:	OUT STD_LOGIC_VECTOR(2 downto 0); -- sets selected freq
		enable			:	OUT STD_LOGIC;	                   -- enables the EQ
		Ctrl_byte      : OUT STD_LOGIC_VECTOR(7 downto 0);
		data1_byte     : OUT STD_LOGIC_VECTOR(7 downto 0);
		data2_byte     : OUT STD_LOGIC_VECTOR(7 downto 0);
		Data_rdy       : OUT STD_LOGIC
		
    );

end entity EQ_top;

-------------------------------------------------------------------------------

architecture str of EQ_top is

  -----------------------------------------------------------------------------
  -- Internal signal declarations
  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  -- Component declarations
  -----------------------------------------------------------------------------

  component EQ_uart_top is
    port (
      clk_6m      : IN  STD_LOGIC;
      reset_n     : IN  STD_LOGIC;
      serial_in   : IN  STD_LOGIC;
      rx_data     : OUT STD_LOGIC_VECTOR(7 downto 0);
      rx_data_rdy : OUT STD_LOGIC
		);
  end component EQ_uart_top;

  component EQ_ctrl is
    port (
      rx_data     : IN  STD_LOGIC_VECTOR(7 downto 0);
      rx_data_rdy : IN  STD_LOGIC;
      clk         : IN  STD_LOGIC;
      reset_n     : IN  STD_LOGIC;
      atte_freq   : OUT STD_LOGIC_VECTOR(4 downto 0);
      atte_value  : OUT STD_LOGIC_VECTOR(2 downto 0);
      enable_eq   : OUT STD_LOGIC;   
      ctrl_reg_out	: OUT STD_LOGIC_VECTOR(7 downto 0);
		data1_reg_out	: OUT STD_LOGIC_VECTOR(7 downto 0);
		data2_reg_out	: OUT STD_LOGIC_VECTOR(7 downto 0);
		rx_data_rdy_flag : OUT STD_LOGIC);
  end component EQ_ctrl;
  
  
  signal ATTE_VALUE_intern		: STD_LOGIC_VECTOR(2 downto 0);
  signal ATTE_FREQ_intern		: STD_LOGIC_VECTOR(4 downto 0);
  signal RX_DATA_intern			: STD_LOGIC_VECTOR(7 downto 0);
  signal RX_DATA_RDY_intern	: STD_LOGIC;
  signal ENABLE_intern			: STD_LOGIC;

begin  -- architecture str

  -----------------------------------------------------------------------------
  -- Component instantiations
  -----------------------------------------------------------------------------

  -- instance "uart_top_1"
  uart_top_1: EQ_uart_top
    port map (
      clk_6m      => clk_6m, --
      reset_n     => reset_n, --
      serial_in   => Serial_in_BT,--
      rx_data     => RX_DATA_intern, --
      rx_data_rdy => RX_DATA_RDY_intern--
		);

  -- instance "EQ_ctrl_1"
  EQ_ctrl_1: EQ_ctrl
    port map (
      rx_data     => RX_DATA_intern,--
      rx_data_rdy => RX_DATA_RDY_intern,--
      clk         => clk_6m, --
      reset_n     => reset_n, --
      atte_freq   => atte_freqency,--
      atte_value  => atte_value,--
      enable_eq   => enable,
		ctrl_reg_out	=>	Ctrl_byte,
		data1_reg_out	=> data1_byte,
		data2_reg_out	=> data2_byte,
		rx_data_rdy_flag => Data_rdy
		);--


end architecture str;

-------------------------------------------------------------------------------
