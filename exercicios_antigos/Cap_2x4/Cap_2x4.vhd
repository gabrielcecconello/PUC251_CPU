LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Cap_2x4 IS
	PORT (
		s: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		e: IN STD_LOGIC;
		y: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE arch1 OF Cap_2x4 IS
	SIGNAL entradas : STD_LOGIC_VECTOR(2 DOWNTO 0);
BEGIN
		
	entradas <= e & s;
		
	WITH entradas SELECT
			y <= "0001" WHEN "100",
				 "0010" WHEN "101",
				 "0100" WHEN "110",
				 "1000" WHEN "111",
				 "0000" WHEN OTHERS;
END arch1;	

--ARCHITECTURE arch2 OF dec_2x4 IS
	--SIGNAL aux : STD_LOGIC_VECTOR(3 DOWNTO 0);
--BEGIN
		
	--WITH s SELECT
		--	aux <= "0001" WHEN "00",
			--	   "0010" WHEN "01",
				--   "0100" WHEN "10",
				  -- "1000" WHEN "11";
	--y <= aux WHEN e = '1' ELSE
		--"0000";
--END arch2;

--ARCHITECTURE arch3 OF dec_2x4 IS
--BEGIN
	--y(0) <= '1' WHEN e = '1' AND s = "00" ELSE '0';
	--y(1) <= '1' WHEN e = '1' AND s = "01" ELSE '0';
	--y(2) <= '1' WHEN e = '1' AND s = "10" ELSE '0';
	--y(3) <= '1' WHEN e = '1' AND s = "11" ELSE '0';
--END arch3;
				