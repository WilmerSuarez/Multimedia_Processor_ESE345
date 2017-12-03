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

entity lishift_tb is
end lishift_tb;

architecture Behavioral of lishift_tb is
--****************************** COMPONENT_DECLARATION ******************************--
    component li_shift
    Port (
          --***** INPUTS *****--
          Immediate_16 : in std_logic_vector(15 downto 0);
          LI_Offset : in std_logic_vector(1 downto 0);
          RD_Data : in std_logic_vector(63 downto 0);
          --***** OUTPUT *****-
          Result : out std_logic_vector(63 downto 0)   
          );
    end component;
    
--****************************** PORT_INITIALIZATION ******************************-- 
    -- INPUTS
    signal imm16 : std_logic_vector(15 downto 0) := (others => '0');
    signal li_offset : std_logic_vector(1 downto 0) := (others => '0');
    signal RD_Data : std_logic_vector(63 downto 0) := (others => '0');
    
    --OUTPUTS
    signal result : std_logic_vector(63 downto 0);
begin
    UUT: li_shift 
        port map(Immediate_16 => imm16, LI_Offset => li_offset, RD_Data => RD_Data, Result => result);
 
       --***************************** STIMULUS_PROCESS_(INPUT DATA FROM FILE) ******************************-- 
       stimulus: process  
       begin
           wait for 100 ns; -- Hold reset state for 100 ns
           
           --******************* TEST_FOR_BCW_OP ********************-- 
           RD_Data <= X"FFFFFFFFFFFFFFFF";
           imm16 <= X"AAAA";
           li_offset <= "00";
           wait for 100 ns;
           
           li_offset <= "01";
           wait for 100 ns;
                      
           li_offset <= "10";
           wait for 100 ns;
                                 
           li_offset <= "11";
           wait for 100 ns;

           wait;
       end process stimulus;
         
       --************************ OUTPUT_TO_FILE_PROCESS *************************-- 
       output_to_file : process(result)
          variable LINE_0 : line; -- Composing a Line to be written to later 
          variable HEADER_DONE : bit := '1'; -- Variable used to determine when the header is finished being written
          file RESULT_0 : text is out "results.csv"; -- Location of file being written
       begin
          if HEADER_DONE = '1' then
            write(LINE_0, string'("Imm16,LIOffset,Result")); -- Display the input data
            writeline(RESULT_0, LINE_0); -- Write to Line
            HEADER_DONE := '0'; -- Header end
          end if;
          hwrite(LINE_0, imm16);
          write(LINE_0, string'(","));
          hwrite(LINE_0, li_offset);
          write(LINE_0, string'(","));
          hwrite(LINE_0, result);
          writeline(RESULT_0, LINE_0); -- Write to the line
          end process output_to_file;
end Behavioral;