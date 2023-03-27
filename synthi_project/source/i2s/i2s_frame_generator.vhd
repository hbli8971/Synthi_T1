-------------------------------------------------------------------------------
-- Title      : i2s frame generator
-- Project    : 
-------------------------------------------------------------------------------
-- File       : i2s_frame_generator.vhd
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
-------------------------------------------------------------------------------

entity i2s_frame_generator is

  GENERIC (width : positive := 7);

  port (
    clk_6m : IN std_logic;           --
    rst_n : IN std_logic;				 --
    load : OUT std_logic;				 --
    shift_l,shift_r : OUT std_logic; --
    ws : OUT std_logic					 --
    );

end entity i2s_frame_generator;

-------------------------------------------------------------------------------

architecture str of i2s_frame_generator is

--signal count_reg : std_logic_vector(width-1 downto 0);  -- Internal register for counting
signal count_reg : unsigned(6 downto 0);   -- Internal register for counting



begin  -- architecture str
-------------------------------------------------------------------------------
flip_flops : PROCESS(all)
  BEGIN	
  --	IF rst_n = '0' THEN
	--	count <= to_unsigned(0,width); -- convert integer value 0 to unsigned with 4bits
--    ELSIF rising_edge(clk_6m) THEN
--		count <= next_count ;
--    END IF;

      if rst_n = '0' then   -- Reset the counter to 0
          count_reg <= (others => '0');
      elsif rising_edge(clk_6m) then  -- Increment the counter on each clock cycle
          count_reg <= count_reg + 1;
      end if;
  END PROCESS flip_flops;	
-------------------------------------------------------------------------------  
  shift_routine : PROCESS(all)
  begin
	if (count_reg >= "0000001") and (count_reg <= "0010000") then -- if c >= 1 and c <= 16
		shift_l <= '1';
	else
		shift_l <= '0';
	end if;
		
	if (count_reg >= "1000001") and (count_reg <= "1010000") then -- if c >= 65 and c <= 80
		shift_r <= '1';
	else
		shift_r <= '0';
	end if;
  END PROCESS shift_routine;
  
  load_routine : PROCESS(all)
  begin 
	if count_reg = "0000000" then
		load <= '1';
	else
		load <= '0';
	end if;
	END PROCESS load_routine;
-------------------------------------------------------------------------------
	ws_routine : PROCESS(all)
	begin
	ws <= count_reg(6);
	END PROCESS ws_routine;


end architecture str;

-------------------------------------------------------------------------------
