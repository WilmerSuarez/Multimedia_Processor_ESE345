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
          Result_Select : in std_logic_vector(2 downto 0);   -- Data selection
          R3_Result : in std_logic_vector((data_width-1) downto 0);    -- Result from R3 instruction format ALU
          R4_Result : in std_logic_vector((data_width-1) downto 0);    -- Result from R4 instruction format ALU
          LI_Result : in std_logic_vector((data_width-1) downto 0);    -- Result from LI Shifter
          Final_Result : out std_logic_vector((data_width-1) downto 0)    -- Final Result to be written back to Register File
          );
end mux_3;

architecture Behavioral of mux_3 is
begin
    with Result_Select select Final_Result <=
        R3_Result when "00",    
        R4_Result when "01",
        LI_Result when "10";    
end Behavioral;
