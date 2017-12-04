----------------------------------------------------------------------------------
-- Engineer(s): Wilmer Suarez, Himanshu Goel 
-- 
-- Create Date: 11/13/2017 07:38:55 PM
-- Design Name: LI Shifter
-- Module Name: li_shift - Behavioral
-- Project Name: Multimedia_Processor
-- Tool Versions: Vivado 2017.3
--
-- Description: Used by load immedaite instruction to place 16 bit immediate into 
-- 16 bit filed of Register RD specified by the LI_Offset value.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity li_shift is
    Port (
          --***** INPUTS *****--
          Immediate_16 : in std_logic_vector(15 downto 0);  -- 16 bit immediate 
          LI_Offset : in std_logic_vector(1 downto 0);  -- Offset for 16 bit immediate
          RD_Data : in std_logic_vector(63 downto 0);
          --***** OUTPUT *****-
          Result : out std_logic_vector(63 downto 0)    -- Final result with 16 bit immediate in appropriate 16 bit field
          );
end li_shift;

architecture Behavioral of li_shift is
begin
    --******************************** LI_SHIFT_PROCESS *******************************--
    li_shift_proc : process(Immediate_16, LI_Offset, RD_Data) is
    begin
        Result <= RD_Data;
        case LI_Offset is
            when "00" =>    -- If offset is "00" 16 bit immediate goes in filed 15-0 of register RD
                Result(15 downto 0) <= Immediate_16;
            when "01" =>    -- If offset is "01" 16 bit immediate goes in filed 31-16 of register RD
                Result(31 downto 16) <= Immediate_16;
            when "10" =>    -- If offset is "10" 16 bit immediate goes in filed 47-32 of register RD
                Result(47 downto 32) <= Immediate_16;
            when "11" =>    -- If offset is "11" 16 bit immediate goes in filed 63-48 of register RD
                Result(63 downto 48) <= Immediate_16;
            when others =>
                Result <= (others => '0');
        end case; 
    end process li_shift_proc;
end Behavioral;