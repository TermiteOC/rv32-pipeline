library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
 
entity somador is
port ( i_A   : in  std_logic_vector(31 downto 0);  -- entrada A
       i_B   : in  std_logic_vector(31 downto 0);  -- entrada B
       o_OUT : out std_logic_vector(31 downto 0)); -- saída resultado
end somador;
 
architecture arq_1 of somador is
begin
  process(i_A, i_B)
  begin
    o_OUT <= std_logic_vector(signed(i_A) + signed(i_B));
  end process;
end arq_1;
