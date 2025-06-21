LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY display IS
  GENERIC (
    active_level : STRING := "low"
  );
  PORT (
    i: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    y: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
  );
END ENTITY;

ARCHITECTURE arch OF display IS
  -- Função que aplica o nível lógico correto conforme o tipo do display
  FUNCTION apply_active_level (
    seg : STD_LOGIC_VECTOR(6 DOWNTO 0)
  ) RETURN STD_LOGIC_VECTOR IS
  BEGIN
    IF active_level = "low" THEN
      RETURN NOT seg; -- ânodo comum (ativa com 0)
    ELSE
      RETURN seg;     -- catôdo comum (ativa com 1)
    END IF;
  END FUNCTION;
BEGIN
  WITH i SELECT
    y <= apply_active_level("0111111") WHEN "0000", -- 0
         apply_active_level("0000110") WHEN "0001", -- 1
         apply_active_level("1011011") WHEN "0010", -- 2
         apply_active_level("1001111") WHEN "0011", -- 3
         apply_active_level("1100110") WHEN "0100", -- 4
         apply_active_level("1101101") WHEN "0101", -- 5
         apply_active_level("1111101") WHEN "0110", -- 6
         apply_active_level("0000111") WHEN "0111", -- 7
         apply_active_level("1111111") WHEN "1000", -- 8
         apply_active_level("1101111") WHEN "1001", -- 9
         apply_active_level("0000000") WHEN OTHERS; -- display desligado para outros números

END ARCHITECTURE;