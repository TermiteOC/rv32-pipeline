library IEEE;
use IEEE.std_logic_1164.all;

entity seletor_ula is
port ( i_AND       : in  std_logic_vector (31 downto 0);  -- entrada resultado AND
       i_OR        : in  std_logic_vector (31 downto 0);  -- entrada resultado OR
       i_ADD       : in  std_logic_vector (31 downto 0);  -- entrada resultado ADD
       i_SUB       : in  std_logic_vector (31 downto 0);  -- entrada resultado SUB
       i_SLT       : in  std_logic_vector (31 downto 0);  -- entrada resultado SET LESS THAN
       i_NOR       : in  std_logic_vector (31 downto 0);  -- entrada resultado NOR
       i_SELETOR   : in  std_logic_vector (3  downto 0);  -- entrada seletor
       o_RESULTADO : out std_logic_vector (31 downto 0)); -- saída resultado
end seletor_ula;

architecture arq_1 of seletor_ula is
begin
  process(i_AND, i_OR, i_ADD, i_SUB, i_SLT, i_NOR, i_SELETOR)
  begin
    case i_SELETOR is
      when "0000" =>
        o_RESULTADO <= i_AND;
      when "0001" =>
        o_RESULTADO <= i_OR;
      when "0010" =>
        o_RESULTADO <= i_ADD;
      when "0110" =>
        o_RESULTADO <= i_SUB;
      when "0111" =>
        o_RESULTADO <= i_SLT;
      when "1100" =>
        o_RESULTADO <= i_NOR;
      when others =>
        o_RESULTADO <= i_AND; -- caso seletor seja outro valor, retorna resultado de and
    end case;
  end process;
end arq_1;
