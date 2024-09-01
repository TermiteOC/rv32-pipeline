library IEEE;
use IEEE.std_logic_1164.all;

entity reg_bar is
generic ( p_DATA_WIDTH : integer);
port ( i_RST : in  std_logic;                                  -- reset
       i_CLK : in  std_logic;                                  -- clock
       i_A   : in  std_logic_vector(p_DATA_WIDTH-1 downto 0);  -- data input
       o_S   : out std_logic_vector(p_DATA_WIDTH-1 downto 0)); -- data output
end reg_bar;

architecture arch_1 of reg_bar is
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