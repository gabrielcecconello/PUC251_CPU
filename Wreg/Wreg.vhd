LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY Wreg IS 
	PORT (
		d_in: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		clk_in, nrst: IN STD_LOGIC;
		wr_en: IN STD_LOGIC; 
		w_out: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE arch OF Wreg IS
	SIGNAL r: STD_LOGIC_VECTOR(7 DOWNTO 0);
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