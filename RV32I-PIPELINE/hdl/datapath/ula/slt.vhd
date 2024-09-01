library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
 
entity slt_32bits is
port ( i_A   : in  std_logic_vector (31 downto 0);  -- entrada A
       i_B   : in  std_logic_vector (31 downto 0);  -- entrada B
       o_SLT : out std_logic_vector (31 downto 0)); -- saída resultado slt_32bits
end slt_32bits;
 
architecture arq_1 of slt_32bits is
begin
  process(i_A, i_B)
  begin
    if (signed(i_A) < signed(i_B)) then
      o_SLT <= (others => '0');
      o_SLT(0) <= '1';
    else
      o_SLT <= (others => '0');
    end if;
  end process;
end arq_1;
