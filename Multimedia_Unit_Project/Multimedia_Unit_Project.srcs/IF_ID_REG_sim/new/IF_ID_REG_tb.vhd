----------------------------------------------------------------------------------
-- Engineer (s): Wilmer Suarez, Himanshu 
-- 
-- Create Date: 12/02/2017 12:31:38 AM
-- Design Name: R3 Instruction Format ALU Testbench
-- Module Name: ALU_1_tb - Behavioral
-- Project Name: Multimedia_Processor
-- Tool Versions: Vivado 2017.3
--
-- Description: Test Bench for the Multimedia_ALU
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.std_logic_textio.all; -- I/O Logic
use STD.TEXTIO.ALL; -- I/O functions and procedures

entity IF_ID_REG_tb is
end IF_ID_REG_tb;

architecture Behavioral of IF_ID_REG_tb is
--****************************** COMPONENT_DECLARATION ******************************--
    component IF_ID_REG
    Port (
          CLK : in std_logic;
          Instruction_In : in std_logic_vector(23 downto 0);
          Instruction_Out : out std_logic_vector(23 downto 0)
          );
    end component;
    
--****************************** PORT_INITIALIZATION ******************************-- 
    -- INPUTS
    signal CLK : std_logic := '0';
    signal Instruction_In : std_logic_vector(23 downto 0) := (others => '0');
    
    --OUTPUTS
    signal Instruction_Out : std_logic_vector(23 downto 0);
    --OPCODE_CONSTANTS
begin
    UUT: IF_ID_REG 
        port map(CLK => CLK, Instruction_In => Instruction_In, Instruction_Out => Instruction_Out);
 
       --***************************** STIMULUS_PROCESS_(INPUT DATA FROM FILE) ******************************-- 
       stimulus: process  
       begin
           wait for 100 ns; -- Hold reset state for 100 ns
           
           Instruction_In <= X"EDBEEF";
           CLK <= '1';
           wait for 100 ns;
           
           CLK <= '0';
           Instruction_In <= X"DEADBE";
           wait for 100 ns;
           
           CLK <= '1';
           wait for 100 ns;
           
           wait;
       end process stimulus;
         
              --************************ OUTPUT_TO_FILE_PROCESS *************************-- 
       output_to_file : process(CLK)
          variable LINE_0 : line; -- Composing a Line to be written to later 
          variable SPACE : character := ' '; -- Character vairiable used for a spce
          variable HEADER_DONE : bit := '1'; -- Variable used to determine when the header is finished being written
          file RESULT_0 : text is out "results.csv"; -- Location of file being written
       begin
          if HEADER_DONE = '1' then
            write(LINE_0, string'("CLK,Instruction_In,Instruction_Out")); -- Display the input data
            writeline(RESULT_0, LINE_0); -- Write to Line
            HEADER_DONE := '0'; -- Header end
          end if;
          write(LINE_0, CLK);
          write(LINE_0, string'(","));
          hwrite(LINE_0, Instruction_In);
          write(LINE_0, string'(","));
          hwrite(LINE_0, Instruction_Out);
          writeline(RESULT_0, LINE_0); -- Write to the line
          end process output_to_file;
end Behavioral;