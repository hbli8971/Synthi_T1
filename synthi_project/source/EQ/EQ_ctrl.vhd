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
-- Description: 
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

entity EQ_ctrl is

  port (
		rx_data		: IN STD_LOGIC_VECTOR(7 downto 0);
		rx_data_rdy	: IN STD_LOGIC;
		clk			: IN STD_LOGIC;
		reset_n		: IN STD_LOGIC;
		atte_freq	: OUT STD_LOGIC_VECTOR(4 downto 0);
		atte_value	: OUT STD_LOGIC_VECTOR(2 downto 0);
		enable_eq	: OUT STD_LOGIC
    );

end entity EQ_ctrl;

-------------------------------------------------------------------------------

architecture str of EQ_ctrl is

	type fsm_type is (st_idle, st_byte1, st_byte2, st_byte3, st_data_eval);  -- st_check_rx is also used for storage
	signal fsm_state, next_fsm_state : fsm_type;
	signal ctrl_reg, data1_reg, next_ctrl_reg, next_data1_reg, data2_reg, next_data2_reg : STD_LOGIC_VECTOR(7 downto 0);
	signal atte_f, next_atte_f : STD_LOGIC_VECTOR(4 downto 0);
	signal atte_v, next_atte_v	: STD_LOGIC_VECTOR(2 downto 0);
	signal data_rdy, next_data_rdy	: STD_LOGIC;
	signal enable_int, next_enable : std_logic;

  -----------------------------------------------------------------------------
  -- Internal signal declarations
  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  -- Component declarations
  -----------------------------------------------------------------------------

begin  -- architecture str

 flip_flops : process(all)
  begin
    if reset_n = '0' then
      fsm_state 	<= st_idle;
		atte_freq 		<= "00000";
		atte_value 		<= "011";
		ctrl_reg 	<= "00000000";
		data1_reg 	<= "00000000";
		data2_reg 	<= "00000000";
		enable_eq 	<= '0';
		data_rdy		<= '0';
		
    elsif rising_edge(clk) then
      fsm_state 	<= next_fsm_state;
		ctrl_reg  	<= next_ctrl_reg;
		data1_reg 	<= next_data1_reg;
		data2_reg 	<= next_data2_reg;
		atte_freq 	 	<= next_atte_f;
		atte_value	 	<= next_atte_v;
		enable_eq	<= next_enable;
		data_rdy		<= next_data_rdy;
    end if;
  end process flip_flops;
  
 state_logic : process (all)
  begin
    -- default statements (hold current value)
    next_fsm_state <= fsm_state;
	 next_ctrl_reg <= ctrl_reg;
	 next_data1_reg <= data1_reg;
	 next_data2_reg <= data2_reg;
	 next_data_rdy  <= data_rdy;
	 if data_rdy = '1' then next_data_rdy <= '0'; end if;
	 
	 
    case fsm_state is
      when st_idle =>
			if(rx_data_rdy) then
			next_ctrl_reg <= rx_data;
			next_fsm_state <= st_byte1;
			end if;
       
      when st_byte1 => 
			
			if(rx_data_rdy) then 
			next_data1_reg <= rx_data;
			next_fsm_state <= st_byte2;
			end if;
          

      when st_byte2 =>
			
			if(rx_data_rdy) then 
			next_data2_reg <= rx_data;
			next_fsm_state <= st_byte3;
			end if;
		
		when st_byte3 =>
			--next_data2_reg <= rx_data;
			next_data_rdy <= '1';
			--if(rx_data_rdy) then 
			next_fsm_state <= st_idle;	
			--end if;
			
      when others =>
        next_fsm_state <= fsm_state;

    end case;
  end process state_logic;
  
  
  
 data_eval : process (all)
  begin
  next_enable 	<= enable_eq;
  next_atte_f 	<= atte_freq;
  next_atte_v 	<= atte_value;
  
  
  if (data_rdy = '1') then
	if (ctrl_reg = "00000000") then
		if data1_reg /= "00000000" then next_enable <= '1';
		else next_enable <= '0'; end if;
		
	 elsif (ctrl_reg = "00000001") then
		next_atte_f <= data1_reg(4 downto 0);
		next_atte_v <= data2_reg(2 downto 0);
		
		
	 end if;	
	end if;
  
  
  end process data_eval;
  

  -----------------------------------------------------------------------------
  -- Component instantiations
  -----------------------------------------------------------------------------
--	atte_freq <= atte_f;
 -- atte_value <= atte_v;
 -- enable_eq <= enable_int;
end architecture str;

-------------------------------------------------------------------------------
