----------------------------------------------------------------------------------
-- Engineer(s): Wilmer Suarez, Himanshu Goel 
-- 
-- Create Date: 11/12/2017 11:22:18 AM
-- Design Name: Program Counter
-- Module Name: program_counter_reg - Behavioral
-- Project Name: Multimedia_Processor
-- Tool Versions: Vivado 2017.3
--
-- Description: Program counter used to generate address for instruction buffer. 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity program_counter_reg is
    Port(
         --***** INPUTS *****--
         CLK : in std_logic;    -- Clock
         PC_In : in std_logic_vector(4 downto 0);   -- Program counter value to be incremented 
         --***** OUTPUT *****--
         PC_Out : out std_logic_vector(4 downto 0)  -- Program counter value used as instruction buffer address
         );
end program_counter_reg;

architecture Behavioral of program_counter_reg is
begin
    PC : process(CLK) is
    begin
        if(rising_edge(CLK)) then   -- When rising edge of the clock 
            PC_Out <= std_logic_vector(unsigned(PC_In) + 1);    -- Increment Program Counter value 
        end if;
    end process PC;
end Behavioral;
