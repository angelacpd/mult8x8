library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

ENTITY input_reg IS
	PORT( clk, reset, get_data_a, get_data_b : IN STD_LOGIC;
			sw_input: IN STD_LOGIC_VECTOR(7 DOWNTO 0); 
			dataa : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
			datab : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
   );
END ENTITY input_reg;

ARCHITECTURE arch_input_reg OF input_reg IS
BEGIN
	
	PROCESS(clk)
	BEGIN
		IF reset = '1' then
            dataa <= x"00";
            datab <= x"00";   
		ELSIF rising_edge(clk) and get_data_a = '1' THEN
			dataa <= sw_input;
		ELSIF rising_edge(clk) and get_data_b = '1' THEN
			datab <= sw_input; 
		END IF;
	END PROCESS;	
	
END ARCHITECTURE arch_input_reg;