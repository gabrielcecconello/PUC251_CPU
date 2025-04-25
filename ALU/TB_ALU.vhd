library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_alu is
end tb_alu;

architecture behavior of tb_alu is

    -- Componente da ALU
    component ALU
        Port (
            a_in   : in  STD_LOGIC_VECTOR(7 downto 0);
            b_in   : in  STD_LOGIC_VECTOR(7 downto 0);
            c_in   : in  STD_LOGIC;
            op_sel : in  STD_LOGIC_VECTOR(3 downto 0);
            r_out  : out STD_LOGIC_VECTOR(7 downto 0);
            c_out  : out STD_LOGIC;
            z_out  : out STD_LOGIC;
            v_out  : out STD_LOGIC
        );
    end component;

    -- Sinais de teste
    signal a_in, b_in : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal c_in       : STD_LOGIC := '0';
    signal op_sel     : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal r_out      : STD_LOGIC_VECTOR(7 downto 0);
    signal c_out, z_out, v_out : STD_LOGIC;

begin

    -- Instância da UUT (Unit Under Test)
    UUT: ALU port map (
        a_in => a_in,
        b_in => b_in,
        c_in => c_in,
        op_sel => op_sel,
        r_out => r_out,
        c_out => c_out,
        z_out => z_out,
        v_out => v_out
    );

    -- Geração de estímulos
    stim_proc: process
    begin
        -- Exemplo 1: ADD 0x37 + 0x10 = 0x47, sem carry
        a_in <= x"37"; b_in <= x"10"; c_in <= '0'; op_sel <= "0000";
        wait for 50 ns;

        -- Exemplo 2: ADD 0x10 + 0xF7 = 0x07, com carry
        a_in <= x"10"; b_in <= x"F7"; op_sel <= "0000";
        wait for 50 ns;

        -- Exemplo 3: ADD 0x70 + 0x90 = 0x00, carry = 1, overflow = 1
        a_in <= x"70"; b_in <= x"90"; op_sel <= "0000";
        wait for 50 ns;

        -- Exemplo 4: SUB 0x02 - 0x01 = 0x01, sem borrow
        a_in <= x"02"; b_in <= x"01"; op_sel <= "0010";
        wait for 50 ns;

        -- Exemplo 5: SUB 0x02 - 0x02 = 0x00, z_out = 1
        a_in <= x"02"; b_in <= x"02"; op_sel <= "0010";
        wait for 50 ns;

        -- Exemplo 6: SUB 0x02 - 0x03 = 0xFF, borrow = 1
        a_in <= x"02"; b_in <= x"03"; op_sel <= "0010";
        wait for 50 ns;

        -- Adicione mais testes conforme necessário (AND, OR, RL, etc.)

        wait; -- Espera infinita
    end process;

end behavior;
