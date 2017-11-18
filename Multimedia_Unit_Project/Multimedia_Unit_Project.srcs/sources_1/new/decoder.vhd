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
          Register_rd_o : out std_logic_vector(4 downto 0);
          Immediate_16_o : out std_logic_vector(15 downto 0);
          LI_Offset_o : out std_logic_vector(1 downto 0);
          Instruction_type_0_o : out std_logic;
          Instruction_type_1_o : out std_logic;
          Opcode_R4_o : out std_logic_vector(1 downto 0);
          Opcode_R3_o : out std_logic_vector(6 downto 0);
          Reg_RS1_o : out std_logic_vector(4 downto 0);
          Reg_RS2_o : out std_logic_vector(4 downto 0);
          Reg_RS3_o : out std_logic_vector(4 downto 0)
          );
end decoder;

architecture Behavioral of decoder is
begin
    Register_rd_o <= instruction(4 downto 0);
    Immediate_16_o <= instruction(20 downto 5);
    LI_Offset_o <= instruction(22 downto 21);
    Instruction_type_0_o <= instruction(23);
    Instruction_type_1_o <= instruction(22);
    Opcode_R4_o <= instruction(21 downto 20);
    Opcode_R3_o <= instruction(21 downto 15);
    Reg_RS1_o <= instruction(9 downto 5);
    Reg_RS2_o <= instruction(14 downto 10);
    Reg_RS3_o <= instruction(19 downto 15);    
end Behavioral;
