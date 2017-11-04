----------------------------------------------------------------------------------
-- Engineer(s): Wilmer Suarez, Himanshu Goel
-- 
-- Create Date: 10/22/2017 09:42:56 PM
-- Design Name: Register File
-- Module Name: register_file - Behavioral
-- Project Name: Multimedia_Processor
-- Target Devices: 
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
          write_enable : in STD_LOGIC; -- Asserted when data needs to be written
          write_reg_select : in STD_LOGIC_VECTOR(4 downto 0); -- Selects the register to be written
          data_in : in STD_LOGIC_VECTOR(63 downto 0); -- Data to be written when write_enable is asserted
          reg_S1_select : in STD_LOGIC_VECTOR(4 downto 0); -- Selects register S1 to be read
          reg_S2_select : in STD_LOGIC_VECTOR(4 downto 0); -- Selects register S2 to be read
          reg_S3_select : in STD_LOGIC_VECTOR(4 downto 0); -- Selects register S3 to be read
          reg_S1_out : out STD_LOGIC_VECTOR(63 downto 0); -- Ouput of read register S1
          reg_S2_out : out STD_LOGIC_VECTOR(63 downto 0); -- Output of read register S2
          reg_S3_out : out STD_LOGIC_VECTOR(63 downto 0); -- Output of read register S3
          clk : in STD_LOGIC -- Clock
          );
end register_file;

architecture Behavioral of register_file is
type reg_file_type is array(0 to 31) of std_logic_vector(63 downto 0);
signal reg_file_array: reg_file_type;
begin
    --******************************** REG_FILE_PROCESS *******************************-- 
    reg_file_proc : process(clk) is
    begin
    --********************************** WRITING_DATA *********************************-- 
        if(rising_edge(clk)) then -- When the clock is at a rising edge
            if(write_enable = '1') then -- When write enable is asserted
                reg_file_array(to_integer(unsigned(write_reg_select))) <= data_in; -- Write data to selected register 
            end if;
        end if;      
    --******************************* READING_REGISTERS *******************************--
        if(falling_edge(clk)) then -- When the clock is at a falling edge
            reg_S1_out <= reg_file_array(to_integer(unsigned(reg_S1_select))); -- Read register S1
            reg_S2_out <= reg_file_array(to_integer(unsigned(reg_S2_select))); -- Read register S2
            reg_S3_out <= reg_file_array(to_integer(unsigned(reg_S3_select))); -- Read register S3
        end if;
    end process reg_file_proc;
end Behavioral;
