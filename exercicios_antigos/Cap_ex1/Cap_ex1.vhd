LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Cap_ex1 IS
	PORT (
		a: IN STD_LOGIC_VECTOR(2 DOWNTO 0);-- seleção
		ne1, ne2, e3: IN STD_LOGIC; -- enable
		no: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE arch1 OF Cap_ex1 IS
	SIGNAL enable : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
	enable <= e3 & ne2 & ne1 & a;
		WITH enable SELECT
			no <= "11111110" WHEN "100000",
				  "11111101" WHEN "100000",
				  "11111011" WHEN "100000",
				  "11110111" WHEN "100000",
				  "11101111" WHEN "100000",
				  "11011111" WHEN "100000",
				  "10111111" WHEN "100000",
				  "01111111" WHEN "100000",
				  
	

