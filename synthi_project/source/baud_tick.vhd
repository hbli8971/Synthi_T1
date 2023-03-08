-------------------------------------------
-- Block code:  baud_tick.vhd
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
ENTITY baud_tick IS
GENERIC (width : positive := 6);
  PORT( clk,reset_n	: IN    std_logic;
  		start_bit		: IN    std_logic;
    	baud_tick     	: OUT   std_logic
    	);
END baud_tick;


-- Architecture Declaration
-------------------------------------------
ARCHITECTURE rtl OF baud_tick IS
-- Signals & Constants Declaration
-------------------------------------------
CONSTANT clock_freq 	: positive := 6_250_000; -- Clock/Hz
CONSTANT baud_rate 	: positive := 115_200; -- Baude Rate/Hz
CONSTANT count_width : positive := 6; -- FreqClock/FreqBaudRate = 6250000/115200 = 54.25... so need 6 bits
CONSTANT one_period 	: unsigned(count_width - 1 downto 0):= to_unsigned(clock_freq / baud_rate ,count_width);
CONSTANT half_period : unsigned(count_width - 1 downto 0):= to_unsigned(clock_freq/ baud_rate /2, count_width);
SIGNAL   count, next_count: 			unsigned(width-1 downto 0);	 


-- Begin Architecture
-------------------------------------------
BEGIN


  --------------------------------------------------
  -- PROCESS FOR COMBINATORIAL LOGIC
  --------------------------------------------------
  comb_logic: PROCESS(all)
  BEGIN	
	-- load	
	IF (start_bit = '1') THEN
		next_count <= half_period;
	
  	-- decrement
  	ELSIF (count > 0) THEN
  		next_count <= count - 1;
  	
  	
  	ELSE
  		next_count <= one_period;
  	END IF;
	
  END PROCESS comb_logic;   
  
  
  --------------------------------------------------
  -- PROCESS FOR BAUD TICK DETECT
  --------------------------------------------------
  count_tick: PROCESS(all)
  BEGIN	
	baud_tick <= '0';
	IF (count = 0) THEN
		baud_tick <= '1';
  	END IF;
	
  END PROCESS count_tick;   
  
 
  --------------------------------------------------
  -- PROCESS FOR REGISTERS
  --------------------------------------------------
  flip_flops : PROCESS(all)
  BEGIN	
  	IF reset_n = '0' THEN
		count <= to_unsigned(0,width); -- convert integer value 0 to unsigned with 4bits
    ELSIF rising_edge(clk) THEN
		count <= next_count ;
    END IF;
  END PROCESS flip_flops;		
  
  
  
 -- End Architecture 
------------------------------------------- 
END rtl;

