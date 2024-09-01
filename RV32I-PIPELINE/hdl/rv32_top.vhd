library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity rv32_top is
port ( i_CLK        : in  std_logic;
       i_RST        : in  std_logic;
       o_ALU_RESULT : out std_logic_vector(31 downto 0));
end rv32_top;

architecture arch_1 of rv32_top is 
  -- Declaracao de Componentes
  component reg_file is
  port ( i_CLK        : in std_logic;
         i_READ_REG1  : in std_logic_vector(4 downto 0);
         i_READ_REG2  : in std_logic_vector(4 downto 0);
         i_WRITE_REG  : in std_logic_vector(4 downto 0);
         i_WRITE_DATA : in std_logic_vector(31 downto 0);
         i_REGWRITE   : in std_logic;
         o_READ_DATA1 : out std_logic_vector(31 downto 0);
         o_READ_DATA2 : out std_logic_vector(31 downto 0));
  end component;
  
  component somador is
  port ( i_A   : in  std_logic_vector(31 downto 0);
         i_B   : in  std_logic_vector(31 downto 0);
         o_OUT : out std_logic_vector(31 downto 0));
  end component;
  
  component ula is
  port ( i_A    : in  std_logic_vector(31 downto 0);
         i_B    : in  std_logic_vector(31 downto 0);
         i_SEL  : in  std_logic_vector(3  downto 0);
         o_ZERO : out std_logic;
         o_ULA  : out std_logic_vector(31 downto 0));
  end component;
  
  component data_memory is
  port ( i_CLK      : in  std_logic;
         i_MEMWRITE : in  std_logic;
         i_MEMREAD  : in  std_logic;
         i_ADDRESS  : in  std_logic_vector(31 downto 0);
         i_IN       : in  std_logic_vector(31 downto 0);
         o_OUT      : out std_logic_vector(31 downto 0));
  end component;
  
  component imm_gen is
  port ( i_INST : in  std_logic_vector(31 downto 0);
         o_IMM  : out std_logic_vector(31 downto 0));
  end component;
  
  component instruction_memory is
  port ( i_ADDR : in  std_logic_vector(31 downto 0);
         o_OUT  : out std_logic_vector(31 downto 0));
  end component;
  
  component mux_2 is
  port ( i_SEL : in  std_logic;
         i_A   : in  std_logic_vector(31 downto 0);
         i_B   : in  std_logic_vector(31 downto 0);
         o_OUT : out std_logic_vector(31 downto 0));
  end component;
  
  component reg is
  port ( i_RST : in  std_logic;
         i_CLK : in  std_logic;
         i_A   : in  std_logic_vector(31 downto 0);
         o_S   : out std_logic_vector(31 downto 0));
  end component;
  
  component shift_left is
  port ( i_DATA   : in  std_logic_vector(31 downto 0);
         o_RESULT : out std_logic_vector(31 downto 0));
  end component;
  
  component alu_control is
  port ( i_ALU_OP : in  std_logic_vector(1 downto 0);
         i_F      : in  std_logic_vector(3 downto 0);
         o_Q      : out std_logic_vector(3 downto 0));
  end component;
  
  component main_control is
  port ( i_OP       : in  std_logic_vector(6 downto 0);
         o_ALU_OP   : out std_logic_vector(1 downto 0);
         o_ALUSRC   : out std_logic;
         o_MEMTOREG : out std_logic;
         o_REGWRITE : out std_logic;
         o_MEMREAD  : out std_logic;
         o_MEMWRITE : out std_logic;
         o_BRANCH   : out std_logic);
  end component;
  
  component bar_if_id is
  port ( i_RST       : in  std_logic;
         i_CLK       : in  std_logic;
         i_PC_OUT_IF : in  std_logic_vector(31 downto 0);
         i_INST_IF   : in  std_logic_vector(31 downto 0);
         o_PC_OUT_ID : out std_logic_vector(31 downto 0);
         o_INST_ID   : out std_logic_vector(31 downto 0));
  end component;

  component bar_id_ex is
  port ( i_RST          : in  std_logic;
         i_CLK          : in  std_logic;
         i_REGWRITE_ID  : in  std_logic;
         i_MEMTOREG_ID  : in  std_logic;
         i_BRANCH_ID    : in  std_logic;
         i_MEMREAD_ID   : in  std_logic;
         i_MEMWRITE_ID  : in  std_logic;
         i_ALU_OP_ID    : in  std_logic_vector(1 downto 0);
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
  end component;

  component bar_ex_mem is
  port ( i_RST           : in  std_logic;
         i_CLK           : in  std_logic;
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
  end component;

  component bar_mem_wb is
  port ( i_RST           : in  std_logic;
         i_CLK           : in  std_logic;
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
  end component;
  
  -- Declaracao de Sinais do Datapath
  signal w_PC_OUT_IF     : std_logic_vector(31 downto 0);
  signal w_PC_OUT_ID     : std_logic_vector(31 downto 0);
  signal w_PC_OUT_EX     : std_logic_vector(31 downto 0);

  signal w_INST_IF       : std_logic_vector(31 downto 0);
  signal w_INST_ID       : std_logic_vector(31 downto 0);

  signal w_READ1_ID      : std_logic_vector(31 downto 0);
  signal w_READ1_EX      : std_logic_vector(31 downto 0);
  
  signal w_READ2_ID      : std_logic_vector(31 downto 0);
  signal w_READ2_EX      : std_logic_vector(31 downto 0);
  signal w_READ2_MEM     : std_logic_vector(31 downto 0);

  signal w_IMM_ID        : std_logic_vector(31 downto 0);
  signal w_IMM_EX        : std_logic_vector(31 downto 0);
  
  signal w_WRITE_REG_EX  : std_logic_vector(4 downto 0);
  signal w_WRITE_REG_MEM : std_logic_vector(4 downto 0);
  signal w_WRITE_REG_WB  : std_logic_vector(4 downto 0);
  
  signal w_RS1_EX        : std_logic_vector(4 downto 0);
  signal w_RS2_EX        : std_logic_vector(4 downto 0);
  
  signal w_SRC           : std_logic_vector(31 downto 0);
  
  signal w_ALU_RES_EX    : std_logic_vector(31 downto 0);
  signal w_ALU_RES_MEM   : std_logic_vector(31 downto 0);
  signal w_ALU_RES_WB    : std_logic_vector(31 downto 0);
  
  signal w_DATA_MEM      : std_logic_vector(31 downto 0);
  signal w_DATA_WB       : std_logic_vector(31 downto 0);
  
  signal w_WRITE_DATA_WB : std_logic_vector(31 downto 0);
  
  signal w_SHIFT         : std_logic_vector(31 downto 0);
  
  signal w_BRANCHED_EX   : std_logic_vector(31 downto 0);
  signal w_BRANCHED_MEM  : std_logic_vector(31 downto 0);
  
  signal w_PC4           : std_logic_vector(31 downto 0);
  
  signal w_PC_IN         : std_logic_vector(31 downto 0);
  
  -- Declaracao de Sinais do Controlador
  signal w_REGWRITE_ID  : std_logic;
  signal w_REGWRITE_EX  : std_logic;
  signal w_REGWRITE_MEM : std_logic;
  signal w_REGWRITE_WB  : std_logic;
  signal w_MEMTOREG_ID  : std_logic;
  signal w_MEMTOREG_EX  : std_logic;
  signal w_MEMTOREG_MEM : std_logic;
  signal w_MEMTOREG_WB  : std_logic;
  signal w_BRANCH_ID    : std_logic;
  signal w_BRANCH_EX    : std_logic;
  signal w_BRANCH_MEM   : std_logic;
  signal w_MEMREAD_ID   : std_logic;
  signal w_MEMREAD_EX   : std_logic;
  signal w_MEMREAD_MEM  : std_logic;
  signal w_MEMWRITE_ID  : std_logic;
  signal w_MEMWRITE_EX  : std_logic;
  signal w_MEMWRITE_MEM : std_logic;
  signal w_ALU_OP_ID    : std_logic_vector(1 downto 0);
  signal w_ALU_OP_EX    : std_logic_vector(1 downto 0);
  signal w_ALUSRC_ID    : std_logic;
  signal w_ALUSRC_EX    : std_logic;
  signal w_OP           : std_logic_vector(3 downto 0);
  signal w_FUNCT        : std_logic_vector(3 downto 0);
  signal w_ZERO_EX      : std_logic;
  signal w_ZERO_MEM     : std_logic;
  
begin
  -- Instancias de Componentes
  u_PC: reg port map ( i_RST => i_RST,
                       i_CLK => i_CLK,
                       i_A   => w_PC_IN,
                       o_S   => w_PC_OUT_IF);

  u_ADDER_4: somador port map ( i_A   => w_PC_OUT_IF,
                                i_B   => "00000000000000000000000000000100",
                                o_OUT => w_PC4);

  u_INSTRUCTION: instruction_memory port map ( i_ADDR => w_PC_OUT_IF,
                                               o_OUT  => w_INST_IF);

  u_BAR_IF_ID: bar_if_id port map ( i_RST       => i_RST,
                                    i_CLK       => i_CLK,
                                    i_PC_OUT_IF => w_PC_OUT_IF,
                                    i_INST_IF   => w_INST_IF,
                                    o_PC_OUT_ID => w_PC_OUT_ID,
                                    o_INST_ID   => w_INST_ID);

  u_MAINCTRL: main_control port map ( i_OP       => w_INST_ID(6 downto 0),
                                      o_ALU_OP   => w_ALU_OP_ID,
                                      o_ALUSRC   => w_ALUSRC_ID,
                                      o_MEMTOREG => w_MEMTOREG_ID,
                                      o_REGWRITE => w_REGWRITE_ID,
                                      o_MEMREAD  => w_MEMREAD_ID,
                                      o_MEMWRITE => w_MEMWRITE_ID,
                                      o_BRANCH   => w_BRANCH_ID);

  u_REGFILE: reg_file port map ( i_CLK        => i_CLK,
                                 i_READ_REG1  => w_INST_ID(19 downto 15),
                                 i_READ_REG2  => w_INST_ID(24 downto 20),
                                 i_WRITE_REG  => w_WRITE_REG_WB,
                                 i_WRITE_DATA => w_WRITE_DATA_WB,
                                 i_REGWRITE   => w_REGWRITE_WB,
                                 o_READ_DATA1 => w_READ1_ID,
                                 o_READ_DATA2 => w_READ2_ID);

  u_IMMGEN: imm_gen port map ( i_INST => w_INST_ID,
                               o_IMM  => w_IMM_ID);

  u_BAR_ID_EX: bar_id_ex port map ( i_RST          => i_RST,
                                    i_CLK          => i_CLK,
                                    i_REGWRITE_ID  => w_REGWRITE_ID,
                                    i_MEMTOREG_ID  => w_MEMTOREG_ID,
                                    i_BRANCH_ID    => w_BRANCH_ID,
                                    i_MEMREAD_ID   => w_MEMREAD_ID,
                                    i_MEMWRITE_ID  => w_MEMWRITE_ID,
                                    i_ALU_OP_ID    => w_ALU_OP_ID,
                                    i_ALUSRC_ID    => w_ALUSRC_ID,
                                    i_PC_OUT_ID    => w_PC_OUT_ID,
                                    i_READ1_ID     => w_READ1_ID,
                                    i_READ2_ID     => w_READ2_ID,
                                    i_IMM_ID       => w_IMM_ID,
                                    i_FUNCT_ID     => w_INST_ID(30) & w_INST_ID(14 downto 12),
                                    i_WRITE_REG_ID => w_INST_ID(11 downto 7),
                                    o_REGWRITE_EX  => w_REGWRITE_EX,
                                    o_MEMTOREG_EX  => w_MEMTOREG_EX,
                                    o_BRANCH_EX    => w_BRANCH_EX,
                                    o_MEMREAD_EX   => w_MEMREAD_EX,
                                    o_MEMWRITE_EX  => w_MEMWRITE_EX,
                                    o_ALU_OP_EX    => w_ALU_OP_EX,
                                    o_ALUSRC_EX    => w_ALUSRC_EX,
                                    o_PC_OUT_EX    => w_PC_OUT_EX,
                                    o_READ1_EX     => w_READ1_EX,
                                    o_READ2_EX     => w_READ2_EX,
                                    o_IMM_EX       => w_IMM_EX,
                                    o_FUNCT_EX     => w_FUNCT,
                                    o_WRITE_REG_EX => w_WRITE_REG_EX);

  u_SHIFT: shift_left port map ( i_DATA   => w_IMM_EX,
                                 o_RESULT => w_SHIFT);

  u_ADDER_BRANCH: somador port map ( i_A   => w_PC_OUT_EX,
                                     i_B   => w_SHIFT,
                                     o_OUT => w_BRANCHED_EX);

  u_MUX_IMM: mux_2 port map ( i_SEL => w_ALUSRC_EX,
                              i_A   => w_READ2_EX,
                              i_B   => w_IMM_EX,
                              o_OUT => w_SRC);

  u_ALU: ula port map ( i_A    => w_READ1_EX,
                        i_B    => w_SRC,
                        i_SEL  => w_OP,
                        o_ZERO => w_ZERO_EX,
                        o_ULA  => w_ALU_RES_EX);

  u_ALUCTRL: alu_control port map ( i_ALU_OP => w_ALU_OP_EX,
                                    i_F      => w_FUNCT,
                                    o_Q      => w_OP);

  u_BAR_EX_MEM: bar_ex_mem port map ( i_RST           => i_RST,
                                      i_CLK           => i_CLK,
                                      i_REGWRITE_EX   => w_REGWRITE_EX,
                                      i_MEMTOREG_EX   => w_MEMTOREG_EX,
                                      i_BRANCH_EX     => w_BRANCH_EX,
                                      i_MEMREAD_EX    => w_MEMREAD_EX,
                                      i_MEMWRITE_EX   => w_MEMWRITE_EX,
                                      i_BRANCHED_EX   => w_BRANCHED_EX,
                                      i_ZERO_EX       => w_ZERO_EX,
                                      i_ALU_RES_EX    => w_ALU_RES_EX,
                                      i_READ2_EX      => w_READ2_EX,
                                      i_WRITE_REG_EX  => w_WRITE_REG_EX,
                                      o_REGWRITE_MEM  => w_REGWRITE_MEM,
                                      o_MEMTOREG_MEM  => w_MEMTOREG_MEM,
                                      o_BRANCH_MEM    => w_BRANCH_MEM,
                                      o_MEMREAD_MEM   => w_MEMREAD_MEM,
                                      o_MEMWRITE_MEM  => w_MEMWRITE_MEM,
                                      o_BRANCHED_MEM  => w_BRANCHED_MEM,
                                      o_ZERO_MEM      => w_ZERO_MEM,
                                      o_ALU_RES_MEM   => w_ALU_RES_MEM,
                                      o_READ2_MEM     => w_READ2_MEM,
                                      o_WRITE_REG_MEM => w_WRITE_REG_MEM);

  u_DATA: data_memory port map ( i_CLK      => i_CLK,
                                 i_MEMWRITE => w_MEMWRITE_MEM,
                                 i_MEMREAD  => w_MEMREAD_MEM,
                                 i_ADDRESS  => w_ALU_RES_MEM,
                                 i_IN       => w_READ2_MEM,
                                 o_OUT      => w_DATA_MEM);

  u_BAR_MEM_WB: bar_mem_wb port map ( i_RST           => i_RST,
                                      i_CLK           => i_CLK,
                                      i_REGWRITE_MEM  => w_REGWRITE_MEM,
                                      i_MEMTOREG_MEM  => w_MEMTOREG_MEM,
                                      i_DATA_MEM      => w_DATA_MEM,
                                      i_ALU_RES_MEM   => w_ALU_RES_MEM,
                                      i_WRITE_REG_MEM => w_WRITE_REG_MEM,
                                      o_REGWRITE_WB   => w_REGWRITE_WB,
                                      o_MEMTOREG_WB   => w_MEMTOREG_WB,
                                      o_DATA_WB       => w_DATA_WB,
                                      o_ALU_RES_WB    => w_ALU_RES_WB,
                                      o_WRITE_REG_WB  => w_WRITE_REG_WB);

  u_MUX_MEMORY: mux_2 port map ( i_SEL => w_MEMTOREG_WB,
                                 i_A   => w_ALU_RES_WB,
                                 i_B   => w_DATA_WB,
                                 o_OUT => w_WRITE_DATA_WB);

  u_MUX_BRANCH: mux_2 port map ( i_SEL => w_BRANCH_MEM and w_ZERO_MEM,
                                 i_A   => w_PC4,
                                 i_B   => w_BRANCHED_MEM,
                                 o_OUT => w_PC_IN);

  o_ALU_RESULT <= w_ALU_RES_EX;
end arch_1;