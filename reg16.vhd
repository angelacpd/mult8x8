library IEEE;
use IEEE.std_logic_1164.all;

ENTITY reg16 IS
	PORT( clk : IN STD_LOGIC;
    		sclr_n : IN STD_LOGIC;
         clk_ena : IN STD_LOGIC;
         datain : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
         reg_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );           
END ENTITY reg16;

ARCHITECTURE arch_reg16 OF reg16 IS
BEGIN
	PROCESS(clk)
    BEGIN 
    	IF rising_edge(clk) THEN
        	IF clk_ena = '1' THEN
            IF sclr_n = '0' THEN
               reg_out <= x"0000";
            ELSE 
					reg_out <= datain;
            END IF;
         END IF; 
    	END IF;
    END PROCESS;    
END ARCHITECTURE arch_reg16;