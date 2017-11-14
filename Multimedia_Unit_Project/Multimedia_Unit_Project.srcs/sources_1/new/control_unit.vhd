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
--use IEEE.NUMERIC_STD.ALL;


entity control_unit is
    Port (
          Instruction_type_0 : in std_logic;
          Instruction_type_1 : in std_logic;
          Opcode_R4 : in std_logic_vector(1 downto 0);
          Opcode_R3 : in std_logic_vector(6 downto 0)
          );
end control_unit;

architecture Behavioral of control_unit is

begin


end Behavioral;
