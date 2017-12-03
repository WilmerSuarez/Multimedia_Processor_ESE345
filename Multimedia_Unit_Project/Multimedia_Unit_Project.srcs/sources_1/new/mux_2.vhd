----------------------------------------------------------------------------------
-- Engineer(s): Wilmer Suarez, Himanshu Goel 
-- 
-- Create Date: 12/02/2017 10:58:11 PM
-- Design Name: Multiplexor 
-- Module Name: mux_2 - Behavioral
-- Project Name: Multimedia_Processor
-- Tool Versions: Vivado 2017.3
-- Description: Multiplexor used to select witch Register Address the RS3 input
-- of the register file will receive (RS3 Or RD).
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_2 is
     Port(
          Adress_Select : in std_logic;   -- Data selection
          RS3_Address : in std_logic_vector(4 downto 0);    -- Result from RS3 
          RD_Address : in std_logic_vector(4 downto 0);    -- Result from RD
          Address : out std_logic_vector(4 downto 0)    -- Address for Reigster file input, RS3
          );
end mux_2;

architecture Behavioral of mux_2 is
begin
    with Adress_Select select Address <=
        RS3_Address when '0',    
        RD_Address when '1',
        "00000" when others;   
end Behavioral;
