----------------------------------------------------------------------------------
-- Engineer(s): Wilmer Suarez, Himanshu Goel 
-- 
-- Create Date: 11/13/2017 06:48:01 PM
-- Design Name: 
-- Module Name: ID_EX_WB_REG - Behavioral
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

entity ID_EX_WB_REG is
    Port (
          CLK : in std_logic;
          ALU_Select : in std_logic_vector(1 downto 0);
          Register_RD : in std_logic_vector(4 downto 0);
          Immediate_16 : in std_logic_vector(15 downto 0);
          LI_Offset : in std_logic_vector(1 downto 0);
          R3_R4_Type : in std_logic;
          Opcode_R4 : in std_logic_vector(1 downto 0);
          Opcode_R3 : in std_logic_vector(3 downto 0);
          Data_S1 : in std_logic_vector(63 downto 0);
          Data_S2 : in std_logic_vector(63 downto 0);
          Data_S3 : in std_logic_vector(63 downto 0);
          ALU_Select_o : out std_logic_vector(1 downto 0);
          Register_RD_o : out std_logic_vector(4 downto 0);
          Immediate_16_o : out std_logic_vector(15 downto 0);
          LI_Offset_o : out std_logic_vector(1 downto 0);
          R3_R4_Type_o : out std_logic;
          Opcode_R4_o : out std_logic_vector(1 downto 0);
          Opcode_R3_o : out std_logic_vector(3 downto 0);
          Data_S1_o : out std_logic_vector(63 downto 0);
          Data_S2_o : out std_logic_vector(63 downto 0);
          Data_S3_o : out std_logic_vector(63 downto 0)
          );
end ID_EX_WB_REG;

architecture Behavioral of ID_EX_WB_REG is

begin
    ID_EX_WB_Reg_Proc : process(clk) is
    begin
        if(rising_edge(clk)) then 
            Data_S1_o <= Data_S1;
            Data_S2_o <= Data_S2;
            Data_S3_o <= Data_S3;
            Opcode_R3_o <= Opcode_R3;
            Opcode_R4_o <= Opcode_R4;
            R3_R4_Type_o <= R3_R4_Type;
            Register_RD_o <= Register_RD;
            Immediate_16_o <= Immediate_16;
            LI_Offset_o <= LI_Offset;
            ALU_Select_o <= ALU_Select;
        end if;
    end process ID_EX_WB_Reg_Proc;
end Behavioral;
