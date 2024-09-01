library IEEE;
use IEEE.std_logic_1164.all;

entity bar_mem_wb is
port ( i_RST           : in  std_logic;                      -- reset
       i_CLK           : in  std_logic;                      -- clock
       i_REGWRITE_MEM  : in  std_logic;
       i_MEMTOREG_MEM  : in  std_logic;
       i_DATA_MEM      : in  std_logic_vector(31 downto 0);
       i_ALU_RES_MEM   : in  std_logic_vector(31 downto 0);
       i_WRITE_REG_MEM : in  std_logic_vector(4 downto 0);
       o_REGWRITE_WB   : out std_logic;
       o_MEMTOREG_WB   : out std_logic;
       o_DATA_WB       : out std_logic_vector(31 downto 0);
       o_ALU_RES_WB    : out std_logic_vector(31 downto 0);
       o_WRITE_REG_WB  : out std_logic_vector(4 downto 0));
end bar_mem_wb;

-- 2 bits do controle
-- 32 bits da saída da memória de dados
-- 32 bits do resultado da ULA
-- 5  bits da instrução para apontar o endereço de escrita no banco de registradores

architecture arch_1 of bar_mem_wb is
  -- Declaração de Componentes
  component reg_bar
  generic ( p_DATA_WIDTH : integer);
  port ( i_RST : in  std_logic;
         i_CLK : in  std_logic;
         i_A   : in  std_logic_vector(p_DATA_WIDTH-1 downto 0);
         o_S   : out std_logic_vector(p_DATA_WIDTH-1 downto 0));
  end component;
  
  -- Declaração de Sinais
  signal w_D, w_E : std_logic_vector(70 downto 0);
  
begin
  w_D <= i_WRITE_REG_MEM & i_ALU_RES_MEM & i_DATA_MEM & i_MEMTOREG_MEM & i_REGWRITE_MEM;
  
  -- Instâncias de Componentes
  u_REG_MEM_WB: reg_bar generic map ( p_DATA_WIDTH => 71)
                        port map    ( i_RST => i_RST,
                                      i_CLK => i_CLK,
                                      i_A   => w_D,
                                      o_S   => w_E);

  o_REGWRITE_WB  <= w_E(0);
  o_MEMTOREG_WB  <= w_E(1);
  o_DATA_WB      <= w_E(33 downto 2);
  o_ALU_RES_WB   <= w_E(65 downto 34);
  o_WRITE_REG_WB <= w_E(70 downto 66);
end arch_1;