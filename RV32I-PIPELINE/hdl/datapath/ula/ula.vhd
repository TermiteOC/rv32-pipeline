library IEEE;
use IEEE.std_logic_1164.all;

entity ula is
port ( i_A    : in  std_logic_vector(31 downto 0);
       i_B    : in  std_logic_vector(31 downto 0);
       i_SEL  : in  std_logic_vector(3  downto 0);
       o_ZERO : out std_logic;
       o_ULA  : out std_logic_vector(31 downto 0));
end ula;

architecture arq_1 of ula is
  component and_32bits is
  port ( i_A   : in  std_logic_vector(31 downto 0);
         i_B   : in  std_logic_vector(31 downto 0);
         o_AND : out std_logic_vector(31 downto 0));
  end component;

  component or_32bits is
  port ( i_A  : in  std_logic_vector(31 downto 0);
         i_B  : in  std_logic_vector(31 downto 0);
         o_OR : out std_logic_vector(31 downto 0));
  end component;

  component somador is
  port ( i_A   : in  std_logic_vector(31 downto 0);
         i_B   : in  std_logic_vector(31 downto 0);
         o_OUT : out std_logic_vector(31 downto 0));
  end component;
  
  component subtrator is
  port ( i_A   : in  std_logic_vector(31 downto 0);
         i_B   : in  std_logic_vector(31 downto 0);
         o_OUT : out std_logic_vector(31 downto 0));
  end component;

  component slt_32bits is
  port ( i_A   : in  std_logic_vector(31 downto 0);
         i_B   : in  std_logic_vector(31 downto 0);
         o_SLT : out std_logic_vector(31 downto 0));
  end component;

  component nor_32bits is
  port ( i_A   : in  std_logic_vector(31 downto 0);
         i_B   : in  std_logic_vector(31 downto 0);
         o_NOR : out std_logic_vector(31 downto 0));
  end component;


  component seletor_ula is
  port ( i_AND       : in  std_logic_vector (31 downto 0);
         i_OR        : in  std_logic_vector (31 downto 0);
         i_ADD       : in  std_logic_vector (31 downto 0);
         i_SUB       : in  std_logic_vector (31 downto 0);
         i_SLT       : in  std_logic_vector (31 downto 0);
         i_NOR       : in  std_logic_vector (31 downto 0);
         i_SELETOR   : in  std_logic_vector (3  downto 0);
         o_RESULTADO : out std_logic_vector (31 downto 0));
  end component;
  
  signal w_0, w_1, w_2, w_3, w_4, w_5, w_ULA : std_logic_vector(31 downto 0);

begin
  -- Instâncias dos componentes
  u_AND : and_32bits port map ( i_A   => i_A,
                                i_B   => i_B,
                                o_AND => w_0);

  u_OR : or_32bits port map ( i_A  => i_A,
                              i_B  => i_B,
                              o_OR => w_1);
                              
  u_SOMA : somador port map ( i_A   => i_A,
                              i_B   => i_B,
                              o_OUT => w_2);
                              
  u_SUB : subtrator port map ( i_A   => i_A,
                               i_B   => i_B,
                               o_OUT => w_3);

  u_SLT : slt_32bits port map ( i_A   => i_A,
                                i_B   => i_B,
                                o_SLT => w_4);

  u_NOR : nor_32bits port map ( i_A   => i_A,
                                i_B   => i_B,
                                o_NOR => w_5);

  u_SELETOR : seletor_ula port map ( i_AND       => w_0,
                                     i_OR        => w_1,
                                     i_ADD       => w_2,
                                     i_SUB       => w_3,
                                     i_SLT       => w_4,
                                     i_NOR       => w_5,
                                     i_SELETOR   => i_SEL,
                                     o_RESULTADO => W_ULA);

  process(w_ULA) 
  begin
    o_ULA <= w_ULA;
    if (w_ULA = "00000000000000000000000000000000") then
      o_ZERO <= '1';
    else
      o_ZERO <= '0';
    end if;
  end process;
end arq_1;