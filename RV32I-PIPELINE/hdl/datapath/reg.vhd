library IEEE;
use IEEE.std_logic_1164.all;

entity reg is
port ( i_RST : in  std_logic;                      -- reset
       i_CLK : in  std_logic;                      -- clock
       i_A   : in  std_logic_vector(31 downto 0);  -- data input
       o_S   : out std_logic_vector(31 downto 0)); -- data output
end reg;

architecture arch_1 of reg is
begin
  process(i_RST, i_CLK) 
  begin
    if (i_RST = '1') then
      o_S <= (others => '0');
    elsif (rising_edge(i_CLK)) then
      o_S <= i_A;
    end if;
  end process;
end arch_1;