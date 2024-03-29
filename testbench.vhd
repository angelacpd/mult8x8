library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.numeric_std.all;

entity tb is
	-- empty
end tb;

architecture arch_tb of tb is
	
component mult8x8 is

	port(	CLOCK_50 : in std_logic;
			KEY : in std_logic_vector(3 downto 0);
			SW : in std_logic_vector(9 downto 0);
			LEDR : out std_logic_vector(9 downto 0);
			HEX0 : out std_logic_vector(6 downto 0);
			HEX1 : out std_logic_vector(6 downto 0);
			HEX2 : out std_logic_vector(6 downto 0);
			HEX3 : out std_logic_vector(6 downto 0)
			);
end component mult8x8;
	
	signal clock_in: std_logic := '0';
	signal reset, start : std_logic := '1';
	-- signal reset : std_logic := '0';
	
	signal KEY_in : std_logic_vector(3 downto 0);
	signal SW_in : std_logic_vector(9 downto 0);
	signal HEX0_out, HEX1_out, HEX2_out, HEX3_out : std_logic_vector(6 downto 0);
	signal LEDR_out : std_logic_vector(9 downto 0);
	
	signal get_data_a : std_logic := '0';
	signal get_data_b : std_logic := '0';
	signal sw_input : std_logic_vector(7 downto 0);

begin

	-- Clock 50 MHz => T = 20 ns.
	process
	begin
		clock_in <= not clock_in;
		wait for 10 ns;
		clock_in <= not clock_in;
		wait for 10 ns;
        

	end process;
	
	reset <= '0', '1' after 5 ns;
	KEY_in(0) <= start;
	KEY_in(1) <= reset;
	KEY_in(2) <= get_data_a;
	KEY_in(3) <= get_data_b;
	SW_in <= start & reset & sw_input;


	process
	begin
		sw_input <= "00000010";
		wait for 25 ns;
        
      get_data_a <= '0';
      wait for 20 ns;
		get_data_a <= '1';
        
		sw_input <= "00000100";
		wait for 40 ns;
        
      get_data_b <= '0';
      wait for 20 ns;
      get_data_b <= '1';
		wait for 20 ns;
		
		start <= '0';
		wait for 200 ns;
	
	   ASSERT false REPORT "Finished" SEVERITY failure;
    
	end process;

   DUT : mult8x8 port map(	CLOCK_50 => clock_in, 
									KEY => KEY_in,
									SW => SW_in,
									LEDR => LEDR_out,
									HEX0 => HEX0_out,
									HEX1 => HEX1_out,
									HEX2 => HEX2_out,
									HEX3 => HEX3_out									
								); 
                                   
end arch_tb;