LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY ALU IS 
	PORT (
		a_in, b_in: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		c_in: IN STD_LOGIC;
		op_sel: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		r_out: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		c_out, z_out, v_out: OUT STD_LOGIC
	);
END ENTITY;

ARCHITECTURE arch OF ALU IS
	SIGNAL whole: STD_LOGIC_VECTOR(8 DOWNTO 0);
BEGIN
	WITH op_sel SELECT
		whole <= ('0' & a_in) + ('0' & b_in) WHEN "0000", -- ADD
				 ('0' & a_in) + ('0' & b_in) + ("00000000" & c_in) WHEN "0001", -- ADDC
				 ('0' & a_in) - ('0' & b_in) WHEN "0010", -- SUB
				 ('0' & a_in) - ('0' & b_in) - ("00000000" & c_in) WHEN "0011", -- SUBC	
				 '0' & (a_in AND b_in) WHEN "0100", -- AND
				 '0' & (a_in OR b_in) WHEN "0101", -- OR
				 '0' & (a_in XOR b_in) WHEN "0110", -- XOR
				 '0' & NOT a_in WHEN "0111", -- NOT
				 a_in(7) & a_in(6 DOWNTO 0) & a_in(7) WHEN "1000", -- RL
				 a_in(0) & a_in(0) & a_in(7 DOWNTO 1) WHEN "1001", -- RR
				 a_in(7) & a_in(6 DOWNTO 0) & c_in WHEN "1010", -- RLC
				 a_in(0) & c_in & a_in(7 DOWNTO 1) WHEN "1011", -- RRC
				 a_in(7) & a_in(6 DOWNTO 0) & '0' WHEN "1100", -- SLL
				 a_in(0) & '0' & a_in(7 DOWNTO 1) WHEN "1101", -- SRL
				 a_in(0) & a_in(7) & a_in(7 DOWNTO 1) WHEN "1110", -- SRA
				 '0' & b_in WHEN "1111", -- PASS_B
				 (others => '0') WHEN OTHERS;
		
	r_out <= whole(7 DOWNTO 0);
	c_out <= whole(8);
	z_out <= '1' WHEN whole(7 DOWNTO 0) = "00000000" ELSE '0';
		
	WITH op_sel SELECT
		v_out <= (a_in(7) AND b_in(7) AND NOT whole(7)) OR
			 (NOT a_in(7) AND NOT b_in(7) AND whole(7)) WHEN "0000", -- ADD
			 (a_in(7) AND b_in(7) AND NOT whole(7)) OR
			 (NOT a_in(7) AND NOT b_in(7) AND whole(7)) WHEN "0001", -- ADDC
			 (NOT a_in(7) AND b_in(7) AND whole(7)) OR
			 (a_in(7) AND NOT b_in(7) AND NOT whole(7)) WHEN "0010", -- SUB
			 (NOT a_in(7) AND b_in(7) AND whole(7)) OR
			 (a_in(7) AND NOT b_in(7) AND NOT whole(7)) WHEN "0011", -- SUBC
			 '0' WHEN OTHERS;
		
END arch;
		
				 
	