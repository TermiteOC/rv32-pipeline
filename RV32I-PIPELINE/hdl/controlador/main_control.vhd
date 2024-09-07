library IEEE;
use IEEE.std_logic_1164.all;

entity main_control is
port ( i_OP       : in  std_logic_vector(6 downto 0);
       o_ALU_OP   : out  std_logic_vector(1 downto 0);     
       o_ALUSRC   : out std_logic;   
       o_MEMTOREG : out std_logic;   
       o_REGWRITE : out std_logic;   
       o_MEMREAD  : out std_logic;   
       o_MEMWRITE : out std_logic;   
       o_BRANCH   : out std_logic);
end main_control;

architecture arch_1 of main_control is
begin
  process(i_OP)
  begin
    o_ALU_OP(0) <= (i_OP(0) and i_OP(1) and (not i_OP(2)) and (not i_OP(3)) and (not i_OP(4)) and i_OP(5) and i_OP(6)) or             -- beq
                   (i_OP(0) and i_OP(1) and (not i_OP(2)) and (not i_OP(3)) and  i_OP(4) and (not i_OP(5)) and (not i_OP(6)));        -- formato i

    o_ALU_OP(1) <= (i_OP(0) and i_OP(1) and (not i_OP(2)) and (not i_OP(3)) and  i_OP(4) and i_OP(5) and (not i_OP(6))) or            -- formato r
                   (i_OP(0) and i_OP(1) and (not i_OP(2)) and (not i_OP(3)) and  i_OP(4) and (not i_OP(5)) and (not i_OP(6)));        -- formato i

    o_ALUSRC    <= (i_OP(0) and i_OP(1) and (not i_OP(2)) and (not i_OP(3)) and (not i_OP(4)) and (not i_OP(5)) and (not i_OP(6))) or -- lw
                   (i_OP(0) and i_OP(1) and (not i_OP(2)) and (not i_OP(3)) and (not i_OP(4)) and i_OP(5) and (not i_OP(6))) or       -- sw
                   (i_OP(0) and i_OP(1) and (not i_OP(2)) and (not i_OP(3)) and i_OP(4) and (not i_OP(5)) and (not i_OP(6)));         -- formato i;

    o_MEMTOREG  <=  i_OP(0) and i_OP(1) and (not i_OP(2)) and (not i_OP(3)) and (not i_OP(4)) and (not i_OP(5)) and (not i_OP(6));    -- lw

    o_REGWRITE  <= (i_OP(0) and i_OP(1) and (not i_OP(2)) and (not i_OP(3)) and (not i_OP(4)) and (not i_OP(5)) and (not i_OP(6))) or -- lw
                   (i_OP(0) and i_OP(1) and (not i_OP(2)) and (not i_OP(3)) and  i_OP(4) and i_OP(5) and (not i_OP(6))) or            -- formato r
                   (i_OP(0) and i_OP(1) and (not i_OP(2)) and (not i_OP(3)) and i_OP(4) and (not i_OP(5)) and (not i_OP(6)));         -- formato i
 
    o_MEMREAD   <= (i_OP(0) and i_OP(1) and (not i_OP(2)) and (not i_OP(3)) and (not i_OP(4)) and (not i_OP(5)) and (not i_OP(6)));   -- lw
  
    o_MEMWRITE  <=  i_OP(0) and i_OP(1) and (not i_OP(2)) and (not i_OP(3)) and (not i_OP(4)) and i_OP(5) and (not i_OP(6));          -- sw
 
    o_BRANCH    <=  i_OP(0) and i_OP(1) and (not i_OP(2)) and (not i_OP(3)) and (not i_OP(4)) and i_OP(5) and i_OP(6);                -- beq
  end process;
end arch_1;
