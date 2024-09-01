library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity reg_file is
port ( i_CLK        : in std_logic;                       -- Sinal de clock
       i_READ_REG1  : in std_logic_vector(4 downto 0);    -- Número do registrador a ser lido (primeiro)
       i_READ_REG2  : in std_logic_vector(4 downto 0);    -- Número do registrador a ser lido (segundo)
       i_WRITE_REG  : in std_logic_vector(4 downto 0);    -- Número do registrador a ser escrito
       i_WRITE_DATA : in std_logic_vector(31 downto 0);   -- Dados a serem escritos no registrador
       i_REGWRITE   : in std_logic;                       -- Sinal de controle para escrita
       o_READ_DATA1 : out std_logic_vector(31 downto 0);  -- Dados lidos do primeiro registrador
       o_READ_DATA2 : out std_logic_vector(31 downto 0)); -- Dados lidos do segundo registrador
end reg_file;

architecture arch_1 of reg_file is
  -- Declaração de Componentes
  component mux32_32bit is
  port ( i_SEL    : in  std_logic_vector(4 downto 0);
         i_DATA0  : in  std_logic_vector(31 downto 0);
         i_DATA1  : in  std_logic_vector(31 downto 0);
         i_DATA2  : in  std_logic_vector(31 downto 0);
         i_DATA3  : in  std_logic_vector(31 downto 0);
         i_DATA4  : in  std_logic_vector(31 downto 0);
         i_DATA5  : in  std_logic_vector(31 downto 0);
         i_DATA6  : in  std_logic_vector(31 downto 0);
         i_DATA7  : in  std_logic_vector(31 downto 0);
         i_DATA8  : in  std_logic_vector(31 downto 0);
         i_DATA9  : in  std_logic_vector(31 downto 0);
         i_DATA10 : in  std_logic_vector(31 downto 0);
         i_DATA11 : in  std_logic_vector(31 downto 0);
         i_DATA12 : in  std_logic_vector(31 downto 0);
         i_DATA13 : in  std_logic_vector(31 downto 0);
         i_DATA14 : in  std_logic_vector(31 downto 0);
         i_DATA15 : in  std_logic_vector(31 downto 0);
         i_DATA16 : in  std_logic_vector(31 downto 0);
         i_DATA17 : in  std_logic_vector(31 downto 0);
         i_DATA18 : in  std_logic_vector(31 downto 0);
         i_DATA19 : in  std_logic_vector(31 downto 0);
         i_DATA20 : in  std_logic_vector(31 downto 0);
         i_DATA21 : in  std_logic_vector(31 downto 0);
         i_DATA22 : in  std_logic_vector(31 downto 0);
         i_DATA23 : in  std_logic_vector(31 downto 0);
         i_DATA24 : in  std_logic_vector(31 downto 0);
         i_DATA25 : in  std_logic_vector(31 downto 0);
         i_DATA26 : in  std_logic_vector(31 downto 0);
         i_DATA27 : in  std_logic_vector(31 downto 0);
         i_DATA28 : in  std_logic_vector(31 downto 0);
         i_DATA29 : in  std_logic_vector(31 downto 0);
         i_DATA30 : in  std_logic_vector(31 downto 0);
         i_DATA31 : in  std_logic_vector(31 downto 0);
         o_S      : out std_logic_vector(31 downto 0));
  end component;

  component decoder5to32 is
  port ( i_SEL : in  std_logic_vector(4 downto 0);
         o_OUT : out std_logic_vector(31 downto 0));
  end component;
  
  -- Declaração de Sinais
  type t_REG_FILE is array (0 to 31) of std_logic_vector(31 downto 0);
  signal w_REG_FILE : t_REG_FILE;
  signal w_REG_OUT : t_REG_FILE;
  signal W_WRITE_ENABLE : std_logic_vector(31 downto 0);

