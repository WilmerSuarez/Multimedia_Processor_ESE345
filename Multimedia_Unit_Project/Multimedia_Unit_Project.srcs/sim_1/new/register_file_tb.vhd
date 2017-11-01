----------------------------------------------------------------------------------
-- Company: Stony Brook University
-- Engineer (s): Wilmer Suarez, Himanshu 
-- 
-- Create Date: 10/30/2017 11:31:38 PM
-- Design Name: 
-- Module Name: register_file_tb - Behavioral
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

entity register_file_tb is
end register_file_tb;

architecture Behavioral of register_file_tb is
--****************************** COMPONENT_DECLARATION ******************************--
    component register_file
        port(
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
    end component;
    
--****************************** INITIALIZE_INPUT_PORTS ******************************-- 
    -- INPUTS
    signal clk : std_logic := '0';
    signal write_enable : std_logic := '0';
    signal data_in : std_logic_vector(63 downto 0) := (others => '0');
    signal reg_A_select: std_logic_vector(4 downto 0) := (others => '0');
    signal reg_B_select : std_logic_vector(4 downto 0) := (others => '0');
    signal reg_C_select : std_logic_vector(4 downto 0) := (others => '0');
    signal write_reg_select : std_logic_vector(4 downto 0) := (others => '0');
 
    --OUTPUTS
    signal reg_A_out : std_logic_vector(63 downto 0);
    signal reg_B_out : std_logic_vector(63 downto 0);
    signal reg_C_out : std_logic_vector(63 downto 0);
 
    -- CLOCK_PERIOD 
    constant clk_period : time := 10 ns;
    
begin
    UUT: register_file 
        port map(write_enable => write_enable, write_reg_select => write_reg_select, data_in => data_in, 
        reg_A_select => reg_A_select, reg_B_select => reg_B_select, reg_C_select => reg_C_select,
        reg_A_out => reg_A_out, reg_B_out => reg_B_out, reg_C_out => reg_C_out, clk => clk);
   
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
             
           --
           reg_A_select <= "00000";
           reg_B_select <= "00000";
           reg_C_select <= "00000";
           write_reg_select <= "00100";
           data_in <= X"000000000000BEEF";
           write_enable <= '1';
           wait for clk_period;
           write_enable <= '0';
           
           reg_A_select <= "00100";
           reg_B_select <= "00000";
           reg_C_select <= "00000";
           write_reg_select <= "00100";
           data_in <= X"0000000000000000";
           wait for clk_period;
 
           reg_A_select <= "00100";
           reg_B_select <= "00000";
           reg_C_select <= "00000";
           write_reg_select <= "00100";
           data_in <= X"000000000000FADE";
           write_enable <= '1';
           wait for clk_period;
           write_enable <= '0';
           wait for clk_period;
     
           wait;
       end process stimulus;
        
end Behavioral;
