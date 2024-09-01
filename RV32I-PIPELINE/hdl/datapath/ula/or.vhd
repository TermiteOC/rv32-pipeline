library IEEE;
use IEEE.std_logic_1164.all;
 
entity or_32bits is
port ( i_A  : in  std_logic_vector (31 downto 0);  -- entrada A
       i_B  : in  std_logic_vector (31 downto 0);  -- entrada B
       o_OR : out std_logic_vector (31 downto 0)); -- saída resultado or_32bits
end or_32bits;
 
architecture arq_1 of or_32bits is
begin
  o_OR <= i_A or i_B;
end arq_1;
