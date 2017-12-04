----------------------------------------------------------------------------------
-- Engineer (s): Wilmer Suarez, Himanshu 
-- 
-- Create Date: 12/02/2017 12:31:38 AM
-- Design Name: Control Unit Testbench
-- Module Name: control_tb - Behavioral
-- Project Name: Multimedia_Processor
-- Tool Versions: Vivado 2017.3
--
-- Description: Test Bench for the Control Unit
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.std_logic_textio.all; -- I/O Logic
use STD.TEXTIO.ALL; -- I/O functions and procedures

entity control_tb is
end control_tb;

architecture Behavioral of control_tb is
--****************************** COMPONENT_DECLARATION ******************************--
    component control_unit
    Port (
          --***** INPUT *****--
          Instruction : in std_logic_vector(23 downto 0);
          --***** OUTPUT *****--
          Result_Select : out std_logic_vector(1 downto 0); 
          S3_Select : out std_logic;
          Reg_write_enable : out std_logic
          );
    end component;
    
--****************************** PORT_INITIALIZATION ******************************-- 
    -- INPUTS
    signal Instruction : std_logic_vector(23 downto 0) := (others => '0');
    
    --OUTPUTS
    signal Result_Select : std_logic_vector(1 downto 0);
    signal S3_Select : std_logic;
    signal Reg_write_enable : std_logic;
begin
    UUT: control_unit 
        port map(Instruction => Instruction, Result_Select => Result_Select, S3_Select => S3_Select,
         Reg_write_enable => Reg_write_enable);
 
       --***************************** STIMULUS_PROCESS_(INPUT DATA FROM FILE) ******************************-- 
       stimulus: process  
       begin       
           wait for 100 ns; -- Hold reset state for 100 ns
           
           -- R1 Format Instruciont: Load Immediate Test
           Instruction <= X"800000";
           wait for 100 ns;
           
           -- R3 Format Instruction Test
           Instruction <= X"010000";
           wait for 100 ns;
           
           -- R3 Format Instruction Test (NOP)
           Instruction <= X"000000";
           wait for 100 ns;
           
           -- R4 Format Instruction Test
           Instruction <= X"400000";

           wait;
       end process stimulus;
         
              --************************ OUTPUT_TO_FILE_PROCESS *************************-- 
       output_to_file : process(Result_Select, S3_Select, Reg_write_enable)
          variable LINE_0 : line; -- Composing a Line to be written to later 
          variable HEADER_DONE : bit := '1'; -- Variable used to determine when the header is finished being written
          file RESULT_0 : text is out "results.csv"; -- Location of file being written
       begin
          if HEADER_DONE = '1' then
            write(LINE_0, string'("Instruction,Result_Select,S3_Select,Reg_write_enable")); -- Display the input data
            writeline(RESULT_0, LINE_0); -- Write to Line
            HEADER_DONE := '0'; -- Header end
          end if;
          hwrite(LINE_0, Instruction);
          write(LINE_0, string'(","));
          hwrite(LINE_0, Result_Select);
          write(LINE_0, string'(","));
          write(LINE_0, S3_Select);
          write(LINE_0, string'(","));
          write(LINE_0, Reg_write_enable);
          writeline(RESULT_0, LINE_0);
          end process output_to_file;
end Behavioral;