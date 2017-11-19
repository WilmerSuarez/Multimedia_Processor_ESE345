----------------------------------------------------------------------------------
-- Engineer: 
-- 
-- Create Date: 11/13/2017 07:38:55 PM
-- Design Name: 
-- Module Name: li_shift - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity li_shift is
    Port (
          Immediate_16 : in std_logic_vector(15 downto 0);
          LI_Offset : in std_logic_vector(1 downto 0);
          Result : out std_logic_vector(63 downto 0)
          );
end li_shift;

architecture Behavioral of li_shift is
begin
    li_shift_proc : process(Immediate_16, LI_Offset) is
    begin
        Result <= (others => '0');
        case LI_Offset is
            when "00" =>
                Result(15 downto 0) <= Immediate_16;
            when "01" =>
                Result(31 downto 16) <= Immediate_16;
            when "10" =>
                Result(47 downto 32) <= Immediate_16;
            when "11" =>
                Result(63 downto 48) <= Immediate_16;
        end case; 
    end process li_shift_proc;
end Behavioral;