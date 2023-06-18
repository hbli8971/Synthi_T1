-------------------------------------------
-- Block code:  modulo_divider.vhd
-- History: 	4. Sep.2019 - 1st version (gelk)
--            	6. Dez.2021 - 2nd version (gelk)
--					17.Mar.2023 - added 12 MHz clock (gerbedor)
-- Function: modulo divider with generic width. Output MSB with 50% duty cycle.
--	Can be used for clock-divider when no exact ratio required.
-------------------------------------------

-- Library & Use Statements
-------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


-- Entity Declaration 
-------------------------------------------
ENTITY modulo_divider IS
  PORT( 	clk			: IN  std_logic;
    	   clk_6m     	: OUT std_logic;
			clk_12m		: OUT std_logic
    	);
END modulo_divider;


-- Architecture Declaration?
-------------------------------------------
ARCHITECTURE rtl OF modulo_divider IS
-- Signals & Constants Declaration?
-------------------------------------------
constant width6 	: integer := 3;
constant width12  : integer := 2;
signal count6, next_count6		: unsigned(width6-1 downto 0) := (others => '0');	 
signal count12, next_count12	: unsigned(width12-1 downto 0) := (others => '0');	 

-- Begin Architecture
-------------------------------------------
BEGIN
  --------------------------------------------------
  -- PROCESS FOR COMBINATORIAL LOGIC
  --------------------------------------------------
  comb_logic: PROCESS(count6, count12)
  BEGIN	
	-- increment	
	next_count6 <= count6 + 1;
	next_count12 <= count12 + 1;
  END PROCESS comb_logic;   
  
  --------------------------------------------------
  -- PROCESS FOR REGISTERS
  --------------------------------------------------
  flip_flops : PROCESS(all)
  BEGIN	
    IF rising_edge(clk) THEN
		count6 	<= next_count6;
		count12 	<= next_count12;
    END IF;
  END PROCESS flip_flops;		
  
  
  --------------------------------------------------
  -- CONCURRENT ASSIGNMENTS
  --------------------------------------------------
  -- take MSB and convert for output data-type
  clk_6m 	<= std_logic(count6(width6-1));
  clk_12m 	<= std_logic(count12(width12-1));
  
  
 -- End Architecture 
------------------------------------------- 
END rtl;

