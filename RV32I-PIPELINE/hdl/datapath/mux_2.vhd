library IEEE;
use IEEE.std_logic_1164.all;

entity mux_2 is
generic ( p_DATA_WIDTH : integer := 32);
port ( i_SEL : in  std_logic; 
       i_A   : in  std_logic_vector(p_DATA_WIDTH-1 downto 0); 
       i_B   : in  std_logic_vector(p_DATA_WIDTH-1 downto 0); 
       o_OUT : out std_logic_vector(p_DATA_WIDTH-1 downto 0));
end mux_2;

architecture arq1 of mux_2 is
begin
  process(i_SEL, i_A, i_B)
  begin
    if (i_SEL='0') then
      o_OUT <= i_A;
    else
      o_OUT <= i_B;
    end if;
  end process;
end arq1;