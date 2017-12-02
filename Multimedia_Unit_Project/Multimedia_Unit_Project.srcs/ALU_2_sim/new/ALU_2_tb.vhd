----------------------------------------------------------------------------------
-- Engineer (s): Wilmer Suarez, Himanshu 
-- 
-- Create Date: 12/01/2017 8:31:38 PM
-- Design Name: R4 Instruction Format ALU Testbench
-- Module Name: ALU_2_tb - Behavioral
-- Project Name: Multimedia_Processor
-- Tool Versions: Vivado 2017.3
--
-- Description: Test Bench for the Multimedia_ALU_2
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.std_logic_textio.all; -- I/O Logic
use STD.TEXTIO.ALL; -- I/O functions and procedures

entity ALU_2_tb is
end ALU_2_tb;

architecture Behavioral of ALU_2_tb is
--****************************** COMPONENT_DECLARATION ******************************--
    component multimedia_ALU_2
        port(
             opcode : in std_logic_vector(1 downto 0); 
             reg_S1 : in std_logic_vector(63 downto 0);
             reg_S2 : in std_logic_vector(63 downto 0);
             reg_S3 : in std_logic_vector(63 downto 0);
             result : out std_logic_vector(63 downto 0)
             );
    end component;
    
--****************************** PORT_INITIALIZATION ******************************-- 
    -- INPUTS
    signal opcode : std_logic_vector(1 downto 0) := (others => '0');
    signal reg_S1 : std_logic_vector(63 downto 0) := (others => '0');
    signal reg_S2 : std_logic_vector(63 downto 0) := (others => '0');
    signal reg_S3 : std_logic_vector(63 downto 0) := (others => '0');
    
    --OUTPUTS
    signal result : std_logic_vector(63 downto 0);
    
begin
    UUT: multimedia_ALU_2 
        port map(opcode => opcode, reg_S1 => reg_S1, reg_S2 => reg_S2,
        reg_S3 => reg_S3, result => result);
 
       --***************************** STIMULUS_PROCESS_(INPUT DATA FROM FILE) ******************************-- 
       stimulus: process  
       begin
           wait for 100 ns; -- Hold reset state for 100 ns
           reg_S1 <= X"0000BEEF0000BEEF";
           reg_S2 <= X"0000BEEF0000BEEF";
           reg_S3 <= X"71985CDF71985CDF";
           opcode <= "00";
           wait;
       end process stimulus;
        
       --************************ OUTPUT_TO_FILE_PROCESS *************************-- 
       output_to_file : process(result)
           variable LINE_O : line; -- Composing a Line to be written to later 
           variable SPACE : character := ' '; -- Character vairiable used for a spce
           variable HEADER_DONE : bit := '1'; -- Variable used to determine when the header is finished being written
           file RESULT : text is out "C:/Users/Wilmer Suarez/Desktop/ESE_345_PROJECT/Multimedia_Unit_Project/Multimedia_Unit_Project.srcs/instruction_buffer_sim/new/instruction_buffer_result.txt"; -- Location of file being written
       begin
           if HEADER_DONE = '1' then
               write(LINE_O, string'("Register S1: ")); -- Display the input data 
               write(LINE_O, SPACE); -- Write a Space
               write(LINE_O, string'("0x0000BEEF0000BEEF"));
               writeline(RESULT, LINE_O); -- Write to Line
               write(LINE_O, string'("Register S2: "));
               write(LINE_O, SPACE); -- Write a Space
               write(LINE_O, string'("0x0000BEEF0000BEEF"));
               write(LINE_O, string'("Register S3: "));
               write(LINE_O, SPACE); -- Write a Space
               write(LINE_O, string'("0x71985CDF71985CDF"));
               write(LINE_O, string'("Opcode: "));
               write(LINE_O, SPACE); -- Write a Space
               write(LINE_O, string'("00"));
               writeline(RESULT, LINE_O); -- Write two lines
               writeline(RESULT, LINE_O);
               write(LINE_O, string'("Write_Register")); -- Header for displaying the register to be written
               write(LINE_O, SPACE); -- Write a Space
               write(LINE_O, string'("Data_S1")); -- Header to display the output register S1
               writeline(RESULT, LINE_O); -- Write to line
               HEADER_DONE := '0'; -- Header end
           end if;
          -- hwrite(LINE_O, Instruction_Out); -- Write the register to be written
           write(LINE_O, string'("             ")); -- Added space for formatting
         --  hwrite(LINE_O, ); -- Write the output data of register S1
           writeline(RESULT, LINE_O); -- Write to the line
       end process output_to_file;
    
end Behavioral;