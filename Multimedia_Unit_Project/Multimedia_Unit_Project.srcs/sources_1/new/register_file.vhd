----------------------------------------------------------------------------------
-- Engineer(s): Wilmer Suarez, Himanshu Goel
-- 
-- Create Date: 10/22/2017 09:42:56 PM
-- Design Name: Register File
-- Module Name: register_file - Behavioral
-- Project Name: Multimedia_Unit
-- Target Devices: 
-- Tool Versions: 
-- Description: 32 Registers, 64-bits Wide
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

entity register_file is
    Port (
          write_enable : in std_logic; -- Asserted when a write 
          write_reg_select : in std_logic_vector(4 downto 0);
          read_A_select : in std_logic_vector(4 downto 0);
          read_B_select : in std_logic_vector(4 downto 0);
          read_C_select : in std_logic_vector(4 downto 0);
          reg_A_out : out std_logic_vector(63 downto 0); 
          reg_B_out : out std_logic_vector(63 downto 0);
          reg_C_out : out std_logic_vector(63 downto 0);
          data_in : in std_logic_vector(63 downto 0)
          );
end register_file;

architecture Behavioral of register_file is

begin
    
end Behavioral;
