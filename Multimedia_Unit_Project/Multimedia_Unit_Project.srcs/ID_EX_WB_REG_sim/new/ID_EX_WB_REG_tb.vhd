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

entity ID_EX_WB_REG_tb is
end ID_EX_WB_REG_tb;

architecture Behavioral of ID_EX_WB_REG_tb is
--****************************** COMPONENT_DECLARATION ******************************--
    component ID_EX_WB_REG
    Port (
          --***** INPUTS *****--
          CLK : in std_logic; -- Clock
          Result_Select : in std_logic_vector(1 downto 0);  -- Control output that determines where final result comes from
          Register_RD : in std_logic_vector(4 downto 0);    -- Write back register address  
          Immediate_16 : in std_logic_vector(15 downto 0);  -- 16 bit immediate for Load Immediate instruction
          LI_Offset : in std_logic_vector(1 downto 0);  -- Load immediate instruction offset for 16 bit Immediate
          Opcode_R4 : in std_logic_vector(1 downto 0);  -- Opcode for R4 Instruction format
          Opcode_R3 : in std_logic_vector(3 downto 0);  -- Opcode for R3 instruction format
          Data_S1 : in std_logic_vector(63 downto 0);   -- RS1 data
          Data_S2 : in std_logic_vector(63 downto 0);   -- RS2 data
          Data_S3 : in std_logic_vector(63 downto 0);   -- R3 data
          reg_S2_instr_field : in std_logic_vector(3 downto 0); -- immediate for SHLHI instruction (R3 instruction format
          Reg_write_enable : in std_logic;  -- Enable signal write register, to allow data to be written to Register File
          --***** OUTPUTS *****--
          Result_Select_o : out std_logic_vector(1 downto 0);   
          Register_RD_o : out std_logic_vector(4 downto 0);
          Immediate_16_o : out std_logic_vector(15 downto 0);
          LI_Offset_o : out std_logic_vector(1 downto 0);
          Opcode_R4_o : out std_logic_vector(1 downto 0);
          Opcode_R3_o : out std_logic_vector(3 downto 0);
          Data_S1_o : out std_logic_vector(63 downto 0);
          Data_S2_o : out std_logic_vector(63 downto 0);
          Data_S3_o : out std_logic_vector(63 downto 0);
          reg_S2_instr_field_o : out std_logic_vector(3 downto 0);
          Reg_write_enable_o : out std_logic
          );
    end component;
    
--****************************** PORT_INITIALIZATION ******************************-- 
    -- INPUTS
          --***** INPUTS *****--
          signal CLK : std_logic; -- Clock
          signal Result_Select : std_logic_vector(1 downto 0);  -- Control output that determines where final result comes from
          signal Register_RD : std_logic_vector(4 downto 0);    -- Write back register address  
          signal Immediate_16 : std_logic_vector(15 downto 0);  -- 16 bit immediate for Load Immediate instruction
          signal LI_Offset : std_logic_vector(1 downto 0);  -- Load immediate instruction offset for 16 bit Immediate
          signal Opcode_R4 : std_logic_vector(1 downto 0);  -- Opcode for R4 Instruction format
          signal Opcode_R3 : std_logic_vector(3 downto 0);  -- Opcode for R3 instruction format
          signal Data_S1 : std_logic_vector(63 downto 0);   -- RS1 data
          signal Data_S2 : std_logic_vector(63 downto 0);   -- RS2 data
          signal Data_S3 : std_logic_vector(63 downto 0);   -- R3 data
          signal reg_S2_instr_field : std_logic_vector(3 downto 0); -- immediate for SHLHI instruction (R3 instruction format
          signal Reg_write_enable : std_logic;  -- Enable signal write register, to allow data to be written to Register File
          --***** OUTPUTS *****--
          signal Result_Select_o : std_logic_vector(1 downto 0);   
          signal Register_RD_o : std_logic_vector(4 downto 0);
          signal Immediate_16_o : std_logic_vector(15 downto 0);
          signal LI_Offset_o : std_logic_vector(1 downto 0);
          signal Opcode_R4_o : std_logic_vector(1 downto 0);
          signal Opcode_R3_o : std_logic_vector(3 downto 0);
          signal Data_S1_o : std_logic_vector(63 downto 0);
          signal Data_S2_o : std_logic_vector(63 downto 0);
          signal Data_S3_o : std_logic_vector(63 downto 0);
          signal reg_S2_instr_field_o : std_logic_vector(3 downto 0);
          signal Reg_write_enable_o : std_logic;
begin
    UUT: ID_EX_WB_REG 
        port map(CLK => CLK, Result_Select => Result_Select, Register_RD => Register_RD, Immediate_16 => Immediate_16, LI_Offset => LI_Offset, Opcode_R4 => Opcode_R4, Opcode_R3 => Opcode_R3,
        Data_S1 => Data_S1, Data_S2 => Data_S2, Data_S3 => Data_S3, reg_S2_instr_field => reg_S2_instr_field, Reg_write_enable => Reg_write_enable, Result_Select_o => Result_Select_o,
        Register_RD_o => Register_RD_o, Immediate_16_o => Immediate_16_o, LI_Offset_o => LI_Offset_o, Opcode_R4_o => Opcode_R4_o, Opcode_R3_o => Opcode_R3_o, Data_S1_o => Data_S1_o, Data_S2_o => Data_S2_o,
        Data_S3_o => Data_S3_o, reg_S2_instr_field_o => reg_S2_instr_field_o, Reg_write_enable_o => Reg_write_enable_o);
 
       --***************************** STIMULUS_PROCESS_(INPUT DATA FROM FILE) ******************************-- 
       stimulus: process  
       begin
           wait for 100 ns; -- Hold reset state for 100 ns
           
          Result_Select <= "11";
          Register_RD <= "10000";
          Immediate_16 <= X"BEEF";
          LI_Offset <= "11";
          Opcode_R4 <= "11";
          Opcode_R3 <= "1010";
          Data_S1 <= X"DEADBEEFDEADBEEF";
          Data_S2 <= X"DEADBEEFDEADBEEF";
          Data_S3 <= X"DEADBEEFDEADBEEF";
          reg_S2_instr_field <= "0101";
          Reg_write_enable <= '1';

           CLK <= '0';
           wait for 100 ns;
           CLK <= '1';
           
           wait;
       end process stimulus;
         
              --************************ OUTPUT_TO_FILE_PROCESS *************************-- 
       output_to_file : process(CLK)
          variable LINE_0 : line; -- Composing a Line to be written to later 
          variable SPACE : character := ' '; -- Character vairiable used for a spce
          variable HEADER_DONE : bit := '1'; -- Variable used to determine when the header is finished being written
          file RESULT_0 : text is out "results.csv"; -- Location of file being written
       begin
          if HEADER_DONE = '1' then
            write(LINE_0, string'("CLK,Result_Select,Register_RD,Immediate_16,LI_Offset,Opcode_R4,Opcode_R3,Data_S1,Data_S2,Data_S3,reg_S2_instr_field,Reg_write_enable,Result_Select_o,Register_RD_o,Immediate_16_o,LI_Offset_o,Opcode_R4_o,Opcode_R3_o,Data_S1_o,Data_S2_o,Data_S3_o,reg_S2_instr_field_o,Reg_write_enable_o")); -- Display the input data
            writeline(RESULT_0, LINE_0); -- Write to Line
            HEADER_DONE := '0'; -- Header end
          end if;
          write(LINE_0, CLK);
          write(LINE_0, string'(","));
          hwrite(LINE_0, Result_Select);
          write(LINE_0, string'(","));
          hwrite(LINE_0, Register_RD);
          write(LINE_0, string'(","));
          hwrite(LINE_0, Immediate_16);
          write(LINE_0, string'(","));
          hwrite(LINE_0, LI_Offset);
          write(LINE_0, string'(","));
          hwrite(LINE_0, Opcode_R4);
          write(LINE_0, string'(","));
          hwrite(LINE_0, Opcode_R3);
          write(LINE_0, string'(","));
          hwrite(LINE_0, Data_S1);
          write(LINE_0, string'(","));
          hwrite(LINE_0, Data_S2);
          write(LINE_0, string'(","));
          hwrite(LINE_0, Data_S3);
          write(LINE_0, string'(","));
          hwrite(LINE_0, reg_S2_instr_field);
          write(LINE_0, string'(","));
          write(LINE_0, Reg_write_enable);
          write(LINE_0, string'(","));
          hwrite(LINE_0, Result_Select_o);
          write(LINE_0, string'(","));
          hwrite(LINE_0, Register_RD_o);
          write(LINE_0, string'(","));
          hwrite(LINE_0, Immediate_16_o);
          write(LINE_0, string'(","));
          hwrite(LINE_0, LI_Offset_o);
          write(LINE_0, string'(","));
          hwrite(LINE_0, Opcode_R4_o);
          write(LINE_0, string'(","));
          hwrite(LINE_0, Opcode_R3_o);
          write(LINE_0, string'(","));
          hwrite(LINE_0, Data_S1_o);
          write(LINE_0, string'(","));
          hwrite(LINE_0, Data_S2_o);
          write(LINE_0, string'(","));
          hwrite(LINE_0, Data_S3_o);
          write(LINE_0, string'(","));
          hwrite(LINE_0, reg_S2_instr_field_o);
          write(LINE_0, string'(","));
          write(LINE_0, Reg_write_enable_o);
          
          writeline(RESULT_0, LINE_0); -- Write to the line
          end process output_to_file;
end Behavioral;