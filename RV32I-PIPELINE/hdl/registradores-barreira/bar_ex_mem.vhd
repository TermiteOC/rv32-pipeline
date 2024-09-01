library IEEE;
use IEEE.std_logic_1164.all;

entity bar_ex_mem is
port ( i_RST           : in  std_logic;                    -- reset
       i_CLK           : in  std_logic;                    -- clock
       i_REGWRITE_EX   : in  std_logic;
       i_MEMTOREG_EX   : in  std_logic;
       i_BRANCH_EX     : in  std_logic;
       i_MEMREAD_EX    : in  std_logic;
       i_MEMWRITE_EX   : in  std_logic;
       i_BRANCHED_EX   : in  std_logic_vector(31 downto 0);
       i_ZERO_EX       : in  std_logic;
       i_ALU_RES_EX    : in  std_logic_vector(31 downto 0);
       i_READ2_EX      : in  std_logic_vector(31 downto 0);
       i_WRITE_REG_EX  : in  std_logic_vector(4 downto 0);
       o_REGWRITE_MEM  : out std_logic;
       o_MEMTOREG_MEM  : out std_logic;
       o_BRANCH_MEM    : out std_logic;
       o_MEMREAD_MEM   : out std_logic;
       o_MEMWRITE_MEM  : out std_logic;
       o_BRANCHED_MEM  : out std_logic_vector(31 downto 0);
       o_ZERO_MEM      : out std_logic;
       o_ALU_RES_MEM   : out std_logic_vector(31 downto 0);
       o_READ2_MEM     : out std_logic_vector(31 downto 0);
       o_WRITE_REG_MEM : out std_logic_vector(4 downto 0));
end bar_ex_mem;

-- 5 bits do controle
-- 32 bits do offset do beq
-- 1 bit da flag zero da ULA
-- 32 bits do resultado da ULA
-- 32 bits da saída do banco de registradores
-- 5  bits da instrução para apontar o endereço de escrita no banco de registradores

architecture arch_1 of bar_ex_mem is
  -- Declaração de Componentes
  component reg_bar
  generic ( p_DATA_WIDTH : integer);
  port ( i_RST : in  std_logic;
         i_CLK : in  std_logic;
         i_A   : in  std_logic_vector(p_DATA_WIDTH-1 downto 0);
         o_S   : out std_logic_vector(p_DATA_WIDTH-1 downto 0));
  end component;
  
  -- Declaração de Sinais
  signal w_D, w_E : std_logic_vector(106 downto 0);
  
begin
  w_D <= i_WRITE_REG_EX & i_READ2_EX & i_ALU_RES_EX & i_ZERO_EX & i_BRANCHED_EX &
         i_MEMWRITE_EX & i_MEMREAD_EX & i_BRANCH_EX & i_MEMTOREG_EX & i_REGWRITE_EX;
  
  -- Instâncias de Componentes
  u_REG_EX_MEM: reg_bar generic map ( p_DATA_WIDTH => 107)
                        port map    ( i_RST => i_RST,
                                      i_CLK => i_CLK,
                                      i_A   => w_D,
                                      o_S   => w_E);

  o_REGWRITE_MEM  <= w_E(0);
  o_MEMTOREG_MEM  <= w_E(1);
  o_BRANCH_MEM    <= w_E(2);
  o_MEMREAD_MEM   <= w_E(3);
  o_MEMWRITE_MEM  <= w_E(4);
  o_BRANCHED_MEM  <= w_E(36 downto 5);
  o_ZERO_MEM      <= w_E(37);
  o_ALU_RES_MEM   <= w_E(69 downto 38);
  o_READ2_MEM     <= w_E(101 downto 70);
  o_WRITE_REG_MEM <= w_E(106 downto 102);
end arch_1;