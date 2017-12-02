----------------------------------------------------------------------------------
-- Engineer(s): Wilmer Suarez, Himanshu Goel 
-- 
-- Create Date: 11/20/2017 09:00:15 PM
-- Design Name: Multimedia Processor
-- Module Name: Multimedia_Processor - Behavioral
-- Project Name: Multimedia_Processor
-- Tool Versions: Vivado 2017.3
--
-- Description: Multimedia Processor
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Multimedia_Processor is
    Port (
          CLK : in std_logic;
          RESET : in std_logic
          );
end Multimedia_Processor;

architecture Behavioral of Multimedia_Processor is
--************* Connection Signals *************--
signal PC_Out_sig : std_logic_vector(4 downto 0);
begin
--********** Program_Counter **********--
program_counter : entity work.program_counter_reg
    port map(
             CLK => CLK, 
             reset => RESET,
             PC_Out => PC_Out_sig 
             );
    
end Behavioral;
