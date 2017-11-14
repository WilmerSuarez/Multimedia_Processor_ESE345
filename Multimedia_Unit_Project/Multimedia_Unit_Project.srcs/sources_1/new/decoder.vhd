----------------------------------------------------------------------------------
-- Engineer(s): Wilmer Suarez, Himanshu Goel 
-- 
-- Create Date: 11/13/2017 07:52:56 PM
-- Design Name: 
-- Module Name: decoder - Behavioral
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

entity decoder is
    Port (
          instruction : in std_logic_vector(23 downto 0);
          Register_rd_o : in std_logic_vector(4 downto 0);
          Immediate_16_o : in std_logic_vector(15 downto 0);
          LI_Offset_o : in std_logic_vector(1 downto 0);
          Instruction_type_0_o : in std_logic;
          Instruction_type_1_o : in std_logic;
          Opcode_R4_o : in std_logic_vector(1 downto 0);
          Opcode_R3_o : in std_logic_vector(6 downto 0);
          Reg_RS1_o : in std_logic_vector(4 downto 0);
          Reg_RS2_o : in std_logic_vector(4 downto 0);
          Reg_RS3_o : in std_logic_vector(4 downto 0)
          );
end decoder;

architecture Behavioral of decoder is

begin


end Behavioral;