begin
  -- Declaração de Instâncias
  u_DEC : decoder5to32 port map ( i_SEL => i_WRITE_REG,
                                  o_OUT => W_WRITE_ENABLE);

  u_MUX_READ_DATA1 : mux32_32bit port map ( i_SEL    => i_READ_REG1,
                                            i_DATA0  => w_REG_OUT(0),
                                            i_DATA1  => w_REG_OUT(1),
                                            i_DATA2  => w_REG_OUT(2),
                                            i_DATA3  => w_REG_OUT(3),
                                            i_DATA4  => w_REG_OUT(4),
                                            i_DATA5  => w_REG_OUT(5),
                                            i_DATA6  => w_REG_OUT(6),
                                            i_DATA7  => w_REG_OUT(7),
                                            i_DATA8  => w_REG_OUT(8),
                                            i_DATA9  => w_REG_OUT(9),
                                            i_DATA10 => w_REG_OUT(10),
                                            i_DATA11 => w_REG_OUT(11),
                                            i_DATA12 => w_REG_OUT(12),
                                            i_DATA13 => w_REG_OUT(13),
                                            i_DATA14 => w_REG_OUT(14),
                                            i_DATA15 => w_REG_OUT(15),
                                            i_DATA16 => w_REG_OUT(16),
                                            i_DATA17 => w_REG_OUT(17),
                                            i_DATA18 => w_REG_OUT(18),
                                            i_DATA19 => w_REG_OUT(19),
                                            i_DATA20 => w_REG_OUT(20),
                                            i_DATA21 => w_REG_OUT(21),
                                            i_DATA22 => w_REG_OUT(22),
                                            i_DATA23 => w_REG_OUT(23),
                                            i_DATA24 => w_REG_OUT(24),
                                            i_DATA25 => w_REG_OUT(25),
                                            i_DATA26 => w_REG_OUT(26),
                                            i_DATA27 => w_REG_OUT(27),
                                            i_DATA28 => w_REG_OUT(28),
                                            i_DATA29 => w_REG_OUT(29),
                                            i_DATA30 => w_REG_OUT(30),
                                            i_DATA31 => w_REG_OUT(31),
                                            o_S      => o_READ_DATA1);

  u_MUX_READ_DATA2 : mux32_32bit port map ( i_SEL    => i_READ_REG2,
                                            i_DATA0  => w_REG_OUT(0),
                                            i_DATA1  => w_REG_OUT(1),
                                            i_DATA2  => w_REG_OUT(2),
                                            i_DATA3  => w_REG_OUT(3),
                                            i_DATA4  => w_REG_OUT(4),
                                            i_DATA5  => w_REG_OUT(5),
                                            i_DATA6  => w_REG_OUT(6),
                                            i_DATA7  => w_REG_OUT(7),
                                            i_DATA8  => w_REG_OUT(8),
                                            i_DATA9  => w_REG_OUT(9),
                                            i_DATA10 => w_REG_OUT(10),
                                            i_DATA11 => w_REG_OUT(11),
                                            i_DATA12 => w_REG_OUT(12),
                                            i_DATA13 => w_REG_OUT(13),
                                            i_DATA14 => w_REG_OUT(14),
                                            i_DATA15 => w_REG_OUT(15),
                                            i_DATA16 => w_REG_OUT(16),
                                            i_DATA17 => w_REG_OUT(17),
                                            i_DATA18 => w_REG_OUT(18),
                                            i_DATA19 => w_REG_OUT(19),
                                            i_DATA20 => w_REG_OUT(20),
                                            i_DATA21 => w_REG_OUT(21),
                                            i_DATA22 => w_REG_OUT(22),
                                            i_DATA23 => w_REG_OUT(23),
                                            i_DATA24 => w_REG_OUT(24),
                                            i_DATA25 => w_REG_OUT(25),
                                            i_DATA26 => w_REG_OUT(26),
                                            i_DATA27 => w_REG_OUT(27),
                                            i_DATA28 => w_REG_OUT(28),
                                            i_DATA29 => w_REG_OUT(29),
                                            i_DATA30 => w_REG_OUT(30),
                                            i_DATA31 => w_REG_OUT(31),
                                            o_S      => o_READ_DATA2);

  -- Processo para controlar o sinal de escrita
  process(i_CLK)
  begin
    if rising_edge(i_CLK) then
      for i in 0 to 31 loop
        if i /= 0 then
          if i_REGWRITE = '1' and W_WRITE_ENABLE(i) = '1' then
            w_REG_FILE(i) <= i_WRITE_DATA;
          end if;
        end if;
      end loop;
    end if;
  end process;

  -- Atribuição das saídas dos registradores
  process(w_REG_FILE)
  begin
    for i in 0 to 31 loop
      if i = 0 then
        w_REG_OUT(i) <= (others => '0');
      else
        w_REG_OUT(i) <= w_REG_FILE(i);
      end if;
    end loop;
  end process;
end arch_1;
