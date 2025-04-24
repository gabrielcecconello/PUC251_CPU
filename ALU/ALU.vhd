LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY ALU IS 
	PORT (
		a_in, b_in: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		c_in: IN STD_LOGIC;
		op: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		r: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		c_out, z, v: OUT STD_LOGIC
	);
END ENTITY;

ARCHITECTURE arch OF ALU IS
	SIGNAL whole: STD_LOGIC_VECTOR(8 DOWNTO 0);
BEGIN
	WITH op SELECT
		whole <= ('0' & a_in) + ('0' & b_in) WHEN "0000",
				 ('0' & a_in) + ('0' & b_in) + ("00000000" & c_in) WHEN "0001",
				 ('0' & a_in) - ('0' & b_in) WHEN "0010",
				 ('0' & a_in) - ('0' & b_in) - ("00000000" & c_in) WHEN "0011",	
				 '0' & (a_in AND b_in) WHEN "0100",
				 '0' & (a_in OR b_in) WHEN "0101",
				 '0' & (a_in XOR b_in) WHEN "0110",
				 '0' & NOT a_in WHEN "0111",
				 a_in(7) & a_in(6 DOWNTO 0) & a_in(7) WHEN "1000",
				 a_in(0) & a_in(0) & a_in(7 DOWNTO 1) WHEN "1001",
				 a_in(7) & a_in(6 DOWNTO 0) & c_in WHEN "1010",
				 a_in(0) & c_in & a_in(7 DOWNTO 1) WHEN "1011",
				 a_in(7) & a_in(6 DOWNTO 0) & '0' WHEN "1100",
				 a_in(0) & '0' & a_in(7 DOWNTO 1) WHEN "1101",
				 a_in(0) & a_in(7) & a_in(7 DOWNTO 1) WHEN "1101",
				 '0' & b_in WHEN "1111",
				 (others => '0) WHEN OTHERS;
		
	r <= whole(7 DOWNTO 0);
	c_out <= whole(8);
	z <= '1' WHEN whole(7 DOWNTO 0) = "00000000" ELSE '0';
		
	WITH op SELECT
		v <= (a_in[7] AND b_in[7] AND NOT r[7]) OR
			 (NOT a_in[7] AND NOT b_in[7] AND r[7]) WHEN "0000",
			 (a_in[7] AND b_in[7] AND NOT r[7]) OR
			 (NOT a_in[7] AND NOT b_in[7] AND r[7]) WHEN "0001",
			 (NOT a_in[7] AND b_in[7] AND r[7]) OR
			 (a_in[7] AND NOT b_in[7] AND NOT r[7]) WHEN "0010",
			 (NOT a_in[7] AND b_in[7] AND r[7]) OR
			 (a_in[7] AND NOT b_in[7] AND NOT r[7]) WHEN "0011",
			 '0' WHEN OTHERS;
		
END arch;
		
				 
	