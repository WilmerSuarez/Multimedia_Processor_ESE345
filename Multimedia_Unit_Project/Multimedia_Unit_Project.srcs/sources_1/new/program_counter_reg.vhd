----------------------------------------------------------------------------------
-- Engineer(s): Wilmer Suarez, Himanshu Goel 
-- 
-- Create Date: 11/12/2017 11:22:18 AM
-- Design Name: 
-- Module Name: program_counter_reg - Behavioral
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

entity program_counter_reg is
    Port(
         clk : in std_logic;
         pc_in : in std_logic_vector(4 downto 0);
         pc_out : out std_logic_vector(4 downto 0)
         );
end program_counter_reg;

architecture Behavioral of program_counter_reg is
begin
    PC : process(clk) is
    begin
        if(rising_edge(clk)) then
            pc_out <= std_logic_vector(unsigned(pc_in) + 1);
        end if;
    end process PC;
end Behavioral;
