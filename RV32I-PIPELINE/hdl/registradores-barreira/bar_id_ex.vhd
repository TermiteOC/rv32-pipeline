library IEEE;
use IEEE.std_logic_1164.all;

entity bar_id_ex is
port ( i_RST          : in  std_logic;                     -- reset
       i_CLK          : in  std_logic;                     -- clock
       i_REGWRITE_ID  : in  std_logic;
       i_MEMTOREG_ID  : in  std_logic;
       i_BRANCH_ID    : in  std_logic;
       i_MEMREAD_ID   : in  std_logic;
       i_MEMWRITE_ID  : in  std_logic;
       i_ALU_OP_ID     : in  std_logic_vector(1 downto 0);
       i_ALUSRC_ID    : in  std_logic;
       i_PC_OUT_ID    : in  std_logic_vector(31 downto 0);
       i_READ1_ID     : in  std_logic_vector(31 downto 0);
       i_READ2_ID     : in  std_logic_vector(31 downto 0);
       i_IMM_ID       : in  std_logic_vector(31 downto 0);
       i_FUNCT_ID     : in  std_logic_vector(3 downto 0);
       i_WRITE_REG_ID : in  std_logic_vector(4 downto 0);
       o_REGWRITE_EX  : out std_logic;
       o_MEMTOREG_EX  : out std_logic;
       o_BRANCH_EX    : out std_logic;
       o_MEMREAD_EX   : out std_logic;
       o_MEMWRITE_EX  : out std_logic;
       o_ALU_OP_EX    : out std_logic_vector(1 downto 0);
       o_ALUSRC_EX    : out std_logic;
       o_PC_OUT_EX    : out std_logic_vector(31 downto 0);
       o_READ1_EX     : out std_logic_vector(31 downto 0);
       o_READ2_EX     : out std_logic_vector(31 downto 0);
       o_IMM_EX       : out std_logic_vector(31 downto 0);
       o_FUNCT_EX     : out std_logic_vector(3 downto 0);
       o_WRITE_REG_EX : out std_logic_vector(4 downto 0));
end bar_id_ex;

-- 8 bits do controle
-- 32 bits do PC
-- 32 bits da saída A do banco de registradores
-- 32 bits da saída B do banco de registradores
-- 32 bits do imediato estendido
-- 4  bits do campo funct da instrução
-- 5  bits da instrução para apontar o endereço de escrita no banco de registradores

architecture arch_1 of bar_id_ex is
  -- Declaração de Componentes
  component reg_bar
  generic ( p_DATA_WIDTH : integer);
  port ( i_RST : in  std_logic;
         i_CLK : in  std_logic;
         i_A   : in  std_logic_vector(p_DATA_WIDTH-1 downto 0);
         o_S   : out std_logic_vector(p_DATA_WIDTH-1 downto 0));
  end component;
  
  -- Declaração de Sinais
  signal w_D, w_E : std_logic_vector(144 downto 0);
  
begin
  w_D <= i_WRITE_REG_ID & i_FUNCT_ID & i_IMM_ID & i_READ2_ID & i_READ1_ID &
         i_PC_OUT_ID & i_ALUSRC_ID & i_ALU_OP_ID & i_MEMWRITE_ID &
         i_MEMREAD_ID & i_BRANCH_ID & i_MEMTOREG_ID & i_REGWRITE_ID;
  
  -- Instâncias de Componentes
  u_REG_ID_EX: reg_bar generic map ( p_DATA_WIDTH => 145)
                       port map    ( i_RST => i_RST,
                                     i_CLK => i_CLK,
                                     i_A   => w_D,
                                     o_S   => w_E);

  o_REGWRITE_EX  <= w_E(0);
  o_MEMTOREG_EX  <= w_E(1);
  o_BRANCH_EX    <= w_E(2);
  o_MEMREAD_EX   <= w_E(3);
  o_MEMWRITE_EX  <= w_E(4);
  o_ALU_OP_EX    <= w_E(6 downto 5);
  o_ALUSRC_EX    <= w_E(7);
  o_PC_OUT_EX    <= w_E(39 downto 8);
  o_READ1_EX     <= w_E(71 downto 40);
  o_READ2_EX     <= w_E(103 downto 72);
  o_IMM_EX       <= w_E(135 downto 104);
  o_FUNCT_EX     <= w_E(139 downto 136);
  o_WRITE_REG_EX <= w_E(144 downto 140);
end arch_1;