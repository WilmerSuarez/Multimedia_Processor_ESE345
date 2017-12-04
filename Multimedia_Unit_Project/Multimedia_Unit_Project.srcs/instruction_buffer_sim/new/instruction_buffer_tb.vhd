----------------------------------------------------------------------------------
-- Engineer (s): Wilmer Suarez, Himanshu 
-- 
-- Create Date: 11/30/2017 11:31:38 PM
-- Design Name: Instruction Buffer Testbench
-- Module Name: instruction_buffer_tb - Behavioral
-- Project Name: Multimedia_Processor
-- Tool Versions: Vivado 2017.3
--
-- Description: Test Bench for the Instruction Buffer
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.std_logic_textio.all; -- I/O Logic
use STD.TEXTIO.ALL; -- I/O functions and procedures

entity instruction_buffer_tb is
end instruction_buffer_tb;

architecture Behavioral of instruction_buffer_tb is
--****************************** COMPONENT_DECLARATION ******************************--
    component instruction_buffer
        port(
              CLK : in STD_LOGIC; 
              Write_Enable : in STD_LOGIC;
              PC_In : in STD_LOGIC_VECTOR (4 downto 0);
              Instruction_In : in STD_LOGIC_VECTOR(23 downto 0);
              Instruction_Out : out STD_LOGIC_VECTOR (23 downto 0)
              );
    end component;
    
--****************************** PORT_INITIALIZATION ******************************-- 
    -- INPUTS
    signal CLK : std_logic;
    signal Write_Enable : std_logic  := '0';
    signal PC_In : std_logic_vector(4 downto 0) := (others => '0');
    signal Instruction_in : std_logic_vector(23 downto 0) := (others => '0');
    
    --OUTPUTS
    signal Instruction_Out : std_logic_vector(23 downto 0);
 
    -- CLOCK_PERIOD 
    constant clk_period : time := 10 ns;
    
begin
    UUT: instruction_buffer 
        port map(CLK => CLK, Write_Enable => Write_Enable, PC_In => PC_In, 
        Instruction_In => Instruction_In, Instruction_Out => Instruction_Out);
   
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
           file INSTRUCTION_I : text is in "instruction_buffer_data.txt";
       begin
           Write_Enable <= '1';
           while not endfile(INSTRUCTION_I) loop
               readline(INSTRUCTION_I, LINE_IN);
               read(LINE_IN, INSTRUCTION);
               Instruction_In <= INSTRUCTION;
               wait for clk_period;
               PC_In <= PC_In + 1;
           end loop;
           
           Write_Enable <= '0'; -- Clear Write_Enable
           wait for clk_period; -- Wait for 100ns after populating buffer with isntructions

           for i in 31 downto 0 loop
               wait for clk_period;
               PC_In <= PC_In + 1;
           end loop;
           wait for clk_period;
           
           wait;
       end process stimulus;
        
       --************************ OUTPUT_TO_FILE_PROCESS *************************-- 
       output_to_file : process(CLK)
           variable LINE_O : line; -- Composing a Line to be written to later 
           variable SPACE : character := ' '; -- Character vairiable used for a spce
           variable HEADER_DONE : bit := '1'; -- Variable used to determine when the header is finished being written
           file RESULT : text is out "instruction_buffer_result.txt"; -- Location of file being written
       begin
           if HEADER_DONE = '1' then
               write(LINE_O, string'("Instruction_Out")); -- Header to display the output register S1
               writeline(RESULT, LINE_O); -- Write to line
               HEADER_DONE := '0'; -- Header end
           end if;
           hwrite(LINE_O, Instruction_Out); -- Write the register to be written
           writeline(RESULT, LINE_O); -- Write to the line
       end process output_to_file;
    
end Behavioral;