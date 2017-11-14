----------------------------------------------------------------------------------
-- Engineer (s): Wilmer Suarez, Himanshu 
-- 
-- Create Date: 11/12/2017 12:11:38 PM
-- Design Name: 
-- Module Name: pc_tb - Behavioral
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

entity pc_tb is
end pc_tb;

architecture Behavioral of pc_tb is
--****************************** COMPONENT_DECLARATION ******************************--
    component program_counter_reg
        port(
             clk : in std_logic;
             inst_select : out std_logic_vector(4 downto 0)
             );
    end component;
    
--****************************** INITIALIZE_INPUT_PORTS ******************************-- 
    -- INPUTS
    signal clk : std_logic := '0';
 
    --OUTPUTS
    signal inst_select : std_logic_vector(4 downto 0);

    -- CLOCK_PERIOD 
    constant clk_period : time := 10 ns;
    
begin
    UUT: program_counter_reg 
        port map(clk => clk, inst_select => inst_select);
   
--***************************** CLOCK_GENERATION_PROCESSS ******************************-- 
        clk_generation: process
        begin
            clk <= '0';
                wait for clk_period / 2;
            clk <= '1';
                wait for clk_period / 2;
        end process clk_generation;
       
--***************************** STIMULUS_PROCESS ******************************-- 
       stimulus: process
       begin
           wait for 100 ns;

           wait for clk_period;
           
           wait for clk_period;
           
           wait for clk_period;
           
           wait for clk_period;
              
           wait;
       end process stimulus;
        
end Behavioral;