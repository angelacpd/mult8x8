LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY mult_control IS
	PORT( clk, reset_a, start : IN STD_LOGIC;		
			count : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
			input_sel, shift_sel : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
			state_out : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
			done, clk_ena, sclr_n : OUT STD_LOGIC
		);
END ENTITY mult_control;

ARCHITECTURE arch_mult_control OF mult_control IS
	TYPE state_type IS (idle, lsb, mid, msb, calc_done, err);
	SIGNAL current_state, next_state : state_type;
BEGIN
	-- Sequential process to control state transitions by making current_state equal to next state on
	--	rising edge transitions; Use asynchronous clear control
	PROCESS (clk, reset_a)
	BEGIN
		IF reset_a = '1' THEN
			current_state <= idle;
		ELSIF rising_edge(clk) THEN
			current_state <= next_state;
		END IF;
	END PROCESS;
	
	-- Combinational process & case statement to determine next_state based on current state and inputs
	PROCESS (current_state, start, count)
	BEGIN
		CASE current_state IS
			WHEN idle =>
				IF start = '1' THEN
					next_state <= lsb;
				ELSE
					next_state <= idle;
				END IF;
			WHEN lsb =>
				IF start = '0' AND count = "00" THEN
					next_state <= mid;
				ELSE 
					next_state <= err;
				END IF;
			WHEN mid =>
				IF start = '0' AND count = "10" THEN
					next_state <= msb;
				ELSIF start = '0' AND count = "01" THEN
					next_state <= mid;
				ELSE
					next_state <= err;
				END IF;
			WHEN msb =>
				IF start = '0' AND count = "11" THEN
					next_state <= calc_done;
				ELSE
					next_state <= err;
				END IF;
			WHEN calc_done =>
				IF start = '0' THEN
					next_state <= idle;
				ELSE
					next_state <= err;
				END IF;
			WHEN err =>
				IF start = '1' THEN
					next_state <= lsb;
				ELSE 
					next_state <= err;
				END IF;
		END CASE;
	END PROCESS;

	-- Create process for Mealy output logic for input_sel, shift_sel, done, clk_ena and sclr_n(outputs function of inputs and current_state)
	mealy: PROCESS (current_state, start, count) 
	BEGIN
	
		-- Initialize outputs to default values so case only covers when they change
		input_sel <= "XX";
		shift_sel <= "XX";
		done <= '0';
		clk_ena <= '0';
		sclr_n <= '1';
		
		CASE current_state IS
			WHEN idle =>
				IF start = '1' THEN
					sclr_n <= '0';
					clk_ena <= '1';
				END IF;
			WHEN lsb =>
				IF start = '0' and count = "00" THEN
					input_sel <= "00";
					shift_sel <= "00";
					clk_ena <= '1';
				END IF;
			WHEN mid =>
				IF start = '0' and count = "10" THEN
					input_sel <= "10";
					shift_sel <= "01";
					clk_ena <= '1';
				ELSIF start = '0' and count = "01" THEN
					input_sel <= "01";
					shift_sel <= "01";
					clk_ena <= '1';
				END IF;
			WHEN msb =>
				IF start = '0' and count = "11" THEN
					input_sel <= "11";
					shift_sel <= "10";
					clk_ena <= '1';
				END IF;
			WHEN calc_done =>
				IF start = '0' THEN
					done <= '1';
				END IF;
			WHEN err =>
				IF start = '1' THEN
					sclr_n <= '0';
					clk_ena <= '1';
				END IF;
		END CASE;
	END PROCESS mealy;

	-- Create process for Moore output logic for state_out  (outputs function of current_state only)
		moore: PROCESS(current_state)
		BEGIN
			-- Initialize state_out to default values so case only covers when they change
			state_out <= "000";
			
			CASE current_state IS
				WHEN idle =>
					state_out <= "000";
				WHEN lsb =>
					state_out <= "001";
				WHEN mid =>
					state_out <= "010";
				WHEN msb =>
					state_out <= "011";
				WHEN calc_done =>
					state_out <= "100";
				WHEN err =>
					state_out <= "101";
			END CASE;

		END PROCESS moore;
END ARCHITECTURE arch_mult_control;