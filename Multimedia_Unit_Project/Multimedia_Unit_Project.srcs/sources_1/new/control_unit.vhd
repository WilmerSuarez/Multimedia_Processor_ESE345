----------------------------------------------------------------------------------
-- Engineer(s): Wilmer Suarez, Himanshu Goel 
-- 
-- Create Date: 11/13/2017 06:42:53 PM
-- Design Name: 
-- Module Name: control_unit - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_unit is
    Port (
          Instruction : in std_logic_vector(23 downto 0);
          Result_Select : out std_logic_vector(1 downto 0)
          );
end control_unit;

architecture Behavioral of control_unit is
begin
    Control_Unit_Proc : process(Instruction) is
    begin
        if(Instruction(23) = '1') then
            Result_Select <= "10";
        else
           case Instruction(23 downto 22) is
               when "00" => 
                   Result_Select <= "00";
               when "01" =>
                   Result_Select <= "01";
           end case;
        end if;
    end process Control_Unit_Proc;
end Behavioral;