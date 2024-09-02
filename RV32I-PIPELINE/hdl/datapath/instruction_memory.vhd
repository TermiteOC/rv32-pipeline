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
    0  => "00000000000000000000000000010011", -- nop
    1  => "00000000000000000000010000010011", -- addi x8,x0,0
    2  => "00000000000100000000010010010011", -- addi x9,x0,1
    3  => "00000000000000000000100100010011", -- addi x18,x0,0
    4  => "00000000010100000000100110010011", -- addi x19,x0,5
    5  => "00000000101000000000101000010011", -- addi x20,x0,10
    6  => "00000001010010011110001010110011", -- or x5,x19,x20
    7  => "00000000100100101111001010110011", -- and x5,x5,x9
    8  => "00000001001010010000001100110011", -- add x6,x18,x18 
    9  => "00000000011000110000001100110011", -- add x6,x6,x6
    10 => "00000000011001000000001100110011", -- add x6,x8,x6
    11 => "00000000010100110010000000100011", -- sw x5,0(x6)
    12 => "00000000000000110010001110000011", -- lw x7,0(x6)
    13 => "01000000011110100000101000110011", -- sub x20,x20,x7
    14 => "00000000100110010010111000110011", -- slt x28,x18,x9
    15 => "00000000000110010000100100010011", -- addi x18,x18,1
    16 => "11111110100111100000000011100011", -- beq x28,x9,-32
    17 => "00000001001110100000101000110011", -- add x20,x20,x19
    18 => "00000000000000000000000000010011", -- nop
    others => (others => '0')
  );

begin 
  o_OUT <= w_MEM(to_integer(unsigned(i_ADDR(9 downto 2))));
end arq_1;