LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY mux4 IS
	PORT (  mux_in_a, mux_in_b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			  mux_sel : IN STD_LOGIC;
			  mux_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) );
END ENTITY mux4;

ARCHITECTURE arch_mux4 OF mux4 IS
BEGIN
	PROCESS(mux_sel, mux_in_a, mux_in_b)
	BEGIN
		IF mux_sel = '0' THEN
			mux_out <= mux_in_a;
		ELSIF mux_sel = '1' THEN
			mux_out <= mux_in_b;
		ELSE
			mux_out <= x"0";
		END IF;
	END PROCESS;
END ARCHITECTURE arch_mux4;
