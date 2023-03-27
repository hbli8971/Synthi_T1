-------------------------------------------------------------------------------
-- Title      : mus_2_1
-- Project    : 
-------------------------------------------------------------------------------
-- File       : mux_2_1.vhd
-- Author     :   <mine8@LAPTOP-G548OMQT>
-- Company    : 
-- Created    : 2023-03-27
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
-- 2023-03-27  1.0      mine8	Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

-------------------------------------------------------------------------------

entity mux_2_1 is
    port (
        a : in std_logic;         -- Input signal A
        b : in std_logic;         -- Input signal B
        ws_o : in std_logic;      -- Control signal
        y : out std_logic         -- Output signal
    );
end entity;

-------------------------------------------------------------------------------

architecture str of mux_2_1 is
begin
    -- Multiplexer logic
    y <= a when ws_o = '0' else b;

end architecture str;


