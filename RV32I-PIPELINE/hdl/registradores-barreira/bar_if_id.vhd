library IEEE;
use IEEE.std_logic_1164.all;

entity bar_if_id is
port ( i_RST       : in  std_logic;                      -- reset
       i_CLK       : in  std_logic;                      -- clock
       i_PC_OUT_IF : in  std_logic_vector(31 downto 0);
       i_INST_IF   : in  std_logic_vector(31 downto 0);
       o_PC_OUT_ID : out std_logic_vector(31 downto 0);
       o_INST_ID   : out std_logic_vector(31 downto 0));
end bar_if_id;

-- 32 bits do pc
-- 32 bits da saída da memória de instrução

architecture arch_1 of bar_if_id is
  -- Declaração de Componentes
  component reg_bar
  generic ( p_DATA_WIDTH : integer);
  port ( i_RST : in  std_logic;
         i_CLK : in  std_logic;
         i_A   : in  std_logic_vector(p_DATA_WIDTH-1 downto 0);
         o_S   : out std_logic_vector(p_DATA_WIDTH-1 downto 0));
  end component;
  
  -- Declaração de Sinais
  signal w_D, w_E : std_logic_vector(63 downto 0);
  
begin
  w_D <= i_INST_IF & i_PC_OUT_IF;
  
  -- Instâncias de Componentes
  u_REG_IF_ID: reg_bar generic map ( p_DATA_WIDTH => 64)
                       port map    ( i_RST => i_RST,
                                     i_CLK => i_CLK,
                                     i_A   => w_D,
                                     o_S   => w_E);

  o_PC_OUT_ID <= w_E(31 downto 0);
  o_INST_ID   <= w_E(63 downto 32);
end arch_1;