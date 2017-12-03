----------------------------------------------------------------------------------
-- Engineer(s): Wilmer Suarez, Himanshu Goel
-- 
-- Create Date: 10/22/2017 09:42:56 PM
-- Design Name: Register File
-- Module Name: register_file - Behavioral
-- Project Name: Multimedia_Processor
-- Tool Versions: Vivado 2017.3
--
-- Description: 32 Registers, 64-bits Wide
-- There can be 3 reads (2or3 64-bit registers can be read) and 1 write 
-- (1 64-bit value can be written when write enable is asserted) each cycle.
-- Data forwarding must be used so that a write and read to the same register 
-- returns the new value for the read.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity register_file is
    Port (
          --***** INPUTS *****--
          CLK : in STD_LOGIC; -- Clock
          Write_Register : in STD_LOGIC_VECTOR(4 downto 0); -- Selects the register to be written
          Data_In : in STD_LOGIC_VECTOR(63 downto 0); -- Data to be written when write_enable is asserted
          Read_Register_S1 : in STD_LOGIC_VECTOR(4 downto 0); -- Selects register S1 to be read
          Read_Register_S2 : in STD_LOGIC_VECTOR(4 downto 0); -- Selects register S2 to be read
          Read_Register_S3 : in STD_LOGIC_VECTOR(4 downto 0); -- Selects register S3 to be read
          Write_enable : in std_logic; -- Enable bit to allow a write to occur
          --***** OUTPUTS *****--
          Data_S1 : out STD_LOGIC_VECTOR(63 downto 0); -- Ouput of read register S1
          Data_S2 : out STD_LOGIC_VECTOR(63 downto 0); -- Output of read register S2
          Data_S3 : out STD_LOGIC_VECTOR(63 downto 0) -- Output of read register S3   
          );
end register_file;

architecture Behavioral of register_file is
type reg_file_type is array(0 to 31) of std_logic_vector(63 downto 0);  -- Array of 32 Registers
signal reg_file_array: reg_file_type;
begin
    --******************************** REG_FILE_PROCESS *******************************-- 
    Reg_File_Proc : process(CLK, Write_enable) is
    begin
    --********************************** WRITING_DATA *********************************-- 
        if(rising_edge(clk) and (Write_enable = '1')) then   -- When the clock is at a rising edge
            reg_file_array(to_integer(unsigned(Write_Register))) <= Data_In;    -- Write data to selected register 
        end if;      
    --******************************* READING_REGISTERS *******************************--
        if(falling_edge(clk)) then -- When the clock is at a falling edge
            Data_S1 <= reg_file_array(to_integer(unsigned(Read_Register_S1)));  -- Read register S1
            Data_S2 <= reg_file_array(to_integer(unsigned(Read_Register_S2)));  -- Read register S2
            Data_S3 <= reg_file_array(to_integer(unsigned(Read_Register_S3)));  -- Read register S3
        end if;
    end process Reg_File_Proc;
end Behavioral;