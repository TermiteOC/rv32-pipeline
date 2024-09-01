library IEEE;
use IEEE.std_logic_1164.all;
 
entity and_32bits is
port ( i_A   : in  std_logic_vector (31 downto 0);  -- entrada A
       i_B   : in  std_logic_vector (31 downto 0);  -- entrada B
       o_AND : out std_logic_vector (31 downto 0)); -- saída resultado and_32bits
end and_32bits;
 
architecture arq_1 of and_32bits is
begin
  o_AND <= i_A and i_B;
end arq_1;
