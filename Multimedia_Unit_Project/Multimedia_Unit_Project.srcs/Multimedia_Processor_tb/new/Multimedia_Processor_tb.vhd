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
use IEEE.NUMERIC_STD.ALL;
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
          Write_Enable_buff : in std_logic;
          Instruction_In : in std_logic_vector(23 downto 0);
          --***** OUTPUTS *****--
          --***** IF STAGE *****--
          Instruction_In_IF : out std_logic_vector(23 downto 0);
          --***** ID STAGE *****--
          Data_S1_ID : out std_logic_vector(63 downto 0);
          Data_S2_ID : out std_logic_vector(63 downto 0);
          Data_S3_ID : out std_logic_vector(63 downto 0);
          RS2_Inst_Field_ID : out std_logic_vector(3 downto 0);
          Opcode_R3_ID : out std_logic_vector(3 downto 0);
          Opcode_R4_ID : out std_logic_vector(1 downto 0);
          Register_RD_ID : out std_logic_vector(4 downto 0);
          Immediate_16_ID : out std_logic_vector(15 downto 0);
          LI_Offset_ID : out std_logic_vector(1 downto 0);
          Result_Select_ID : out std_logic_vector(1 downto 0);
          Register_Write_Enable_ID : out std_logic;
          --***** EX&WB STAGE *****--
          Final_Result_EX : out std_logic_vector(63 downto 0)
          );
    end component;
    
--****************************** PORT_INITIALIZATION ******************************-- 
    -- INPUTS
    signal CLK : std_logic;
    signal RESET : std_logic := '1';
    signal Write_Enable_buff : std_logic;
    signal Instruction_In : std_logic_vector(23 downto 0);
    
    -- OUTPUTS
    
    --***** IF STAGE *****--
    signal Instruction_In_IF : std_logic_vector(23 downto 0);
    --***** ID STAGE *****--
    signal Data_S1_ID : std_logic_vector(63 downto 0);
    signal Data_S2_ID : std_logic_vector(63 downto 0);
    signal Data_S3_ID : std_logic_vector(63 downto 0);
    signal RS2_Inst_Field_ID : std_logic_vector(3 downto 0);
    signal Opcode_R3_ID : std_logic_vector(3 downto 0);
    signal Opcode_R4_ID : std_logic_vector(1 downto 0);
    signal Register_RD_ID : std_logic_vector(4 downto 0);
    signal Immediate_16_ID : std_logic_vector(15 downto 0);
    signal LI_Offset_ID : std_logic_vector(1 downto 0);
    signal Result_Select_ID : std_logic_vector(1 downto 0);
    signal Register_Write_Enable_ID : std_logic;
    --***** EX&WB STAGE *****--
    signal Final_Result_EX : std_logic_vector(63 downto 0);
    
    -- CLOCK_PERIOD 
    constant clk_period : time := 10 ns;
begin
    UUT: Multimedia_Processor
        port map(CLK => CLK, RESET => RESET, Write_Enable_buff => Write_Enable_buff, Instruction_In => Instruction_In, Instruction_In_IF => Instruction_In_IF,
        Data_S1_ID => Data_S1_ID, Data_S2_ID => Data_S2_ID, Data_S3_ID => Data_S3_ID, RS2_Inst_Field_ID => RS2_Inst_Field_ID, Opcode_R3_ID => Opcode_R3_ID,
        Opcode_R4_ID => Opcode_R4_ID, Register_RD_ID => Register_RD_ID, Immediate_16_ID => Immediate_16_ID, LI_Offset_ID => LI_Offset_ID, Result_Select_ID => Result_Select_ID,
        Register_Write_Enable_ID => Register_Write_Enable_ID, Final_Result_EX => Final_Result_EX);
 
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
       variable LINE_OUT : line;
       variable INSTRUCTION : std_logic_vector(23 downto 0);
       variable count : integer := 0;
       file INSTRUCTION_I : text is in "Instructions_matrix.txt";
       file REG_FILE_O : text is out "register_file.txt";
    begin
       Write_Enable_buff <= '1';
       RESET <= '0';
       while not endfile(INSTRUCTION_I) loop
           readline(INSTRUCTION_I, LINE_IN);
           hread(LINE_IN, INSTRUCTION);
           Instruction_In <= INSTRUCTION;
           wait for clk_period;
       end loop;
       
       Write_Enable_buff <= '0'; -- Clear Write_Enable for intruction buffer
       RESET <= '1';
       wait for clk_period;
       RESET <= '0';
       wait for 33 * clk_period;
       
       -- Start reading the register file
       RESET <= '1';
       Write_Enable_buff <= '1';
       wait for clk_period;
       RESET <= '0';
       for i in 0 to 31 loop
            Instruction_In <= (others => '0');
            Instruction_In(9 downto 5) <= std_logic_vector(to_unsigned(i, 5));
            wait for clk_period;
       end loop;
       
       Write_Enable_buff <= '0';
       RESET <= '1';
       wait for clk_period;
       RESET <= '0';
       wait for 3*clk_period;
       for i in 31 downto 0 loop
            hwrite(LINE_OUT, Data_S1_ID);
            writeline(REG_FILE_O, LINE_OUT);
            wait for clk_period; 
       end loop;
       
       wait;
    end process stimulus;
    
    --************************ OUTPUT_TO_FILE_PROCESS *************************-- 
    output_to_file : process(CLK)
        variable LINE_O : line; -- Composing a Line to be written to later 
        variable HEADER_DONE : bit := '1'; -- Variable used to determine when the header is finished being written
        file RESULT : text is out "result.csv"; -- Location of file being written
    begin
        if(rising_edge(CLK)) then
            if HEADER_DONE = '1' then
                write(LINE_O, string'("Instruction_In_IF,Data_S1_ID,Data_S2_ID,Data_S3_ID,RS2_Inst_Field_ID,Opcode_R3_ID,Opcode_R4_ID,Register_RD_ID,Immediate_16_ID,LI_Offset_ID,Result_Select_ID,Register_Write_Enable_ID,Final_Result_EX")); -- Header to display the output register S1
                writeline(RESULT, LINE_O); -- Write to line
                HEADER_DONE := '0'; -- Header end
            end if;
            hwrite(LINE_O, Instruction_In_IF); 
            write(LINE_O, string'(","));
            hwrite(LINE_O, Data_S1_ID); 
            write(LINE_O, string'(","));
            hwrite(LINE_O, Data_S2_ID); 
            write(LINE_O, string'(","));
            hwrite(LINE_O, Data_S3_ID); 
            write(LINE_O, string'(","));
            hwrite(LINE_O, RS2_Inst_Field_ID); 
            write(LINE_O, string'(","));
            hwrite(LINE_O, Opcode_R3_ID); 
            write(LINE_O, string'(","));
            hwrite(LINE_O, Opcode_R4_ID); 
            write(LINE_O, string'(","));
            hwrite(LINE_O, Register_RD_ID); 
            write(LINE_O, string'(","));
            hwrite(LINE_O, Immediate_16_ID); 
            write(LINE_O, string'(","));
            hwrite(LINE_O, LI_Offset_ID); 
            write(LINE_O, string'(","));
            hwrite(LINE_O, Result_Select_ID); 
            write(LINE_O, string'(","));
            write(LINE_O, Register_Write_Enable_ID); 
            write(LINE_O, string'(","));
            hwrite(LINE_O, Final_Result_EX); 
            write(LINE_O, string'(","));
            writeline(RESULT, LINE_O); -- Write to the line
        end if;
    end process output_to_file;
end Behavioral;