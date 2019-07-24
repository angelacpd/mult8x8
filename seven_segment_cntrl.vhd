library IEEE;
use IEEE.std_logic_1164.all;

ENTITY seven_segment_cntrl IS
	PORT( input : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			disp0, disp1, disp2, disp3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) 
			);
             
END ENTITY seven_segment_cntrl;

ARCHITECTURE arch_7seg OF seven_segment_cntrl IS
BEGIN
	PROCESS(input)
   BEGIN 
		case (input(3 downto 0)) is
			when x"0" =>
				disp0 <= "1000000"; -- Segment: '1' => OFF, '0' => ON.
			when x"1" =>
				disp0 <= "1111001";
			when x"2" =>
				disp0 <= "0100100";
			when x"3" =>
				disp0 <= "0110000";
			when x"4" =>
				disp0 <= "0011001";
			when x"5" =>
				disp0 <= "0010010";
			when x"6" =>
				disp0 <= "0000010";
			when x"7" =>
				disp0 <= "1111000";
			when x"8" =>
				disp0 <= "0000000";
			when x"9" =>
				disp0 <= "0010000";
			when x"A" =>
				disp0 <= "0001000";
			when x"B" =>
				disp0 <= "0000011";
			when x"C" =>
				disp0 <= "1000110";
			when x"D" =>
				disp0 <= "0100001";
			when x"E" =>
				disp0 <= "0000110";
			when x"F" =>
				disp0 <= "0001110";
			when others =>
				disp0 <= "1111111";
		end case;
		case input(7 downto 4) is
			when x"0" =>
				disp1 <= "1000000";
			when x"1" =>
				disp1 <= "1111001";
			when x"2" =>
				disp1 <= "0100100";
			when x"3" =>
				disp1 <= "0110000";
			when x"4" =>
				disp1 <= "0011001";
			when x"5" =>
				disp1 <= "0010010";
			when x"6" =>
				disp1 <= "0000010";
			when x"7" =>
				disp1 <= "1111000";
			when x"8" =>
				disp1 <= "0000000";
			when x"9" =>
				disp1 <= "0010000";
			when x"A" =>
				disp1 <= "0001000";
			when x"B" =>
				disp1 <= "0000011";
			when x"C" =>
				disp1 <= "1000110";
			when x"D" =>
				disp1 <= "0100001";
			when x"E" =>
				disp1 <= "0000110";
			when x"F" =>
				disp1 <= "0001110";
			when others =>
				disp1 <= "1111111";
		end case;
		case input(11 downto 8) is
			when x"0" =>
				disp2 <= "1000000";
			when x"1" =>
				disp2 <= "1111001";
			when x"2" =>
				disp2 <= "0100100";
			when x"3" =>
				disp2 <= "0110000";
			when x"4" =>
				disp2 <= "0011001";
			when x"5" =>
				disp2 <= "0010010";
			when x"6" =>
				disp2 <= "0000010";
			when x"7" =>
				disp2 <= "1111000";
			when x"8" =>
				disp2 <= "0000000";
			when x"9" =>
				disp2 <= "0010000";
			when x"A" =>
				disp2 <= "0001000";
			when x"B" =>
				disp2 <= "0000011";
			when x"C" =>
				disp2 <= "1000110";
			when x"D" =>
				disp2 <= "0100001";
			when x"E" =>
				disp2 <= "0000110";
			when x"F" =>
				disp2 <= "0001110";
			when others =>
				disp2 <= "1111111";
		end case;
		case input(15 downto 12) is
			when x"0" =>
				disp3 <= "1000000";
			when x"1" =>
				disp3 <= "1111001";
			when x"2" =>
				disp3 <= "0100100";
			when x"3" =>
				disp3 <= "0110000";
			when x"4" =>
				disp3 <= "0011001";
			when x"5" =>
				disp3 <= "0010010";
			when x"6" =>
				disp3 <= "0000010";
			when x"7" =>
				disp3 <= "1111000";
			when x"8" =>
				disp3 <= "0000000";
			when x"9" =>
				disp3 <= "0010000";
			when x"A" =>
				disp3 <= "0001000";
			when x"B" =>
				disp3 <= "0000011";
			when x"C" =>
				disp3 <= "1000110";
			when x"D" =>
				disp3 <= "0100001";
			when x"E" =>
				disp3 <= "0000110";
			when x"F" =>
				disp3 <= "0001110";
			when others =>
				disp3 <= "1111111";
		end case;	 
    END PROCESS;    
END ARCHITECTURE arch_7seg;