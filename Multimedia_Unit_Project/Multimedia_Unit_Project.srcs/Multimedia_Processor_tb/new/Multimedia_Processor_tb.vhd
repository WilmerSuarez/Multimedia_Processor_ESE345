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
          Write_Enable : in std_logic;
          Instruction_In : in std_logic_vector(23 downto 0)
          --***** OUTPUTS *****--
          );
    end component;
    
--****************************** PORT_INITIALIZATION ******************************-- 
    -- INPUTS
    signal CLK : std_logic;
 
    --OUTPUTS
 
    -- CLOCK_PERIOD 
    constant clk_period : time := 10 ns;
begin
    UUT: Multimedia_Processor
        port map(CLK => CLK, );
 
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
           wait for 100 ns;
           PC_In <= PC_In + 1;
       end loop;
       
       Write_Enable <= '0'; -- Clear Write_Enable
       wait for 100 ns; -- Wait for 100ns after populating buffer with isntructions
    
       wait;
    end process stimulus;
         
    --************************ OUTPUT_TO_FILE_PROCESS *************************-- 
    output_to_file : process()
    variable LINE_0 : line; -- Composing a Line to be written to later 
    variable SPACE : character := ' '; -- Character vairiable used for a spce
    variable HEADER_DONE : bit := '1'; -- Variable used to determine when the header is finished being written
    file RESULT_0 : text is out "results.csv"; -- Location of file being written
    begin
    if HEADER_DONE = '1' then
    write(LINE_0, string'("instruction,Register_rd_o,Immediate_16_o,LI_Offset_o,Opcode_R4_o,Opcode_R3_o,Reg_RS1_o,Reg_RS2_o,Reg_RS3_o")); -- Display the input data
    writeline(RESULT_0, LINE_0); -- Write to Line
    HEADER_DONE := '0'; -- Header end
    end if;
    hwrite(LINE_0, instruction);
    write(LINE_0, string'(","));
    
    hwrite(LINE_0, Register_rd_o);
    write(LINE_0, string'(","));
    
    hwrite(LINE_0, Immediate_16_o);
    write(LINE_0, string'(","));
    
    hwrite(LINE_0, LI_Offset_o);
    write(LINE_0, string'(","));
    
    hwrite(LINE_0, Opcode_R4_o);
    write(LINE_0, string'(","));
            
    hwrite(LINE_0, Opcode_R3_o);
    write(LINE_0, string'(","));
            
    hwrite(LINE_0, Reg_RS1_o);
    write(LINE_0, string'(","));
                      
    hwrite(LINE_0, Reg_RS2_o);
    write(LINE_0, string'(","));
                                
    hwrite(LINE_0, Reg_RS3_o);
    
    writeline(RESULT_0, LINE_0); -- Write to the line
    end process output_to_file;
end Behavioral;