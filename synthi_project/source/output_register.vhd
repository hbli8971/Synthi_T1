-------------------------------------------
-- Block code:  output_register.vhd
-- History: 	12.Nov.2013 - 1st version (dqtm)
--             29.Nov.2022 - Mini-Projekt lab11 (Gerber, Nueesch)
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
  PORT( clk,reset_n	: IN    std_logic;
		data_valid     : IN    std_logic;
    	parallel_in  	: IN    std_logic_vector(width-1 downto 0);
		hex_lsb_out   	: OUT   std_logic_vector(3 downto 0);
		hex_msb_out   	: OUT   std_logic_vector(3 downto 0)
    	);
END output_register;


-- Architecture Declaration
-------------------------------------------
ARCHITECTURE rtl OF output_register IS
-- Signals & Constants Declaration
-------------------------------------------
SIGNAL 		values, next_value: 	unsigned(width-1 downto 0);	 


-- Begin Architecture
-------------------------------------------
BEGIN


  --------------------------------------------------
  -- PROCESS FOR COMBINATORIAL LOGIC
  --------------------------------------------------
  comb_logic: PROCESS(all)
  BEGIN	 
	-- load	
	IF (data_valid = '1') THEN
		next_value <= unsigned(parallel_in); 
  	-- freezes
  	ELSE
  		next_value <= values;
  	END IF;
	
  END PROCESS comb_logic;   
  
  --------------------------------------------------
  -- PROCESS FOR REGISTERS
  --------------------------------------------------
  flip_flops : PROCESS(all)
  BEGIN	
  	IF reset_n = '0' THEN
		values <= to_unsigned(0,width); -- convert integer value 0 to unsigned with 4bits
    ELSIF rising_edge(clk) THEN
		values <= next_value ;
    END IF;
  END PROCESS flip_flops;		
  
  
  --------------------------------------------------
  -- CONCURRENT ASSIGNMENTS
  --------------------------------------------------
  -- convert count from unsigned to std_logic (output data-type)
  hex_lsb_out <= std_logic_vector(values(4 downto 1));
  hex_msb_out <= std_logic_vector(values(8 downto 5));

 -- End Architecture 
------------------------------------------- 
END rtl;

