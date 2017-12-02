----------------------------------------------------------------------------------
-- Engineer (s): Wilmer Suarez, Himanshu 
-- 
-- Create Date: 10/30/2017 11:31:38 PM
-- Design Name: Register file Testbench
-- Module Name: register_file_tb - Behavioral
-- Project Name: Multimedia_Processor
-- Tool Versions: Vivado 2017.3
--
-- Description: Testbench for the Register File
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_textio.all; -- I/O Logic
use STD.TEXTIO.ALL; -- I/O functions and procedures

entity register_file_tb is
end register_file_tb;

architecture Behavioral of register_file_tb is
--****************************** COMPONENT_DECLARATION ******************************--
    component register_file
        port(
              CLK : in STD_LOGIC; 
              Write_Register : in STD_LOGIC_VECTOR(4 downto 0);
              Data_In : in STD_LOGIC_VECTOR(63 downto 0);
              Read_Register_S1 : in STD_LOGIC_VECTOR(4 downto 0);
              Read_Register_S2 : in STD_LOGIC_VECTOR(4 downto 0);
              Read_Register_S3 : in STD_LOGIC_VECTOR(4 downto 0);
              Write_enable : in std_logic;
              Data_S1 : out STD_LOGIC_VECTOR(63 downto 0);
              Data_S2 : out STD_LOGIC_VECTOR(63 downto 0);
              Data_S3 : out STD_LOGIC_VECTOR(63 downto 0)
              );
    end component;
    
--****************************** PORT_INITIALIZATION ******************************-- 
    -- INPUTS
    signal CLK : std_logic;
    signal Write_Register : std_logic_vector(4 downto 0) := (others => '0');
    signal Data_In : std_logic_vector(63 downto 0) := (others => '0');
    signal Read_Register_S1 : std_logic_vector(4 downto 0) := (others => '0');
    signal Read_Register_S2 : std_logic_vector(4 downto 0) := (others => '0');
    signal Read_Register_S3 : std_logic_vector(4 downto 0) := (others => '0');
    signal Write_Enable : std_logic := '0';
 
    --OUTPUTS
    signal Data_S1 : std_logic_vector(63 downto 0);
    signal Data_S2 : std_logic_vector(63 downto 0);
    signal Data_S3 : std_logic_vector(63 downto 0);
 
    -- CLOCK_PERIOD 
    constant clk_period : time := 10 ns;
    
begin
    UUT: register_file 
        port map(CLK => CLK, Write_Register => Write_Register, Data_In => Data_In, Read_Register_S1 => Read_Register_S1,
        Read_Register_S2 => Read_Register_S2, Read_Register_S3 => Read_Register_S3, Write_Enable => Write_Enable,
        Data_S1 => Data_S1, Data_S2 => Data_S2, Data_S3 => Data_S3);
   
--***************************** CLOCK_GENERATION_PROCESSS ******************************-- 
        clk_generation: process
        begin
            clk <= '0';
                wait for clk_period / 2;
            clk <= '1';
                wait for clk_period / 2;
        end process clk_generation;
       
--***************************** STIMULUS_PROCESS ******************************-- 
       stimulus: process
       begin
           wait for 100 ns; -- Hold reset state for 100 ns
             
           --****************************** TEST_1 ******************************--
           Write_Register <= "00100";   -- Select register 4 to write to
           Data_in <= X"000000000000BEEF";  -- Data to be written
           Read_Register_S1 <= "00100"; -- Register to be read (register 4)
           Write_Enable <= '1'; -- Enable the register to allow writes
           wait for clk_period;
           Write_Enable <= '0'; -- Disable the write enable
           wait for clk_period;
           
           --****************************** TEST_2 ******************************--
           Write_Register <= "00100";   -- Select register 4 to write
           Data_in <= X"0000BEEF00000000";  -- Data to be written (changed)
           Read_Register_S1 <= "00100"; -- Register to be read (unchanged)
           Write_Enable <= '1'; -- Enable register writes
           wait for clk_period;
           Write_Enable <= '0'; -- Disable the write enable
           wait for clk_period;

               wait;
           end process stimulus;
           
           --************************ OUTPUT_TO_FILE_PROCESS *************************-- 
           output_to_file : process(Data_S1)
               variable LINE_O : line; -- Composing a Line to be written to later 
               variable SPACE : character := ' '; -- Character vairiable used for a spce
               variable HEADER_DONE : bit := '1'; -- Variable used to determine when the header is finished being written
               file RESULT : text is out "C:/Users/Wilmer Suarez/Desktop/ESE_345_PROJECT/Multimedia_Unit_Project/Multimedia_Unit_Project.srcs/register_file_sim/new/register_file_result.txt"; -- Location of file being written
           begin
               if HEADER_DONE = '1' then
                   write(LINE_O, string'("TEST1 - Data_In: ")); -- Display the input data 
                   write(LINE_O, SPACE); -- Write a Space
                   write(LINE_O, string'("000000000000BEEF"));
                   writeline(RESULT, LINE_O); -- Write to Line
                   write(LINE_O, string'("TEST2 - Data_In: "));
                   write(LINE_O, SPACE); -- Write a Space
                   write(LINE_O, string'("0000BEEF00000000"));
                   writeline(RESULT, LINE_O); -- Write two lines
                   writeline(RESULT, LINE_O);
                   write(LINE_O, string'("Write_Register")); -- Header for displaying the register to be written
                   write(LINE_O, SPACE); -- Write a Space
                   write(LINE_O, string'("Data_S1")); -- Header to display the output register S1
                   writeline(RESULT, LINE_O); -- Write to line
                   HEADER_DONE := '0'; -- Header end
               end if;
               hwrite(LINE_O, Write_Register); -- Write the register to be written
               write(LINE_O, string'("             ")); -- Added space for formatting
               hwrite(LINE_O, Data_S1); -- Write the output data of register S1
               writeline(RESULT, LINE_O); -- Write to the line
           end process output_to_file;
        
end Behavioral;