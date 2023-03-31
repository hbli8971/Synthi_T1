-------------------------------------------------------------------------------
-- Title      : uni_shiftreg
-- Project    : 
-------------------------------------------------------------------------------
-- File       : uni_shiftreg.vhd
-- Author     :   <mine8@LAPTOP-G548OMQT>
-- Company    : 
-- Created    : 2023-03-20
-- Last update: 2023-03-20
-- Platform   : 
-- Standard   : VHDL'08
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-03-20  1.0      mine8	Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uni_shiftreg is
	 generic (
		width : positive := 16);
    port (
        load : in std_logic;         -- Load input (loads parallel data into the register)
        enable : in std_logic;       -- Enable input (shifts data through the register)
        reset : in std_logic;        -- Reset input (resets the register to all 0's)
        clock : in std_logic;        -- Clock input
        serial_in : in std_logic;    -- Serial data input (shifted in on each clock cycle when enable = '1')
        parallel_in : in std_logic_vector(width-1 downto 0);   -- Parallel data input (loaded into register when load = '1')
        serial_out : out std_logic;  -- Serial data output (shifted out on each clock cycle)
        parallel_out : out std_logic_vector(width-1 downto 0) -- Parallel data output (current contents of the register)
    );
end entity;

architecture str of uni_shiftreg is
    signal reg : std_logic_vector(width-1 downto 0);   -- Internal register for the shift register

begin

    -- Sequential logic for the shift register
    shift_routine : process(all)
    begin
        if reset = '0' then   -- Reset the register to all 0's
            reg <= (others => '0');
        elsif rising_edge(clock) then
            if load = '1' then   -- Load parallel data into the register
                reg <= parallel_in;
            elsif enable = '1' then  -- Shift data through the register
                reg <= reg(width-2 downto 0) & serial_in;
            end if;
        end if;
    end process shift_routine;

    -- Output the serial data and parallel data
    serial_out <= reg(width-1);
    parallel_out <= reg;

end architecture;