----------------------------------------------------------------------------------
-- Engineer(s): Wilmer Suarez, Himanshu Goel
-- 
-- Create Date: 10/22/2017 09:42:56 PM
-- Design Name: Register File
-- Module Name: register_file - Behavioral
-- Project Name: Multimedia_Unit
-- Target Devices: 
-- Tool Versions: Vivado 2017.3
--
-- Description: 32 Registers, 64-bits Wide
-- There can be 3 reads (2or3 64-bit registers can be read) and 1 write 
-- (1 64-bit value can be written when write enable is asserted) each cycle.
-- Data forwarding must be used so that a write and read to the same register 
-- returns the new value for the read.

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

entity register_file is
    Port (
          write_enable : in std_logic; -- Asserted when data needs to be written
          write_reg_select : in std_logic_vector(4 downto 0); -- Selects the register to be written to
          data_in : in std_logic_vector(63 downto 0); -- Data to be written when write_enable is asserted
          reg_A_select : in std_logic_vector(4 downto 0); -- Selects register A to be read
          reg_B_select : in std_logic_vector(4 downto 0); -- Selects register B to be read
          reg_C_select : in std_logic_vector(4 downto 0); -- Selects register C to be read
          reg_A_out : out std_logic_vector(63 downto 0); -- Ouput of read register A
          reg_B_out : out std_logic_vector(63 downto 0); -- Output of read register B
          reg_C_out : out std_logic_vector(63 downto 0); -- Output of read register C
          clk : in std_logic -- clk
          );
end register_file;

architecture Behavioral of register_file is
type reg_file_type is array(0 to 31) of std_logic_vector(63 downto 0);
signal reg_file_array: reg_file_type;
begin
    reg_file_proc : process(clk) is
    begin
--************************************* WRITING_DATA ************************************-- 
        if(rising_edge(clk)) then
            if(write_enable = '1') then -- When write enable is asserted
                reg_file_array(to_integer(unsigned(write_reg_select))) <= data_in; -- write data to selected register 
            end if;
        end if;
        
--********************************** READING_REGISTERS **********************************--
        if(falling_edge(clk)) then -- When the clock is at a rising edge
            reg_A_out <= reg_file_array(to_integer(unsigned(reg_A_select))); -- Read register A
            reg_B_out <= reg_file_array(to_integer(unsigned(reg_B_select))); -- Read register B
            reg_C_out <= reg_file_array(to_integer(unsigned(reg_C_select))); -- Read register C
        end if;
    end process reg_file_proc;
end Behavioral;
