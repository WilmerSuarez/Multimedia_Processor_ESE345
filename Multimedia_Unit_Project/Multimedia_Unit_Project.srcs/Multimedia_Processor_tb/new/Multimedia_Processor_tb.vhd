----------------------------------------------------------------------------------
-- Engineer (s): Wilmer Suarez, Himanshu 
-- 
-- Create Date: 12/02/2017 12:31:38 AM
-- Design Name: Multimedia Processor
-- Module Name: Multimedia_Processor_tb - Behavioral
-- Project Name: Multimedia_Processor
-- Tool Versions: Vivado 2017.3
--
-- Description: Test Bench for the Multimedia Processor
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.std_logic_textio.all; -- I/O Logic
use STD.TEXTIO.ALL; -- I/O functions and procedures

entity Multimedia_Processor_tb is
end Multimedia_Processor_tb;

architecture Behavioral of Multimedia_Processor_tb is
--****************************** COMPONENT_DECLARATION ******************************--
    component Multimedia_Processor
    Port (
          --***** INPUT *****--
          CLK : in std_logic;
          RESET : in std_logic;
          Write_Enable_buff : in std_logic;
          Instruction_In : in std_logic_vector(23 downto 0)
          --***** OUTPUTS *****--
          
          );
    end component;
    
--****************************** PORT_INITIALIZATION ******************************-- 
    -- INPUTS
    signal CLK : std_logic;
    signal RESET : std_logic := '1';
    signal Write_Enable_buff : std_logic;
    signal Instruction_In : std_logic_vector(23 downto 0);
 
    --OUTPUTS
    
 
    -- CLOCK_PERIOD 
    constant clk_period : time := 10 ns;
begin
    UUT: Multimedia_Processor
        port map(CLK => CLK, RESET => RESET, Write_Enable_buff => Write_Enable_buff, Instruction_In => Instruction_In);
 
    --***************************** CLOCK_GENERATION_PROCESSS ******************************-- 
    clk_generation: process
    begin
        clk <= '0';
            wait for clk_period / 2;
        clk <= '1';
            wait for clk_period / 2;
    end process clk_generation;
    
    --***************************** STIMULUS_PROCESS_(INPUT DATA FROM FILE) ******************************-- 
    stimulus: process
       variable LINE_IN : line;
       variable INSTRUCTION : std_logic_vector(23 downto 0);
       variable count : integer := 0;
       file INSTRUCTION_I : text is in "instructions.txt";
    begin
       Write_Enable_buff <= '1';
       RESET <= '0';
       while not endfile(INSTRUCTION_I) loop
           readline(INSTRUCTION_I, LINE_IN);
           hread(LINE_IN, INSTRUCTION);
           Instruction_In <= INSTRUCTION;
           wait for 100 ns;
       end loop;
       
       Write_Enable_buff <= '0'; -- Clear Write_Enable for intruction buffer
       RESET <= '1';
       wait for clk_period;
       RESET <= '0';
       wait for 100 ns; -- Wait for 100ns after populating buffer with isntructions
       
       
       wait;
    end process stimulus;
end Behavioral;