----------------------------------------------------------------------------------
-- Engineer(s): Wilmer Suarez, Himanshu Goel
-- 
-- Create Date: 11/03/2017 10:02:18 PM
-- Design Name: Multimedia_ALU_2
-- Module Name: multimedia_ALU_2 - Behavioral
-- Project Name: Multimedia Processor
-- Target Devices: 
-- Tool Versions: Vivado 2017.3
-- Description: 
-- 
-- Dependencies: 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity multimedia_ALU_2 is
    Port (
          opcode : in std_logic_vector(1 downto 0);      
          reg_S1 : in std_logic_vector(63 downto 0);
          reg_S2 : in std_logic_vector(63 downto 0);
          reg_S3 : in std_logic_vector(63 downto 0);
          result : out std_logic_vector(63 downto 0)
          );
end multimedia_ALU_2;

architecture Behavioral of multimedia_ALU_2 is
--******************** OP_CODE_VALUES ********************--
constant SIMALS_OP : STD_LOGIC_VECTOR(1 downto 0) := "00"; -- Signed integer multiple-add low with saturation
constant SIMAHS_OP : STD_LOGIC_VECTOR(1 downto 0) := "01"; -- Signed integer multiple-add high with saturation
constant SIMSLS_OP : STD_LOGIC_VECTOR(1 downto 0) := "10"; -- Signed integer multiple-subtract low with saturation
constant SIMSHS_OP : STD_LOGIC_VECTOR(1 downto 0) := "11"; -- Signed integer multiple-subtract high with saturation
begin
    --********************************** ALU_PROCESS *********************************--
    ALU_proc: process(opcode) is
    begin
        case(opcode) is 
            --********************************** SIMALS_OP *********************************--
            when SIMALS_OP =>
            
            --********************************** SIMAHS_OP *********************************--
            when SIMAHS_OP =>
            
            --********************************** SIMSLS_OP *********************************--
            when SIMSLS_OP =>
            
            --********************************** SIMSHS_OP *********************************--
            when SIMSHS_OP =>
            
        end case;
    end process ALU_proc;
end Behavioral;
