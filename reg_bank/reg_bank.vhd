LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY reg_bank IS 
	PORT (
		regn_di: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		regn_wr_sel, regn_rd_sel: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		clk_in, nrst: IN STD_LOGIC;
		c_flag_in, z_flag_in, v_flag_in: IN STD_LOGIC;
		reg_flag_wr_ena, c_flag_wr_ena, z_flag_wr_ena, v_flag_wr_ena: IN STD_LOGIC; 
		regn_do: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		c_flag_out, z_flag_out, v_flag_out: OUT STD_LOGIC
	);
END ENTITY;

ARCHITECTURE arch OF ALU IS
BEGIN
	PROCESS(clk_in, nrst)
		VARIABLE r0, r1, r2, r3: STD_LOGIC_VECTOR(7 DOWNTO 0);
	BEGIN
		IF nrst = '0' THEN
			r0 := (others => '0');
			r1 := (others => '0');
			r2 := (others => '0');
			r3 := (others => '0');
		ELSIF RISING_EDGE(clk) AND regn_wr_en = '1' THEN
			IF reg_wr_en = "00" THEN
				r0 := regn_di;
			ELSIF reg_wr_en = "01" THEN
				r1 := regn_di;
			ELSIF reg_wr_en = "10" THEN
				r2 := regn_di;
			ELSIF reg_wr_en = "11" THEN
				r3 := regn_di;
		
END arch;