LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY shifter IS
	PORT (input : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			shift_cntrl : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			shift_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0) );
END ENTITY shifter;

ARCHITECTURE arch_shifter OF shifter IS
BEGIN
	PROCESS(input, shift_cntrl)
	BEGIN
		shift_out <= x"0000";
		if shift_cntrl = "01" then
			shift_out(11 downto 4) <= input;
		elsif shift_cntrl = "10" then
			shift_out(15 downto 8) <= input;
		else
			shift_out(7 downto 0) <= input; -- no shift
		end if;
	END PROCESS;
END ARCHITECTURE arch_shifter;
