library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

ENTITY adder IS
	PORT ( dataa, datab : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
          sum   : OUT STD_LOGIC_VECTOR(15 DOWNTO 0) 
           );
END ENTITY adder;

ARCHITECTURE arch_adder OF adder IS
BEGIN
	
	sum <= dataa + datab;
    
END ARCHITECTURE arch_adder;