----------------------------------------------------------------------------------
-- Engineer(s): Wilmer Suarez, Himanshu Goel
-- 
-- Create Date: 11/03/2017 11:28:01 AM
-- Design Name: Instruction Buffer
-- Module Name: instruction_buffer - Behavioral
-- Project Name: Multimedia Processor
-- Target Devices: 
-- Tool Versions: Vivado 2017.3
-- Description: 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity instruction_buffer is
    Port ( 
          PC_in : in STD_LOGIC_VECTOR (4 downto 0);
          instr : out STD_LOGIC_VECTOR (23 downto 0);
          clk : in STD_LOGIC
          );
end instruction_buffer;

architecture Behavioral of instruction_buffer is
type inst_buf_type is array(0 to 31) of std_logic_vector(23 downto 0);
signal inst_buf : inst_buf_type;
begin
    inst_buf_proc : process(clk) is
    begin
        if (rising_edge(clk)) then
            instr <= inst_buf(to_integer(unsigned(PC_in)));
        end if;
    end process inst_buf_proc;
end Behavioral;
