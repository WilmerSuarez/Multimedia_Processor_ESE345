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
          Write_Enable : in STD_LOGIC;  -- Enabled only when filling buffer with Instructions
          PC_In : in STD_LOGIC_VECTOR (4 downto 0); -- Next Instruction Address
          Instruction_In : in STD_LOGIC_VECTOR(23 downto 0); -- Instruction input
          --***** OUTPUT *****--
          Instruction_Out : out STD_LOGIC_VECTOR (23 downto 0)  -- Instruction output
          );
end instruction_buffer;

architecture Behavioral of instruction_buffer is
type inst_buf_type is array(0 to 31) of std_logic_vector(23 downto 0);  -- Array of 32 instructions 
signal inst_buf : inst_buf_type;
begin
    fill_buffer_proc : process(Write_Enable, CLK) is 
    begin                                       
        if(Write_Enable = '1' and rising_edge(CLK)) then -- When Write Enable is set and at the rising edge of clock
            inst_buf(to_integer(unsigned(PC_In))) <= Instruction_In; -- Write Instruction_In into selected register
        end if;
    end process fill_buffer_proc;
    
    inst_buf_proc : process(CLK) is
    begin
        if (rising_edge(CLK) and Write_Enable = '0') then  -- At rising edge of clock output instruction 
            Instruction_Out <= inst_buf(to_integer(unsigned(PC_In)));
        end if;
    end process inst_buf_proc;
end Behavioral;
