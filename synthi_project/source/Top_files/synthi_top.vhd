-------------------------------------------------------------------------------
-- Title      : synthi_top
-- Project    : 
-------------------------------------------------------------------------------
-- File       : synthi_top.vhd
-- Author     : Hans-Joachim Gelke
-- Company    : 
-- Created    : 2018-03-08
-- Last update: 2023-05-17
-- Platform   : 
-- Standard   : VHDL'08
-------------------------------------------------------------------------------
-- Description: Top Level for Synthesizer
-------------------------------------------------------------------------------
-- Copyright (c) 2018 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2018-03-08  1.0      Hans-Joachim    Created
-- 11.06.2023 	2.0 		gerbedor, spulejan, ehrleand Überarbeitung für PM2
-------------------------------------------------------------------------------

library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;
library work;
	use work.tone_gen_pkg.all;
	
-------------------------------------------------------------------------------

entity synthi_top is

  port (
    CLOCK_50 : in std_logic;            -- DE2 clock from xtal 50MHz
    KEY_0    : in std_logic;            -- DE2 low_active input buttons
    KEY_1    : in std_logic;            -- DE2 low_active input buttons
    SW       : in std_logic_vector(9 downto 0);  -- DE2 input switches

    USB_RXD : in std_logic;             -- USB (midi) serial_input
    USB_TXD : in std_logic;             -- USB (midi) serial_output

    BT_RXD   : in std_logic;            -- Bluetooth serial_input
    BT_TXD   : in std_logic;            -- Bluetooth serial_output
    BT_RST_N : in std_logic;            -- Bluetooth reset_n
	 
	 GPIO_26	 : in std_logic;				 -- MIDI

    AUD_XCK     : out std_logic;        -- master clock for Audio Codec
    AUD_DACDAT  : out std_logic;        -- audio serial data to Codec-DAC
    AUD_BCLK    : out std_logic;        -- bit clock for audio serial data
    AUD_DACLRCK : out std_logic;        -- left/right word select for Codec-DAC
    AUD_ADCLRCK : out std_logic;        -- left/right word select for Codec-ADC
    AUD_ADCDAT  : in  std_logic;        -- audio serial data from Codec-ADC

    AUD_SCLK : out   std_logic;         -- clock from I2C master block
    AUD_SDAT : inout std_logic;         -- data  from I2C master block

    HEX0   : out std_logic_vector(6 downto 0)  -- output for HEX 0 display

    );

end entity synthi_top;


-------------------------------------------------------------------------------

