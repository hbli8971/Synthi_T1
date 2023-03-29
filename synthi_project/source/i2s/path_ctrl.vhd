-------------------------------------------------------------------------------
-- Title      : path_ctrl
-- Project    : 
-------------------------------------------------------------------------------
-- File       : path_ctrl.vhd
-- Author     :   <mine8@LAPTOP-G548OMQT>
-- Company    : 
-- Created    : 2023-03-22
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
-- 2023-03-22  1.0      mine8	Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

-------------------------------------------------------------------------------

entity path_ctrl is
  generic (width : positive := 16);
  port (
  dds_l_i		: IN std_logic_vector(width-1 downto 0);
  dds_r_i		: IN std_logic_vector(width-1 downto 0);
  adcdat_pl_i	: IN std_logic_vector(width-1 downto 0);
  adcdat_pr_i  : IN std_logic_vector(width-1 downto 0);
  SW				: IN std_logic;
  dacdat_pl_o	: OUT std_logic_vector(width-1 downto 0);
  dacdat_pr_o  : OUT std_logic_vector(width-1 downto 0)
    );

end entity path_ctrl;

-------------------------------------------------------------------------------

architecture str of path_ctrl is

begin  -- architecture str
	path_ctrl_routine : process(all)
	begin
	if SW = '0' then
		dacdat_pl_o <= dds_l_i;
		dacdat_pr_o <= dds_r_i;
	else
		dacdat_pl_o <= adcdat_pl_i;
		dacdat_pr_o <= adcdat_pr_i;
	end if;
	
	end process path_ctrl_routine;

end architecture str;

-------------------------------------------------------------------------------
