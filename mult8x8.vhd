-- TO DO
-- Create a register to store datab
-- Output this register to one 7 seg display
-- 7 seg display = low 
-- Draw state machine
-- Assign DK pins

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY mult8x8 IS
	PORT (		
		-- Declare control inputs "clk", "start" and "reset_a"
		CLOCK_50 : IN STD_LOGIC;
		KEY : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		SW : IN STD_LOGIC_VECTOR(9 DOWNTO 0); 
		-- start = sw(9), reset_a = sw(8)	
		-- data = sw(7 downto 0), representing dataa and datab.
		-- multiplex the two inputs

		-- Declare data inputs "dataa" and "datab"
		-- dataa, datab : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		
		LEDR: OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		-- Declare multiplier output "product8x8_out"
		-- product8x8_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		
		HEX0: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);		
		HEX1: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX2: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX3: OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
		-- Declare seven segment display outputs for register input datab
		-- seg_a, seg_b, seg_c, seg_d, seg_e, seg_f, seg_g, done_flag : OUT STD_LOGIC

	);
END ENTITY mult8x8;

ARCHITECTURE arch_mult8x8 OF mult8x8 IS

	-- lower level components
	COMPONENT input_reg IS
		PORT( clk, reset, get_data_a, get_data_b : IN STD_LOGIC;
				sw_input: IN STD_LOGIC_VECTOR(7 DOWNTO 0); 
				dataa : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
				datab : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
	END COMPONENT input_reg;	
		
	COMPONENT adder
		PORT (dataa, datab : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
				sum : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
		);
	END COMPONENT adder;
	
	COMPONENT mux4 
		PORT ( mux_in_a, mux_in_b: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				mux_sel : IN STD_LOGIC;
				mux_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
		);
	END COMPONENT mux4;

	
	COMPONENT mult4x4 IS
		PORT(	dataa, datab : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				product : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
	END COMPONENT mult4x4;
	
	
	COMPONENT shifter IS
		PORT (  input : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
				shift_cntrl : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
				shift_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0) );
	END COMPONENT shifter;
	
		
	
	COMPONENT seven_segment_cntrl
		PORT ( input : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
				disp0, disp1, disp2, disp3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) 
		);
	END COMPONENT seven_segment_cntrl;
	
	COMPONENT reg16
		PORT (clk, clk_ena, sclr_n : IN STD_LOGIC;
			datain: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			reg_out : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
		);
	END COMPONENT reg16;	
	
	COMPONENT counter
		PORT (
			clk, aclr_n : IN STD_LOGIC;
			count_out : OUT STD_LOGIC_VECTOR (1 DOWNTO 0)
		);
	END COMPONENT counter;	
	
	COMPONENT mult_control
		PORT (
			clk, reset_a, start : IN STD_LOGIC;
			count : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
			input_sel, shift_sel : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
			state_out : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
			done, clk_ena, sclr_n : OUT STD_LOGIC
		);
	END COMPONENT mult_control;	
	
	
	SIGNAL sw_input, dataa, datab : std_logic_vector(7 DOWNTO 0);
	SIGNAL reset_a, start : std_logic;
	
	SIGNAL aout, bout : std_logic_vector(3 DOWNTO 0);
	SIGNAL partial_product : std_logic_vector(7 DOWNTO 0);
	
 
	SIGNAL shift_out, sum, product8x8 : std_logic_vector(15 DOWNTO 0);
	SIGNAL count, shift : std_logic_vector(1 DOWNTO 0);
	SIGNAL state_out : std_logic_vector(2 DOWNTO 0);
	SIGNAL clk_ena, sclr_n, start_n : std_logic;
	SIGNAL sel : std_logic_vector(1 DOWNTO 0);
	SIGNAL done_flag : std_logic := '0';


BEGIN
	sw_input <= SW(7 DOWNTO 0);
	reset_a <= SW(8);
	start <= SW(9);
	-- Start SIGNAL requires inversion before connecting to counter
	start_n <= not(start);
	
	
	u0: input_reg PORT MAP( clk => CLOCK_50,
									reset => reset_a,
									get_data_a => KEY(2),
									get_data_b => KEY(3),
									sw_input => sw_input, 
									dataa => dataa, 
									datab => datab );
	
	u1: mux4 PORT MAP(mux_in_a => dataa(3 DOWNTO 0), 
							mux_in_b => dataa(7 DOWNTO 4), 
							mux_sel => sel(1),
							mux_out => aout);

	u2: mux4 PORT MAP(mux_in_a => datab(3 DOWNTO 0), 
							mux_in_b => datab(7 DOWNTO 4), 
							mux_sel => sel(0),
							mux_out => bout);

	u3: mult4x4 PORT MAP(dataa => aout, 
								datab => bout, 
								product => partial_product);	
 
	u4: shifter PORT MAP(input => partial_product, 
								shift_cntrl => shift, 
								shift_out => shift_out);
						
	u5: counter PORT MAP(clk => CLOCK_50, 
								aclr_n => start_n, 
								count_out => count);

	u6: mult_control PORT MAP(clk => CLOCK_50, 
										reset_a => reset_a, 
										start => start, 
										count => count,
										input_sel => sel, 
										shift_sel => shift, 
										state_out => state_out,
										done => done_flag, 
										clk_ena => clk_ena, 
										sclr_n => sclr_n);

	u7: reg16 PORT MAP(clk => CLOCK_50, 
							sclr_n => sclr_n, 
							clk_ena => clk_ena, 
							datain => sum,
							reg_out => product8x8);

	u8: adder PORT MAP(dataa => shift_out, 
							datab => product8x8, 
							sum => sum);

	u9: seven_segment_cntrl PORT MAP(input => product8x8, 
												disp0 => HEX0, 
												disp1 => HEX1, 
												disp2 => HEX2, 
												disp3 => HEX3);
	
	
	LEDR <= product8x8(9 DOWNTO 0);

END ARCHITECTURE arch_mult8x8;