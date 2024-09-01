library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity data_memory is
port ( i_CLK      : in  std_logic;
       i_MEMWRITE : in  std_logic;
       i_MEMREAD  : in  std_logic;
       i_ADDRESS  : in  std_logic_vector(31 downto 0);
       i_IN       : in  std_logic_vector(31 downto 0);
       o_OUT      : out std_logic_vector(31 downto 0));
end data_memory;

architecture arch_1 of data_memory is
  type memory_array is array (0 to 511) of std_logic_vector(31 downto 0);
  signal memory : memory_array := (others => (others => '0'));
  
begin
  process(i_CLK, i_MEMWRITE, i_ADDRESS, memory)
  begin
    if rising_edge(i_CLK) then
      if i_MEMWRITE = '1' then
        memory(to_integer(unsigned(i_ADDRESS(10 downto 2)))) <= i_IN;
      end if;
    end if;

    o_OUT <= memory(to_integer(unsigned(i_ADDRESS(10 downto 2))));

  end process;
end arch_1;