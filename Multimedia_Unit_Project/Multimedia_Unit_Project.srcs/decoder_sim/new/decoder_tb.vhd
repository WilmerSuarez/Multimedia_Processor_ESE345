----------------------------------------------------------------------------------
-- Engineer (s): Wilmer Suarez, Himanshu 
-- 
-- Create Date: 12/02/2017 12:31:38 AM
-- Design Name: Decoder Testbench
-- Module Name: decoder_tb - Behavioral
-- Project Name: Multimedia_Processor
-- Tool Versions: Vivado 2017.3
--
-- Description: Test Bench for the Decoder
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.std_logic_textio.all; -- I/O Logic
use STD.TEXTIO.ALL; -- I/O functions and procedures

entity decoder_tb is
end decoder_tb;

architecture Behavioral of decoder_tb is
--****************************** COMPONENT_DECLARATION ******************************--
    component decoder
    Port (
          --***** INPUT *****--
          instruction : in std_logic_vector(23 downto 0);   -- Instruction
          --***** OUTPUTS *****--
          Register_rd_o : out std_logic_vector(4 downto 0); -- Write Back register address
          Immediate_16_o : out std_logic_vector(15 downto 0);   -- 16 bit Immediate for Load Immediate Instruction
          LI_Offset_o : out std_logic_vector(1 downto 0);   -- Load Immediate Instruction offset for 16 bit Immediate
          Opcode_R4_o : out std_logic_vector(1 downto 0);   -- Opcode for R4 instruction format
          Opcode_R3_o : out std_logic_vector(3 downto 0);   -- Opcode for R3 instruction format
          Reg_RS1_o : out std_logic_vector(4 downto 0); -- Address for register RS1
          Reg_RS2_o : out std_logic_vector(4 downto 0); -- Address for register RS2
          Reg_RS3_o : out std_logic_vector(4 downto 0)  -- Address for register RS3
          );
    end component;
    
--****************************** PORT_INITIALIZATION ******************************--
--***** INPUT *****--
signal Instruction : std_logic_vector(23 downto 0);   -- Instruction

--***** OUTPUTS *****--
signal Register_rd_o : std_logic_vector(4 downto 0); -- Write Back register address
signal Immediate_16_o : std_logic_vector(15 downto 0);   -- 16 bit Immediate for Load Immediate Instruction
signal LI_Offset_o : std_logic_vector(1 downto 0);   -- Load Immediate Instruction offset for 16 bit Immediate
signal Opcode_R4_o : std_logic_vector(1 downto 0);   -- Opcode for R4 instruction format
signal Opcode_R3_o : std_logic_vector(3 downto 0);   -- Opcode for R3 instruction format
signal Reg_RS1_o : std_logic_vector(4 downto 0); -- Address for register RS1
signal Reg_RS2_o : std_logic_vector(4 downto 0); -- Address for register RS2
signal Reg_RS3_o : std_logic_vector(4 downto 0);  -- Address for register RS3
begin
    UUT: decoder
        port map(instruction => instruction, Register_rd_o => Register_rd_o, Immediate_16_o => Immediate_16_o, 
        LI_Offset_o => LI_Offset_o, Opcode_R4_o => Opcode_R4_o, Opcode_R3_o => Opcode_R3_o, Reg_RS1_o => Reg_RS1_o, 
        Reg_RS2_o => Reg_RS2_o, Reg_RS3_o => Reg_RS3_o);
 
       --***************************** STIMULUS_PROCESS_(INPUT DATA FROM FILE) ******************************-- 
       stimulus: process  
       begin
           wait for 100 ns; -- Hold reset state for 100 ns
           
           -- R1 type format instruction
           Instruction <= X"AFFFFF";
           wait for 100 ns;
           
           -- R3 type format instruction
           Instruction <= X"0FFFFF";
           wait for 100 ns;
                      
           -- R4 type format instruction
           Instruction <= X"4FFFFF";
           
           wait;
       end process stimulus;
         
       --************************ OUTPUT_TO_FILE_PROCESS *************************-- 
       output_to_file : process(Register_rd_o, Immediate_16_o, LI_Offset_o, Opcode_R4_o, Opcode_R3_o, Reg_RS1_o, Reg_RS2_o, Reg_RS3_o)
          variable LINE_0 : line; -- Composing a Line to be written to later 
          variable SPACE : character := ' '; -- Character vairiable used for a spce
          variable HEADER_DONE : bit := '1'; -- Variable used to determine when the header is finished being written
          file RESULT_0 : text is out "results.csv"; -- Location of file being written
       begin
          if HEADER_DONE = '1' then
            write(LINE_0, string'("Instruction,Register_rd_o,Immediate_16_o,LI_Offset_o,Opcode_R4_o,Opcode_R3_o,Reg_RS1_o,Reg_RS2_o,Reg_RS3_o")); -- Display the input data
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
          
          writeline(RESULT_0, LINE_0);
          end process output_to_file;
end Behavioral;