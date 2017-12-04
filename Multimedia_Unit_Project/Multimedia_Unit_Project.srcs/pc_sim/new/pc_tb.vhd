----------------------------------------------------------------------------------
-- Engineer (s): Wilmer Suarez, Himanshu Goel
-- 
-- Create Date: 11/12/2017 12:11:38 PM
-- Design Name: Program Counter Testbench
-- Module Name: pc_tb - Behavioral
-- Project Name: Multimedia_Processor
-- Tool Versions: Vivado 2017.3
--
-- Description: Testbench for the Program Counter
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_textio.all; -- I/O Logic
use STD.TEXTIO.ALL; -- I/O functions and procedures

entity pc_tb is
end pc_tb;

architecture Behavioral of pc_tb is
    --************************* COMPONENT_DECLARATION *************************--
    component program_counter_reg
        port(
             CLK : in std_logic;
             reset : in std_logic;
             PC_Out : out std_logic_vector(4 downto 0)
             );
    end component program_counter_reg;
    
    --************************* PORT_INITIALIZATION *************************-- 
    -- INPUTS
    signal CLK : std_logic;
    signal reset : std_logic := '1';    -- enable reset signal
    
    --OUTPUTS
    signal PC_Out : std_logic_vector(4 downto 0);

    -- CLOCK_PERIOD 
    constant clk_period : time := 10 ns;
    
begin
    UUT: program_counter_reg 
        port map(CLK => CLK, reset => reset, PC_Out => PC_Out);
   
        --************************ CLOCK_GENERATION_PROCESSS *************************-- 
        clk_generation: process
        begin
            clk <= '0';
                wait for clk_period / 2;
            clk <= '1';
                wait for clk_period / 2;
        end process clk_generation;
       
       --************************ STIMULUS_PROCESS *************************-- 
       stimulus: process
       begin
           wait for clk_period;
           wait for clk_period;
           reset <= '0';    -- Clear reset signal
           wait for 30 * clk_period;
           reset <= '1';
           wait;
       end process stimulus;
       
       --************************ OUTPUT_TO_FILE_PROCESS *************************-- 
       output_to_file : process(PC_Out)
           variable LINE_O : line; -- Composing a Line to be written to later 
           variable SPACE : character := ' '; -- Character vairiable used for a spce
           variable HEADER_DONE : bit := '1'; -- Variable used to determine when the header is finished being written
           file RESULT : text is out "pc_result.txt"; -- Location of file being written
       begin
           if HEADER_DONE = '1' then
               write(LINE_O, string'("PC_out")); -- Header to display the output of the PC
               writeline(RESULT, LINE_O); -- Write to line
               HEADER_DONE := '0'; -- Header end
            end if;
              hwrite(LINE_O, PC_out); -- Write the value of the output of the PC
              writeline(RESULT, LINE_O); -- Write to line
          end process output_to_file;
end Behavioral;