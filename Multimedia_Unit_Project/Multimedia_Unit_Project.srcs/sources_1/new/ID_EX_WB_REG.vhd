----------------------------------------------------------------------------------
-- Engineer(s): Wilmer Suarez, Himanshu Goel 
-- 
-- Create Date: 11/13/2017 06:48:01 PM
-- Design Name: Instruction Decode / (Execute & Write Back) Pipeline Register
-- Module Name: ID_EX_WB_REG - Behavioral
-- Project Name: Multimedia_Processor
-- Tool Versions: Vivado 2017.3
-- 
-- Description: This is the Instruction Decode / (Execute & Writeback) 
-- pipeline register. Here, input is recieved from the register file, the 
-- instruction decoder, and the control unit (Instruction Decode Stage). These 
-- inputs are then sent to the Execution & Write Back Stage to obtain the final result
-- that will be written back to the register file
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ID_EX_WB_REG is
    Port (
          --***** INPUTS *****--
          CLK : in std_logic; -- Clock
          Result_Select : in std_logic_vector(1 downto 0);  -- Control output that determines where final result comes from
          Register_RD : in std_logic_vector(4 downto 0);    -- Write back register address  
          Immediate_16 : in std_logic_vector(15 downto 0);  -- 16 bit immediate for Load Immediate instruction
          LI_Offset : in std_logic_vector(1 downto 0);  -- Load immediate instruction offset for 16 bit Immediate
          Opcode_R4 : in std_logic_vector(1 downto 0);  -- Opcode for R4 Instruction format
          Opcode_R3 : in std_logic_vector(3 downto 0);  -- Opcode for R3 instruction format
          Data_S1 : in std_logic_vector(63 downto 0);   -- RS1 data
          Data_S2 : in std_logic_vector(63 downto 0);   -- RS2 data
          Data_S3 : in std_logic_vector(63 downto 0);   -- R3 data
          --***** OUTPUTS *****--
          Result_Select_o : out std_logic_vector(1 downto 0);   
          Register_RD_o : out std_logic_vector(4 downto 0);
          Immediate_16_o : out std_logic_vector(15 downto 0);
          LI_Offset_o : out std_logic_vector(1 downto 0);
          Opcode_R4_o : out std_logic_vector(1 downto 0);
          Opcode_R3_o : out std_logic_vector(3 downto 0);
          Data_S1_o : out std_logic_vector(63 downto 0);
          Data_S2_o : out std_logic_vector(63 downto 0);
          Data_S3_o : out std_logic_vector(63 downto 0)
          );
end ID_EX_WB_REG;

architecture Behavioral of ID_EX_WB_REG is
begin
    --******************************** ID_EX_WB_REGISTER_PROCESS *******************************-- 
    ID_EX_WB_Reg_Proc : process(clk) is
    begin
        if(rising_edge(clk)) then   
            Data_S1_o <= Data_S1;   
            Data_S2_o <= Data_S2;    
            Data_S3_o <= Data_S3;   
            Opcode_R3_o <= Opcode_R3;   
            Opcode_R4_o <= Opcode_R4;   
            Register_RD_o <= Register_RD;   
            Immediate_16_o <= Immediate_16;
            LI_Offset_o <= LI_Offset;   
            Result_Select_o <= Result_Select;   
        end if;
    end process ID_EX_WB_Reg_Proc;
end Behavioral;