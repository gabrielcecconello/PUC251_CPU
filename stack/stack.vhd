LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY stack IS 
	PORT (
		stack_in: IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		clk_in, nrst: IN STD_LOGIC;
		stack_push, stack_pop: IN STD_LOGIC; 
		stack_out: OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE arch OF stack IS
	SIGNAL R0, R1, R2, R3, R4, R5, R6, R7: STD_LOGIC_VECTOR(10 DOWNTO 0);
BEGIN
	-- Código Sequencial para push e pop na pilha.
	PROCESS(clk_in, nrst)
	BEGIN
		IF nrst = '0' THEN
			R0 <= (others => '0');
			R1 <= (others => '0');
			R2 <= (others => '0');
			R3 <= (others => '0');
			R4 <= (others => '0');
			R5 <= (others => '0');
			R6 <= (others => '0');
			R7 <= (others => '0');
		ELSIF RISING_EDGE(clk_in) THEN
			IF stack_push = '1' THEN
				R7 <= R6;
				R6 <= R5;
				R5 <= R4;
				R4 <= R3;
				R3 <= R2;
				R2 <= R1;
				R1 <= R0;
				R0 <= stack_in;
			ELSIF stack_pop = '1' THEN
				R0 <= R1;
				R1 <= R2;
				R2 <= R3;
				R3 <= R4;
				R4 <= R5;
				R5 <= R6;
				R6 <= R7;
				R7 <= (others => '0');
			END IF;
		END IF;
	END PROCESS;

	stack_out <= R0;
END arch;
