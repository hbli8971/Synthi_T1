-------------------------------------------------------------------------------
-- Title      : tone_generator
-- Project    : 
-------------------------------------------------------------------------------
-- File       : tone_generator.vhd
-- Author     :   <andri@DESKTOP-03G9R51>
-- Company    : 
-- Created    : 2023-04-03
-- Last update: 2023-04-07
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

  generic (width : positive := 16);

  port (
    tone_on_i   : IN std_logic;
    note_l_i    : IN std_logic_vector(6 downto 0);
    step_i      : IN std_logic;
    velocity_i  : IN std_logic;
    clk_6m      : IN std_logic;
    rst_n       : IN std_logic;
    dds_l_o     : OUT std_logic_vector(width-1 downto 0);
    dds_r_o     : OUT std_logic_vector(width-1 downto 0)

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


	 



begin



end architecture str;

-------------------------------------------------------------------------------
