library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

ENTITY counter IS
	PORT( clk : IN STD_LOGIC;
    		aclr_n : IN STD_LOGIC;
         count_out : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
        );            
END ENTITY counter;

ARCHITECTURE arch_counter OF counter IS
	signal count : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
BEGIN
	PROCESS(aclr_n, clk)
	BEGIN
		IF aclr_n = '0' THEN
			count <= "00";
		ELSE
			IF rising_edge(clk) THEN
				count <= count + "01";
	    	END IF;
		END IF;
   END PROCESS; 
	count_out <= count;
END ARCHITECTURE arch_counter;
