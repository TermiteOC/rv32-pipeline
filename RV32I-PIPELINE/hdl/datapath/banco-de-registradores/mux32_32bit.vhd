library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux32_32bit is
port ( i_SEL    : in  std_logic_vector(4 downto 0);   -- Sinal de seleção
       i_DATA0  : in  std_logic_vector(31 downto 0);  -- Dados de entrada 0
       i_DATA1  : in  std_logic_vector(31 downto 0);  -- Dados de entrada 1
       i_DATA2  : in  std_logic_vector(31 downto 0);  -- Dados de entrada 2
       i_DATA3  : in  std_logic_vector(31 downto 0);  -- Dados de entrada 3
       i_DATA4  : in  std_logic_vector(31 downto 0);  -- Dados de entrada 4
       i_DATA5  : in  std_logic_vector(31 downto 0);  -- Dados de entrada 5
       i_DATA6  : in  std_logic_vector(31 downto 0);  -- Dados de entrada 6
       i_DATA7  : in  std_logic_vector(31 downto 0);  -- Dados de entrada 7
       i_DATA8  : in  std_logic_vector(31 downto 0);  -- Dados de entrada 8
       i_DATA9  : in  std_logic_vector(31 downto 0);  -- Dados de entrada 9
       i_DATA10 : in  std_logic_vector(31 downto 0);  -- Dados de entrada 10
       i_DATA11 : in  std_logic_vector(31 downto 0);  -- Dados de entrada 11
       i_DATA12 : in  std_logic_vector(31 downto 0);  -- Dados de entrada 12
       i_DATA13 : in  std_logic_vector(31 downto 0);  -- Dados de entrada 13
       i_DATA14 : in  std_logic_vector(31 downto 0);  -- Dados de entrada 14
       i_DATA15 : in  std_logic_vector(31 downto 0);  -- Dados de entrada 15
       i_DATA16 : in  std_logic_vector(31 downto 0);  -- Dados de entrada 16
       i_DATA17 : in  std_logic_vector(31 downto 0);  -- Dados de entrada 17
       i_DATA18 : in  std_logic_vector(31 downto 0);  -- Dados de entrada 18
       i_DATA19 : in  std_logic_vector(31 downto 0);  -- Dados de entrada 19
       i_DATA20 : in  std_logic_vector(31 downto 0);  -- Dados de entrada 20
       i_DATA21 : in  std_logic_vector(31 downto 0);  -- Dados de entrada 21
       i_DATA22 : in  std_logic_vector(31 downto 0);  -- Dados de entrada 22
       i_DATA23 : in  std_logic_vector(31 downto 0);  -- Dados de entrada 23
       i_DATA24 : in  std_logic_vector(31 downto 0);  -- Dados de entrada 24
       i_DATA25 : in  std_logic_vector(31 downto 0);  -- Dados de entrada 25
       i_DATA26 : in  std_logic_vector(31 downto 0);  -- Dados de entrada 26
       i_DATA27 : in  std_logic_vector(31 downto 0);  -- Dados de entrada 27
       i_DATA28 : in  std_logic_vector(31 downto 0);  -- Dados de entrada 28
       i_DATA29 : in  std_logic_vector(31 downto 0);  -- Dados de entrada 29
       i_DATA30 : in  std_logic_vector(31 downto 0);  -- Dados de entrada 30
       i_DATA31 : in  std_logic_vector(31 downto 0);  -- Dados de entrada 31
       o_S      : out std_logic_vector(31 downto 0)); -- Saída selecionada
end mux32_32bit;

architecture Behavioral of mux32_32bit is

  type t_array_mux is array (0 to 31) of std_logic_vector(31 downto 0);
  signal array_mux : t_array_mux;

begin
  array_mux(0)  <= i_DATA0;
  array_mux(1)  <= i_DATA1;
  array_mux(2)  <= i_DATA2;
  array_mux(3)  <= i_DATA3;
  array_mux(4)  <= i_DATA4;
  array_mux(5)  <= i_DATA5;
  array_mux(6)  <= i_DATA6;
  array_mux(7)  <= i_DATA7;
  array_mux(8)  <= i_DATA8;
  array_mux(9)  <= i_DATA9;
  array_mux(10) <= i_DATA10;
  array_mux(11) <= i_DATA11;
  array_mux(12) <= i_DATA12;
  array_mux(13) <= i_DATA13;
  array_mux(14) <= i_DATA14;
  array_mux(15) <= i_DATA15;
  array_mux(16) <= i_DATA16;
  array_mux(17) <= i_DATA17;
  array_mux(18) <= i_DATA18;
  array_mux(19) <= i_DATA19;
  array_mux(20) <= i_DATA20;
  array_mux(21) <= i_DATA21;
  array_mux(22) <= i_DATA22;
  array_mux(23) <= i_DATA23;
  array_mux(24) <= i_DATA24;
  array_mux(25) <= i_DATA25;
  array_mux(26) <= i_DATA26;
  array_mux(27) <= i_DATA27;
  array_mux(28) <= i_DATA28;
  array_mux(29) <= i_DATA29;
  array_mux(30) <= i_DATA30;
  array_mux(31) <= i_DATA31;

  o_S <= array_mux(to_integer(unsigned(i_SEL)));

end architecture Behavioral;
