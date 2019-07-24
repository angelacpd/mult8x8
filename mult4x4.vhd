library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

ENTITY mult4x4 IS
	PORT(	dataa, datab : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
         product : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) 
	);
END ENTITY mult4x4;

ARCHITECTURE arch_mult4x4 OF mult4x4 IS
BEGIN
	
    product <= dataa * datab;
    
END ARCHITECTURE arch_mult4x4;