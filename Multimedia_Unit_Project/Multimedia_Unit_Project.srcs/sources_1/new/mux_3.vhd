----------------------------------------------------------------------------------
-- Engineer(s): Wilmer Suarez, Himanshu Goel 
-- 
-- Create Date: 11/12/2017 10:58:11 AM
-- Design Name: Multiplexor 
-- Module Name: mux_3 - Behavioral
-- Project Name: Multimedia_Processor
-- Tool Versions: Vivado 2017.3
-- Description: Multiplexor used to select witch ALU result gets written back to the
-- Register File. 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_3 is
     Port(
          Result_Select : in std_logic_vector(1 downto 0); -- Data selection
          R3_Result : in std_logic_vector(63 downto 0);    -- Result from R3 instruction format ALU
          R4_Result : in std_logic_vector(63 downto 0);    -- Result from R4 instruction format ALU
          LI_Result : in std_logic_vector(63 downto 0);    -- Result from LI Shifter
          Final_Result : out std_logic_vector(63 downto 0) -- Final Result to be written back to Register File
          );
end mux_3;

architecture Behavioral of mux_3 is
begin
    with Result_Select select Final_Result <=
        R3_Result when "00",    
        R4_Result when "01",
        LI_Result when "10",
        X"0000000000000000" when others;   
end Behavioral;