----------------------------------------------------------------------------------
-- Engineer(s): Wilmer Suarez, Himanshu Goel 
-- 
-- Create Date: 11/13/2017 06:46:36 PM
-- Design Name: 
-- Module Name: IF_ID_REG - Behavioral
-- Project Name: 
-- Tool Versions: 
-- Description: 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IF_ID_REG is
    Port (
          CLK : in std_logic;
          Instruction_In : in std_logic_vector(23 downto 0);
          disable : in std_logic;
          Instruction_Out : out std_logic_vector(23 downto 0)
          );
end IF_ID_REG;

architecture Behavioral of IF_ID_REG is
begin
    IF_ID_Proc : process(CLK, disable) is
    begin
        if(rising_edge(CLK) and disable = '0') then
            Instruction_Out <= Instruction_In;
        end if;
        if(rising_edge(CLK) and disable = '1') then
            Instruction_Out <= (others => '0');
        end if;
    end process IF_ID_Proc;
end Behavioral;
