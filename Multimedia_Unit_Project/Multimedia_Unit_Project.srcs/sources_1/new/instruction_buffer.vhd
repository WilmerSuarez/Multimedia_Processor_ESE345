----------------------------------------------------------------------------------
-- Engineer(s): Wilmer Suarez, Himanshu Goel
-- 
-- Create Date: 11/03/2017 11:28:01 AM
-- Design Name: Instruction Buffer
-- Module Name: instruction_buffer - Behavioral
-- Project Name: Multimedia_Processor
-- Tool Versions: Vivado 2017.3
--
-- Description: Holds instructions to be fetched and executed. 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity instruction_buffer is
    Port ( 
          --***** INPUTS *****--
          CLK : in STD_LOGIC;   -- Clock
          PC_In : in STD_LOGIC_VECTOR (4 downto 0); -- Next Instruction Address
          --***** OUTPUT *****--
          Instruction : out STD_LOGIC_VECTOR (23 downto 0)  -- Instruction
          );
end instruction_buffer;

architecture Behavioral of instruction_buffer is
type inst_buf_type is array(0 to 31) of std_logic_vector(23 downto 0);  -- Array of 32 instructions 
signal inst_buf : inst_buf_type;
begin
    inst_buf_proc : process(CLK) is
    begin
        if (rising_edge(CLK)) then  -- At rising edge of clock output instruction 
            Instruction <= inst_buf(to_integer(unsigned(PC_In)));
        end if;
    end process inst_buf_proc;
end Behavioral;
