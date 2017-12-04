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
    signal opcode : std_logic_vector(1 downto 0);
    signal reg_S1 : std_logic_vector(63 downto 0) := (others => '0');
    signal reg_S2 : std_logic_vector(63 downto 0) := (others => '0');
    signal reg_S3 : std_logic_vector(63 downto 0) := (others => '0');
    
    --OUTPUTS
    signal result : std_logic_vector(63 downto 0) := (others => '0');
    
begin
    UUT: multimedia_ALU_2 
        port map(opcode => opcode, reg_S1 => reg_S1, reg_S2 => reg_S2,
        reg_S3 => reg_S3, result => result);
 
       --***************************** STIMULUS_PROCESS_(INPUT DATA FROM FILE) ******************************-- 
       stimulus: process  
       begin
--           wait for 100 ns; -- Hold reset state for 100 ns
--           -- Test for SIMALS Instruction
--           opcode <= "00";
--           reg_S1 <= X"DEADBEEFDEADBEEF";
--           reg_S2 <= X"DEADBEEFDEADBEEF";
--           reg_S3 <= X"71985CDF71985CDF";
           
--           wait for 100 ns;
--           -- Test for SIMAHS Instruction
--           opcode <= "01";
           
--           wait for 100 ns;
--           -- Test for SIMSLS Instruction
--           opcode <= "10";
--           reg_S1 <= X"BEEFDEADBEEFDEAD";
--           reg_S2 <= X"BEEFDEADBEEFDEAD";
--           reg_S3 <= X"71985CDF71985CDF";
           
--           wait for 100 ns;
--           -- Test for SIMSHS Instruction
--           opcode <= "11";
           
           --*************** SATURATION_TEST_MAX (2^31-1) ***************--
--           wait for 100 ns; 
--           -- Test for SIMALS Instruction
--           opcode <= "00";
--           reg_S1 <= X"7FFFFFFF7FFFFFFF";
--           reg_S2 <= X"0001000100010001";
--           reg_S3 <= X"0001000100010001";
          
--           wait for 100 ns;
--           -- Test for SIMAHS Instruction
--           opcode <= "01";
          
--           wait for 100 ns;
--           -- Test for SIMSLS Instruction
--           opcode <= "10";
--           reg_S1 <= X"7FFFFFFF7FFFFFFF";
--           reg_S2 <= X"0001000100010001";
--           reg_S3 <= X"FFFFFFFFFFFFFFFF";
          
--           wait for 100 ns;
--           -- Test for SIMSHS Instruction
--           opcode <= "11";
           
           --*************** SATURATION_TEST_MIN (-2^31) ***************--
           wait for 100 ns; 
           -- Test for SIMALS Instruction
           opcode <= "00";
           reg_S1 <= X"8000000080000000";
           reg_S2 <= X"0001000100010001";
           reg_S3 <= X"FFFFFFFFFFFFFFFF";
         
           wait for 100 ns;
           -- Test for SIMAHS Instruction
           opcode <= "01";
         
           wait for 100 ns;
           -- Test for SIMSLS Instruction
           opcode <= "10";
           reg_S1 <= X"8000000080000000";
           reg_S2 <= X"0001000100010001";
           reg_S3 <= X"0001000100010001";
         
           wait for 100 ns;
           -- Test for SIMSHS Instruction
           opcode <= "11";
           
           wait;
       end process stimulus;
        
       --************************ OUTPUT_TO_FILE_PROCESS *************************-- 
       output_to_file : process(result)
           variable LINE_0 : line; -- Composing a Line to be written to later 
           variable SPACE : character := ' '; -- Character vairiable used for a spce
           variable HEADER_DONE : bit := '1'; -- Variable used to determine when the header is finished being written
           file RESULT_0 : text is out "results.csv"; -- Location of file being written
       begin
           if HEADER_DONE = '1' then
               write(LINE_0, string'("S1,S2,S3,OpCode,Result")); -- Display the input data
               writeline(RESULT_0, LINE_0); -- Write to Line
               HEADER_DONE := '0'; -- Header end
           end if;
           hwrite(LINE_0, reg_S1);
           write(LINE_0, string'(","));
           hwrite(LINE_0, reg_S2);
           write(LINE_0, string'(","));
           hwrite(LINE_0, reg_S3);
           write(LINE_0, string'(","));
           hwrite(LINE_0, opcode);
           write(LINE_0, string'(","));
           hwrite(LINE_0, result);
           writeline(RESULT_0, LINE_0); -- Write to the line
       end process output_to_file;
    
end Behavioral;