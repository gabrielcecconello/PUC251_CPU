LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY port_io IS 
	GENERIC (
		base_addr : std_logic_vector(7 downto 0)
	);

	PORT (
		abus: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		dbus: INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		port_io: INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		clk_in, nrst: IN STD_LOGIC;
		wr_en, rd_en: IN STD_LOGIC
	);
END ENTITY;

ARCHITECTURE arch OF port_io IS
	SIGNAL port_reg, dir_reg, latch: STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN
	-- Lógica sequencial de escrita.
	PROCESS(clk_in, nrst)
	BEGIN
		IF nrst = '0' THEN
			port_reg <= (others => '0');
			dir_reg <= (others => '0');
		ELSIF RISING_EDGE(clk_in) THEN
			IF wr_en = '1' THEN	
				IF abus = base_addr THEN
					port_reg <= dbus;
				ELSIF abus = base_addr + "00000001" THEN
					dir_reg <= dbus;
				END IF;
			END IF;
		END IF;
	END PROCESS;
	
	-- Lógica concorrente de leitura.
	dbus <= latch WHEN rd_en = '1' AND abus = base_addr ELSE
			dir_reg WHEN rd_en = '1' AND abus = base_addr + "00000001" ELSE (others => 'Z');
	
	-- Lógica concorrente para a porta se utilizando de 'generate'.	
	gen_io: FOR i IN 0 TO 7 GENERATE
		port_io(i) <= port_reg(i) WHEN dir_reg(i) = '1' ELSE 'Z';
		latch(i) <= port_io(i) WHEN dir_reg(i) = '0';
	END GENERATE;	
END arch;