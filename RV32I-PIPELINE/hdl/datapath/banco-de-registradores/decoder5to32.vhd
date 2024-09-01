library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity decoder5to32 is
port ( i_SEL : in  std_logic_vector(4 downto 0);   -- Sinal de seleção de 5 bits
       o_OUT : out std_logic_vector(31 downto 0)); -- Saída de 32 bits
end decoder5to32;

architecture arch_1 of decoder5to32 is
begin
  process(i_SEL)
  begin
    o_OUT <= (others => '0');
    o_OUT(to_integer(unsigned(i_SEL))) <= '1';
  end process;
end arch_1;