architecture struct of synthi_top is

  -----------------------------------------------------------------------------
  -- Component declarations
  -----------------------------------------------------------------------------

  component infrastructure is
    port (
      clock_50     : in  STD_LOGIC;
      key_0        : in  STD_LOGIC;
      usb_txd      : in  STD_LOGIC;
      clk_6m       : out STD_LOGIC;
		clk_12m		 : out STD_LOGIC;
      reset_n      : out STD_LOGIC;
      usb_txd_sync : out STD_LOGIC);
  end component infrastructure;

  component uart_top is
    port (
      clk_6m      : IN  STD_LOGIC;
      reset_n     : IN  STD_LOGIC;
      serial_in   : IN  STD_LOGIC;
      rx_data     : OUT STD_LOGIC_VECTOR(7 downto 0);
      rx_data_rdy : OUT STD_LOGIC);
  end component uart_top;
  

  component codec_controller is
    port (
      mode         : in  std_logic_vector(2 downto 0);
      write_done_i : in  std_logic;
      ack_error_i  : in  std_logic;
      clk          : in  std_logic;
      reset_n      : in  std_logic;
      write_o      : out std_logic;
      write_data_o : out std_logic_vector(15 downto 0));
  end component codec_controller;

  component i2c_master is
    port (
      clk          : in    std_logic;
      reset_n      : in    std_logic;
      write_i      : in    std_logic;
      write_data_i : in    std_logic_vector(15 downto 0);
      sda_io       : inout std_logic;
      scl_o        : out   std_logic;
      write_done_o : out   std_logic;
      ack_error_o  : out   std_logic);
  end component i2c_master;

  component i2s_master is
  generic (width : positive := 16);
		port 
		(
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
	end component i2s_master;
	
	component path_ctrl is
		generic (width : positive := 16);
		port 
		(
			dds_l_i		: IN std_logic_vector(width-1 downto 0);
			dds_r_i		: IN std_logic_vector(width-1 downto 0);
			adcdat_pl_i	: IN std_logic_vector(width-1 downto 0);
			adcdat_pr_i : IN std_logic_vector(width-1 downto 0);
			SW				: IN std_logic;
			dacdat_pl_o	: OUT std_logic_vector(width-1 downto 0);
			dacdat_pr_o : OUT std_logic_vector(width-1 downto 0)
		);
	end component path_ctrl;

  
  component vhdl_hex2sevseg is
    port (
      data_in : IN  std_logic_vector(3 downto 0);
      seg_o   : OUT std_logic_vector(6 downto 0);
      lt_n    : IN  std_logic;
      blank_n : IN  std_logic;
      rbo_n   : OUT std_logic;
      rbi_n   : IN  std_logic);
  end component vhdl_hex2sevseg;

    component output_register is
    generic (
      width : positive);
    port (
      parallel_in : in  std_logic_vector(width-1 downto 0);
      clk         : in  std_logic;
      data_valid  : in  std_logic;
      reset_n     : in  std_logic
	);
  end component output_register;

  component MIDI is
    port (
      clk_6m      : in  std_logic;
      reset_n     : in  std_logic;
      rx_data     : in  std_logic_vector(7 downto 0);
      rx_data_rdy : in  std_logic;
      note        : out t_tone_array;
      velocity    : out t_tone_array;
      note_valid  : out std_logic_vector(9 downto 0)
		);
  end component MIDI;

  component tone_generator is
   port (
      tone_on_i  	: IN  std_logic_vector(9 downto 0);
      note_i     	: IN  t_tone_array;
      step_i     	: IN  std_logic;
      velocity_i 	: IN  t_tone_array;
      clk_6m     	: IN  std_logic;
      rst_n      	: IN  std_logic;
      dds_l_o    	: OUT std_logic_vector(N_AUDIO-1 downto 0);
      dds_r_o    	: OUT std_logic_vector(N_AUDIO-1 downto 0);
		atte_f_eq  	: IN std_logic_vector(4 downto 0);
		atte_v_eq  	: IN std_logic_vector(2 downto 0);
		enable_eq  	: IN std_logic;
		rx_data		: IN STD_LOGIC_VECTOR(7 downto 0);
		rx_data_rdy	: IN STD_LOGIC;
		algo_mode	: out std_logic_vector(3 downto 0)
	);
  end component tone_generator;
  
  component EQ_top is
	port (
		Serial_in_BT  		: IN  STD_LOGIC;
		clk_6m        		: IN  STD_LOGIC;
		reset_n       		: IN  STD_LOGIC;
		atte_freqency 		: OUT STD_LOGIC_VECTOR(4 downto 0);
		atte_value    		: OUT STD_LOGIC_VECTOR(2 downto 0);
		enable        		: OUT STD_LOGIC;
		rx_data_o 			: OUT  STD_LOGIC_VECTOR(7 downto 0);
		rx_data_rdy_o		: OUT  STD_LOGIC
	);
  end component EQ_top;

 -----------------------------------------------------------------------------
 -- Internal signal declarations
 -----------------------------------------------------------------------------

 signal clk_6m       : std_logic;
 signal reset_n      : std_logic;
 signal write_intern : std_logic;
 signal write_data   : std_logic_vector(15 downto 0);
 signal write_done   : std_logic;
 signal ack_error    : std_logic;
 signal write_done_o : std_logic;
 signal ack_error_o  : std_logic;
 signal serial_in    : STD_LOGIC;
 signal ws_i			: std_logic;
 signal sig_adcdat_pl: std_logic_vector(15 downto 0);
 signal sig_adcdat_pr: std_logic_vector(15 downto 0);
 signal sig_dacdat_pl: std_logic_vector(15 downto 0);
 signal sig_dacdat_pr: std_logic_vector(15 downto 0);
 signal sig_step		: std_logic;
 signal dds_l_o		: std_logic_vector(15 downto 0);
 signal dds_r_o		: std_logic_vector(15 downto 0);
 signal note_signal  	: t_tone_array;
 signal velocity_signal	: t_tone_array;
 signal note_signal1  	: std_logic_vector(6 downto 0);
 signal velocity_signal1: std_logic_vector(6 downto 0);

 signal rx_data_sig    : std_logic_vector(7 downto 0);
 signal rx_data_rdy_sig : std_logic;
 signal tone_on_sig     : std_logic_vector(9 downto 0);
 
 signal atte_v_intern	: std_logic_vector(2 downto 0);	-- EQ
 signal atte_f_intern	: std_logic_vector(4 downto 0);	-- EQ
 signal enable_intern	: std_logic;							-- EQ
 
 signal 	sig_rx_data		:  STD_LOGIC_VECTOR(7 downto 0); -- Bluetooth Data
 signal 	sig_rx_data_rdy:  STD_LOGIC;							-- Bluetooth Data
 
 signal sig_algo_mode    : std_logic_vector(3 downto 0); -- FM Algorithm Mode
	
begin -- architecture of synthi_top

	AUD_BCLK		<= clk_6m;
	AUD_DACLRCK	<= ws_i;
	AUD_ADCLRCK	<= ws_i;
	

-----------------------------------------------------------------------------
  -- INSTANCES, Architecture Description
-----------------------------------------------------------------------------

  -- instance "infrastructure_1"
  infrastructure_1: infrastructure
    port map (
      clock_50     => CLOCK_50,
      key_0        => KEY_0,
      --usb_txd      => GPIO_26, -- for external Keyboard
		usb_txd		 => USB_TXD, 	-- for PC keyboard
      clk_6m       => clk_6m,
		clk_12m		 => AUD_XCK,
      reset_n      => reset_n,
      usb_txd_sync => serial_in);

  -- instance "uart_top_1"
  uart_top_1: uart_top
    port map (	
      clk_6m      => clk_6m,
      reset_n     => reset_n,
      serial_in   => serial_in,
      rx_data     => rx_data_sig,
      rx_data_rdy => rx_data_rdy_sig);

  -- instance "codec_controller_1"
  codec_controller_1: codec_controller
    port map (
      mode         => "000",--SW(2 downto 0),
      write_done_i => write_done,
      ack_error_i  => ack_error,
      clk          => clk_6m,
      reset_n      => reset_n,
      write_o      => write_intern,
      write_data_o => write_data);

  -- instance "i2c_master_1"
  i2c_master_1: i2c_master
    port map (
      clk          => clk_6m,
      reset_n      => reset_n,
      write_i      => write_intern,
      write_data_i => write_data,
      sda_io       => AUD_SDAT,
      scl_o        => AUD_SCLK,
      write_done_o => write_done,
      ack_error_o  => ack_error);
		
	
	inst_i2s_master : i2s_master
	port map
	(
		dacdat_pr_i => sig_dacdat_pr,
		dacdat_pl_i => sig_dacdat_pl,
		clk_6m		=> clk_6m,
		reset 		=> reset_n,
		adcdat_s_i	=> AUD_ADCDAT,
		dacdat_s_o	=> AUD_DACDAT,
		step_o		=> sig_step,
		ws_o			=> ws_i,
		adcdat_pl_o	=> sig_adcdat_pl,
		adcdat_pr_o	=> sig_adcdat_pr
	);
	
	inst_path_ctrl : path_ctrl
	port map
	(
		dds_l_i		=> dds_l_o,
		dds_r_i		=> dds_r_o,
		adcdat_pl_i	=> sig_adcdat_pl,
		adcdat_pr_i => sig_adcdat_pr,
		SW			  	=> '0',
		dacdat_pl_o	=> sig_dacdat_pl,
		dacdat_pr_o => sig_dacdat_pr
	);

	-- instance "vhdl_hex2sevseg_1"
	hdl_hex2sevseg_2: vhdl_hex2sevseg -- display algorithm mode 
	port map (
		data_in => sig_algo_mode,
		lt_n    => '0',
		blank_n => '0',
		rbi_n   => '0',
		seg_o   => HEX0
	);

  -- instance "output_register_1"
	output_register_1: output_register
	GENERIC MAP(width => 10)
   port map (
      parallel_in => "0000000000",
      clk         => clk_6m,
      data_valid  => '1',
      reset_n     => reset_n
	);

  -- instance "MIDI_2"
	MIDI_2: MIDI
   port map (
      clk_6m      => clk_6m,
      reset_n     => reset_n,
      rx_data     => rx_data_sig,
      rx_data_rdy => rx_data_rdy_sig,
      note        => note_signal,
      velocity    => velocity_signal,
      note_valid  => tone_on_sig
	);

  -- instance "tone_generator_1"
	tone_generator_1: tone_generator
   port map (
      tone_on_i  	=> tone_on_sig,
      note_i     	=> note_signal,
      step_i     	=> sig_step,
      velocity_i 	=> velocity_signal,
      clk_6m     	=> clk_6m,
      rst_n      	=> reset_n,
      dds_l_o    	=> dds_l_o,
      dds_r_o    	=> dds_r_o,
		-- EQ
		atte_f_eq  	=> atte_f_intern,
		atte_v_eq  	=> atte_v_intern,
		enable_eq  	=> enable_intern,
		-- FM Bluetooth
		rx_data 		=> sig_rx_data,
		rx_data_rdy	=> sig_rx_data_rdy,
		algo_mode	=> sig_algo_mode
	);


  -- instance "EQ_top_1"
  EQ_top_1: EQ_top
    port map (
      Serial_in_BT  		=> BT_TXD,
      clk_6m        		=> clk_6m,
      reset_n       		=> reset_n,
      atte_freqency 		=> atte_f_intern,
      atte_value    		=> atte_v_intern,
      enable        		=> enable_intern,
		rx_data_o 			=> sig_rx_data,
		rx_data_rdy_o		=> sig_rx_data_rdy
	);
		
end architecture struct;

-------------------------------------------------------------------------------
