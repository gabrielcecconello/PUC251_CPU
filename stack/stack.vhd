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
	-- Código Sequencial para a parte de entrada.
	PROCESS(clk_in, nrst)
	BEGIN
		IF nrst = '0' THEN
			r <= (others => '0');
		ELSIF RISING_EDGE(clk_in) THEN
			IF wr_en = '1' THEN
				r <= d_in;
			END IF;
		END IF;
	END PROCESS;
	
	-- Código Concorrente para a parte de saída.
	w_out <= r;
	
END arch;