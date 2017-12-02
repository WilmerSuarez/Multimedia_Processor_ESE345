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
         RESET : in std_logic := '0';  -- Reset signal to bring PC address back down to 0
         --***** OUTPUT *****--
         PC_Out : out std_logic_vector(4 downto 0)  -- Program counter value used as instruction buffer address
         );
end program_counter_reg;

architecture Behavioral of program_counter_reg is
signal PC_In : std_logic_vector(4 downto 0);
begin
    --******************************** Program_Counter_PROCESS *******************************-- 
    PC : process(CLK, RESET) is
    begin
        if RESET = '1' then -- When reset is set, reset PC back to 0
            PC_In <= "00000";
        elsif (rising_edge(CLK)) then   -- When rising edge of the clock 
            PC_In <= std_logic_vector(unsigned(PC_In) + 1);    -- Increment Program Counter value 
        end if;
    end process PC;
    PC_Out <= PC_In;    -- PC_out gets incremented value of previous value
end Behavioral;