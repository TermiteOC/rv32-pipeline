library IEEE;
use IEEE.std_logic_1164.all;
 
entity nor_32bits is
port ( i_A   : in  std_logic_vector (31 downto 0);  -- entrada A
       i_B   : in  std_logic_vector (31 downto 0);  -- entrada B
       o_NOR : out std_logic_vector (31 downto 0)); -- saída resultado nor_32bits
end nor_32bits;
 
architecture arq_1 of nor_32bits is
begin
  o_NOR <= i_A nor i_B;
end arq_1;
