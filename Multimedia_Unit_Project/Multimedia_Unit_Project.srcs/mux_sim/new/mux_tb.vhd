----------------------------------------------------------------------------------
-- Engineer (s): Wilmer Suarez, Himanshu Goel
-- 
-- Create Date: 11/25/2017 11:27:38 PM
-- Design Name: Program Counter Testbench
-- Module Name: pc_tb - Behavioral
-- Project Name: Multimedia_Processor
-- Tool Versions: Vivado 2017.3
--
-- Description: Testbench for the Multiplexer
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_textio.all; -- I/O Logic
use STD.TEXTIO.ALL; -- I/O functions and procedures

entity mux_tb is
end mux_tb;

architecture Behavioral of mux_tb is
    --************************* COMPONENT_DECLARATION *************************--
    component mux_3
        port(
             Result_Select : in std_logic_vector(1 downto 0);
             R3_Result : in std_logic_vector(63 downto 0);
             R4_Result : in std_logic_vector(63 downto 0);    
             LI_Result : in std_logic_vector(63 downto 0);   
             Final_Result : out std_logic_vector(63 downto 0)   
             );
    end component mux_3;
    
    --************************* PORT_INITIALIZATION *************************-- 
    -- INPUTS
    signal Result_Select : std_logic_vector(1 downto 0);
    signal R3_Result : std_logic_vector(63 downto 0);
    signal R4_Result : std_logic_vector(63 downto 0);    
    signal LI_Result : std_logic_vector(63 downto 0);
    
    --OUTPUTS
    signal Final_Result : std_logic_vector(63 downto 0);
    
begin
    UUT: mux_3
        port map(Result_Select => Result_Select, R3_Result => R3_Result, R4_Result => R4_Result,
        LI_Result => LI_Result, Final_Result => Final_Result);
       
       --************************ STIMULUS_PROCESS *************************-- 
       stimulus: process
       begin
       wait for 100 ns; -- Hold reset state for 100 ns
       
       R3_Result <= X"000000000000BEEF";    -- Multiplexer inputs 
       R4_Result <= X"000000000000FADE";
       LI_Result <= X"0000BEEF00000000";
       
       Result_Select <= "10";   -- Select input 2 (LI_Result)
           
           wait for 100 ns;
           
       Result_Select <= "00";   -- Select input 0 (R3_Result)
       
           wait for 100 ns;
           
       Result_Select <= "01";   -- Select input 1 (R4_Result)
       
           wait for 100 ns;
       end process stimulus;
       
       --************************ OUTPUT_TO_FILE_PROCESS *************************-- 
       output_to_file : process(Final_Result)
           variable LINE_O : line; -- Composing a Line to be written to later 
           variable SPACE : character := ' '; -- Character variable used for a space
           variable HEADER_DONE : bit := '1'; -- Variable used to determine when the header is finished being written
           file RESULT : text is out "C:/Users/Wilmer Suarez/Desktop/ESE_345_PROJECT/Multimedia_Unit_Project/Multimedia_Unit_Project.srcs/mux_sim/new/mux_result.txt"; -- Location of file being written
       begin
           if HEADER_DONE = '1' then
               write(LINE_O, string'("0: R3_Result:")); -- Display multiplexer input option 1
               write(LINE_O, SPACE); -- Write a Space
               write(LINE_O, string'("000000000000BEEF"));
               writeline(RESULT, LINE_O); -- Write a Space
               write(LINE_O, string'("1: R4_Result:")); -- Display multiplexer input option 2
               write(LINE_O, SPACE); -- Write a Space
               write(LINE_O, string'("000000000000FADE"));
               writeline(RESULT, LINE_O); -- Write a Space
               write(LINE_O, string'("2: LI_Result:")); -- Display multiplexer input option 3
               write(LINE_O, SPACE); -- Write a Space
               write(LINE_O, string'("0000BEEF00000000"));
               writeline(RESULT, LINE_O); -- Write two lines
               writeline(RESULT, LINE_O); --
               write(LINE_O, string'("Result_Select")); -- Header for displaying the Selected Result of the Multiplexer
               write(LINE_O, SPACE); -- Write a Space
               write(LINE_O, string'("Final_Result")); -- Header for displaying the output of the Multiplexer
               writeline(RESULT, LINE_O); -- Write to the line
               HEADER_DONE := '0'; -- Header end
           end if;
           hwrite(LINE_O, Result_Select); -- Write the selected input index
           write(LINE_O, string'("             ")); -- Added space for formatting
           hwrite(LINE_O, Final_Result); -- Write the Final Result selected by the Mux
           writeline(RESULT, LINE_O); -- Write to the line
       end process output_to_file;
end Behavioral;