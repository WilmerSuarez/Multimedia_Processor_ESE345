----------------------------------------------------------------------------------
-- Engineer(s): Wilmer Suarez, Himanshu Goel 
-- 
-- Create Date: 11/13/2017 07:52:56 PM
-- Design Name: Control Unit
-- Module Name: decoder - Behavioral
-- Project Name: Multimedia_Processor 
-- Tool Versions: Vivado 2017.3
--
-- Description: Decodes instruction input to provide fields for all instruction formats.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder is
    Port (
          --***** INPUT *****--
          instruction : in std_logic_vector(23 downto 0);   -- Instruction
          --***** OUTPUTS *****--
          Register_rd_o : out std_logic_vector(4 downto 0); -- Write Back register address
          Immediate_16_o : out std_logic_vector(15 downto 0);   -- 16 bit Immediate for Load Immediate Instruction
          LI_Offset_o : out std_logic_vector(1 downto 0);   -- Load Immediate Instruction offset for 16 bit Immediate
          Opcode_R4_o : out std_logic_vector(1 downto 0);   -- Opcode for R4 instruction format
          Opcode_R3_o : out std_logic_vector(6 downto 0);   -- Opcode for R3 instruction format
          Reg_RS1_o : out std_logic_vector(4 downto 0); -- Address for register RS1
          Reg_RS2_o : out std_logic_vector(4 downto 0); -- Address for register RS2
          Reg_RS3_o : out std_logic_vector(4 downto 0);  -- Address for register RS3
          Instruction_o : out std_logic_vector(23 downto 0) -- Instruction propagate for control unit
          );
end decoder;

architecture Behavioral of decoder is
begin
    Register_rd_o <= instruction(4 downto 0);
    Immediate_16_o <= instruction(20 downto 5);
    LI_Offset_o <= instruction(22 downto 21);
    Opcode_R4_o <= instruction(21 downto 20);
    Opcode_R3_o <= instruction(21 downto 15);
    Reg_RS1_o <= instruction(9 downto 5);
    Reg_RS2_o <= instruction(14 downto 10);
    Reg_RS3_o <= instruction(19 downto 15); 
    instruction_o <= instruction;   
end Behavioral;
