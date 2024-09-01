library IEEE;
use IEEE.std_logic_1164.all;

entity alu_control is
port ( i_ALU_OP : in  std_logic_vector(1 downto 0);
       i_F      : in  std_logic_vector(3 downto 0); 
       o_Q      : out std_logic_vector(3 downto 0));
end alu_control;

architecture arch_1 of alu_control is
begin
  process(i_ALU_OP, i_F)
  begin
    o_Q(0) <= (i_ALU_OP(1) and not i_ALU_OP(0) and not i_F(3) and i_F(2) and i_F(1) and not i_F(0)) or         -- or
              (i_ALU_OP(1) and not i_ALU_OP(0) and not i_F(3) and not i_F(2) and i_F(1) and not i_F(0));       -- slt

    o_Q(1) <= (i_ALU_OP(1) and not i_ALU_OP(0) and not i_F(3) and not i_F(2) and not i_F(1) and not i_F(0)) or -- add
              (i_ALU_OP(1) and not i_ALU_OP(0) and i_F(3) and not i_F(2) and not i_F(1) and not i_F(0)) or     -- sub
              (i_ALU_OP(1) and not i_ALU_OP(0) and not i_F(3) and not i_F(2) and i_F(1) and not i_F(0)) or     -- slt
              (i_ALU_OP(1) and i_ALU_OP(0) and (not i_F(2)) and (not i_F(1)) and (not i_F(0))) or              -- addi
              (not i_ALU_OP(1) and not i_ALU_OP(0)) or                                                         -- lw, sw
              (not i_ALU_OP(1) and i_ALU_OP(0));                                                               -- beq
              

    o_Q(2) <= (i_ALU_OP(1) and not i_ALU_OP(0) and i_F(3) and not i_F(2) and not i_F(1) and not i_F(0)) or     -- sub
              (i_ALU_OP(1) and not i_ALU_OP(0) and not i_F(3) and not i_F(2) and i_F(1) and not i_F(0)) or     -- slt
              (not i_ALU_OP(1) and i_ALU_OP(0));                                                               -- beq

    o_Q(3) <=  '0';

  end process;
end arch_1;
