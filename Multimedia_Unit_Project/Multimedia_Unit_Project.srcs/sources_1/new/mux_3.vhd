----------------------------------------------------------------------------------
-- Engineer(s): Wilmer Suarez, Himanshu Goel 
-- 
-- Create Date: 11/12/2017 10:58:11 AM
-- Design Name: 
-- Module Name: mux_2 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
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

entity mux_3 is
    Generic( 
            data_width : integer := 64  -- Width of data in
            );
    Port (
          sel : in std_logic_vector(2 downto 0);   -- Data selection
          data_0 : in std_logic_vector((data_width-1) downto 0);    -- Data in 0
          data_1 : in std_logic_vector((data_width-1) downto 0);    -- Data in 1
          data_2 : in std_logic_vector((data_width-1) downto 0);    -- Data in 2
          output : out std_logic_vector((data_width-1) downto 0)    -- Data output
          );
end mux_3;

architecture Behavioral of mux_3 is
begin
    with sel select output <=
        data_0 when "00",    
        data_1 when "01",
        data_2 when "10";    
end Behavioral;
