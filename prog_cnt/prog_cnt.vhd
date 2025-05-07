LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY prog_cnt IS 
	PORT (
		new_pc_in, from_stack: IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		clk_in, nrst: IN STD_LOGIC;
		pc_ctrl: IN STD_LOGIC_VECTOR(1 DOWNTO 0); 
		next_pc_out, pc_out: OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE arch OF prog_cnt IS
	SIGNAL comb_out, seq_out: STD_LOGIC_VECTOR(10 DOWNTO 0);
BEGIN
	-- Código sequencial para a parte combinacional do circuito.
	PROCESS (pc_ctrl, seq_out, new_pc_in, from_stack)
	BEGIN
		CASE pc_ctrl IS
			WHEN "00" => comb_out <= seq_out;
			WHEN "01" => comb_out <= new_pc_in;
 			WHEN "10" => comb_out <= from_stack;
			WHEN "11" => comb_out <= seq_out + "00000000001";
			WHEN OTHERS => NULL;
		END CASE;
	END PROCESS;
		
	-- Código sequencial para a parte sequencial do circuito.
	PROCESS(clk_in, nrst)
	BEGIN
		IF nrst = '0' THEN
			seq_out <= (others => '0');
		ELSIF RISING_EDGE(clk_in) THEN
			seq_out <= comb_out;	
		END IF;
	END PROCESS;
	
	pc_out <= seq_out;
	next_pc_out <= comb_out;
	
END arch;