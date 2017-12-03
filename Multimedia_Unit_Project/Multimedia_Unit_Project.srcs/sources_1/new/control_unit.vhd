----------------------------------------------------------------------------------
-- Engineer(s): Wilmer Suarez, Himanshu Goel 
-- 
-- Create Date: 11/13/2017 06:42:53 PM
-- Design Name: Control Unit
-- Module Name: control_unit - Behavioral
-- Project Name: Multimedia_Processor
-- Tool Versions: Vivado 2017.3
--
-- Description: Control unit determines what module output is taken to write back
-- to the register file and prevents write back for NOP instruction. 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_unit is
    Port (
          --***** INPUT *****--
          Instruction : in std_logic_vector(23 downto 0);   -- Instruction
          --***** OUTPUT *****--
          Result_Select : out std_logic_vector(1 downto 0);  -- Final Result selection signal
          S3_Select : out std_logic;    -- Register file S3 input Adress Select
          Reg_write_enable : out std_logic  -- Enable bit for write enable
          );
end control_unit;

architecture Behavioral of control_unit is
begin
    --******************************** CONTROL_UNIT_PROCESS *******************************-- 
    Control_Unit_Proc : process(Instruction) is
    begin
        Reg_write_enable <= '1';    -- Initialize write enable signal to 1
        S3_Select <= '0';
        if(Instruction(23) = '1') then  -- If MSB of instruction is set, Final Result is of instruction format R-1 (Load Immediate)
            Result_Select <= "10";
            S3_Select <= '1';
        else
           case Instruction(23 downto 22) is
               when "00" => -- If two MSBs are "00" then Final Result is of instruction format R3 
                   Result_Select <= "00";
                   if Instruction(21 downto 15) = "0000000" then
                       Reg_write_enable <= '0'; -- If NOP then write enable is disbled
                   end if;
               when "01" => -- If two MSBs are "01" then Final Result is of instruction format R4
                   Result_Select <= "01";
               when others =>
                   Result_Select <= "XX";
           end case;
        end if;
    end process Control_Unit_Proc;
end Behavioral;