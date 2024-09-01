library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity instruction_memory is
port ( i_ADDR : in  std_logic_vector(31 downto 0);  -- Endereço de memória
       o_OUT  : out std_logic_vector(31 downto 0)); -- Dados de saída
end instruction_memory;

architecture arq_1 of instruction_memory is
  type t_MEMORY is array (0 to 255) of std_logic_vector (31 downto 0); -- Cria um tipo memory_array que e um vetor de 256 posicoes que guarda 32 bits em cada uma delas
  signal w_MEM : t_MEMORY := (
    0  => "00000000000000000000000000010011",
    1  => "00000000000000000000010000010011",
    2  => "00000000000100000000010010010011",
    3  => "00000000000000000000100100010011",
    4  => "00000000010100000000100110010011",
    5  => "00000000101000000000101000010011",
    6  => "00000001010010011110001010110011",
    7  => "00000000100100101111001010110011",
    8  => "00000001001010010000001100110011",
    9  => "00000000011000110000001100110011",
    10 => "00000000011001000000001100110011",
    11 => "00000000010100110010000000100011",
    12 => "00000000000000110010001110000011",
    13 => "01000000011110100000101000110011",
    14 => "00000000100110010010111000110011",
    15 => "00000000000110010000100100010011",
    16 => "11111110100111100000000011100011",
    17 => "00000001001110100000101000110011",
    18 => "00000000000000000000000000010011",
    others => (others => '0')
  );

begin 
  o_OUT <= w_MEM(to_integer(unsigned(i_ADDR(9 downto 2))));
end arq_1;