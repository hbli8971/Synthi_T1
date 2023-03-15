-------------------------------------------
-- Block code:  count_down.vhd
-- History: 	12.Nov.2013 - 1st version (dqtm)
--                 <date> - <changes>  (<author>)
--29.11.2022 jan spuler
-- Function: down-counter, with start input and count output. 
-- 			The input start should be a pulse which causes the 
--			counter to load its max-value. When start is off,
--			the counter decrements by one every clock cycle till 
--			count_o equals 0. Once the count_o reachs 0, the counter
--			freezes and wait till next start pulse. 
--			Can be used as enable for other blocks where need to 
--			count number of iterations.
-------------------------------------------


-- Library & Use Statements
-------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


-- Entity Declaration 
-------------------------------------------
ENTITY output_register IS
GENERIC (width : positive := 10);
  PORT( 
  parallel_in	:in  std_logic_vector(width-1 downto 0);
  clk				:in  std_logic;
  data_valid	:in  std_logic;
  reset_n		:in  std_logic;
  hex_lsb_out	:out std_logic_vector(3 downto 0);
  hex_msb_out	:out std_logic_vector(3 downto 0)		
    	);
END output_register;


-- Architecture Declaration
-------------------------------------------
ARCHITECTURE rtl OF output_register IS
-- Signals & Constants Declaration
-------------------------------------------
CONSTANT  	max_val: 			unsigned(width-1 downto 0):= to_unsigned(4,width); -- convert integer value 4 to unsigned with 4bits
--SIGNAL 		count, next_count: 	unsigned(width-1 downto 0);
SIGNAL 		data_reg, next_data_reg: std_logic_vector(width-1 downto 0);
-- Begin Architecture
-------------------------------------------
BEGIN

  --------------------------------------------------
  -- PROCESS FOR COMBINATORIAL LOGIC
  --------------------------------------------------
  comb_logic: PROCESS(all)
  BEGIN	
	IF (data_valid = '1') THEN
		next_data_reg <= parallel_in;

  	ELSE 
  		next_data_reg <= data_reg;
		
  	END IF;
	
  END PROCESS comb_logic;   
  
  
  
  
  --------------------------------------------------
  -- PROCESS FOR REGISTERS
  --------------------------------------------------
  flip_flops : PROCESS(all)
  BEGIN	
  	IF reset_n = '0' THEN
		data_reg <= "0000000000"; -- convert integer value 0 to unsigned with 4bits
    ELSIF rising_edge(clk) THEN
		data_reg <= next_data_reg ;
    END IF;
  END PROCESS flip_flops;		
  
  
  --------------------------------------------------
  -- CONCURRENT ASSIGNMENTS
  --------------------------------------------------
  -- convert count from unsigned to std_logic (output data-type)
	hex_lsb_out <= data_reg(8 downto 5);
	hex_msb_out <= data_reg(4 downto 1);
  
  
 -- End Architecture 
------------------------------------------- 
END rtl;

