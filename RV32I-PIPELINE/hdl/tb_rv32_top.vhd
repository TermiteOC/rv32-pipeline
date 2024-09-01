
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_rv32_top is
end tb_rv32_top;

architecture arch_1 of tb_rv32_top is
  -- Declaração de DUV
  component rv32_top is
  port ( i_CLK        : in  std_logic;
         i_RST        : in  std_logic;
         o_ALU_RESULT : out std_logic_vector(31 downto 0));
  end component;

  -- Declaração de Sinais
  signal w_CLK : std_logic := '0';
  signal w_RST : std_logic;
  signal w_ALU : std_logic_vector(31 downto 0);

  -- Definição do Período de Clock
  constant c_CLK_PERIOD : time := 1 ns;

begin
  -- Conectando DUV
  u_DUV: rv32_top port map ( i_CLK        => w_CLK,
                             i_RST        => w_RST,
                             o_ALU_RESULT => w_ALU);

  -- Definições do Processo de Clock
  w_CLK <= not w_CLK after c_CLK_PERIOD /2;

  -- Processo de Estímulo
  process
  begin
    w_RST <= '0';
    wait for 1 ns;
    
    w_RST <= '1';
    wait for 1 ns;
    assert (w_ALU = "00000000000000000000000000000000")
    report "Fail @ 000" severity error;
    
    w_RST <= '0';
    wait for 1 ns;
    assert (w_ALU = "00000000000000000000000000000000")
    report "Fail @ 001" severity error;
    
    wait for 1 ns;
    assert (w_ALU = "00000000000000000000000000000000")
    report "Fail @ 002" severity error;
    
    wait for 1 ns;
    assert (w_ALU = "00000000000000000000000000000000")
    report "Fail @ 003" severity error;
    
    wait for 1 ns;
    assert (w_ALU = "00000000000000000000000000000001")
    report "Fail @ 004" severity error;
    
    wait for 1 ns;
    assert (w_ALU = "00000000000000000000000000000000")
    report "Fail @ 005" severity error;
    
    wait for 1 ns;
    assert (w_ALU = "00000000000000000000000000000101")
    report "Fail @ 006" severity error;
    
    wait for 1 ns;
    assert (w_ALU = "00000000000000000000000000001010")
    report "Fail @ 007" severity error;
    
    wait for 1 ns;
    assert (w_ALU = "00000000000000000000000000000001")
    report "Fail @ 008" severity error;
    
    wait for 1 ns;
    assert (w_ALU = "00000000000000000000000000000000")
    report "Fail @ 009" severity error;
    
    wait for 1 ns;
    assert (w_ALU = "00000000000000000000000000000000")
    report "Fail @ 010" severity error;
    
    wait for 1 ns;
    assert (w_ALU = "00000000000000000000000000000000")
    report "Fail @ 011" severity error;
    
    wait for 1 ns;
    assert (w_ALU = "00000000000000000000000000000000")
    report "Fail @ 012" severity error;
    
    wait for 1 ns;
    assert (w_ALU = "00000000000000000000000000000000")
    report "Fail @ 013" severity error;
    
    wait for 1 ns;
    assert (w_ALU = "00000000000000000000000000001001")
    report "Fail @ 014" severity error;
    
    wait for 1 ns;
    assert (w_ALU = "00000000000000000000000000000001")
    report "Fail @ 015" severity error;
    
    wait for 1 ns;
    assert (w_ALU = "00000000000000000000000000000001")
    report "Fail @ 016" severity error;
    
    wait for 1 ns;
    assert (w_ALU = "00000000000000000000000000000000")
    report "Fail @ 017" severity error;
    
    wait for 1 ns;
    assert (w_ALU = "00000000000000000000000000000010")
    report "Fail @ 018" severity error;
    
    wait for 1 ns;
    assert (w_ALU = "00000000000000000000000000000100")
    report "Fail @ 019" severity error;
    
    wait for 1 ns;
    assert (w_ALU = "00000000000000000000000000000100")
    report "Fail @ 020" severity error;
    
    wait for 1 ns;
    assert (w_ALU = "00000000000000000000000000000100")
    report "Fail @ 021" severity error;
    
    wait for 1 ns;
    assert (w_ALU = "00000000000000000000000000000100")
    report "Fail @ 022" severity error;
    
    wait for 1 ns;
    assert (w_ALU = "00000000000000000000000000001000")
    report "Fail @ 023" severity error;
    
    wait for 1 ns;
    assert (w_ALU = "00000000000000000000000000000000")
    report "Fail @ 024" severity error;
    
    wait for 1 ns;
    assert (w_ALU = "00000000000000000000000000000010")
    report "Fail @ 025" severity error;
    
    wait for 1 ns;
    assert (w_ALU = "11111111111111111111111111111111")
    report "Fail @ 026" severity error;
    
    wait for 1 ns;
    assert (w_ALU = "00000000000000000000000000001101")
    report "Fail @ 027" severity error;
    
    wait for 1 ns;
    assert (w_ALU = "00000000000000000000000000000000")
    report "Fail @ 028" severity error;
    
    -- Clear Inputs
    w_RST <= '0';
    assert false report "Teste concluído com sucesso." severity note;
    wait;
  end process;
end arch_1;
