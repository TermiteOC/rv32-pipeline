library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity shift_left is
port ( i_DATA   : in  std_logic_vector(31 downto 0);
       o_RESULT : out std_logic_vector(31 downto 0));
end shift_left;

architecture behavioral of shift_left is
begin
  process(i_DATA)
  begin
    o_RESULT <= i_DATA(30 downto 0) & '0';
  end process;
end behavioral;
