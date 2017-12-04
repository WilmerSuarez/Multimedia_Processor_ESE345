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

entity ALU_1_tb is
end ALU_1_tb;

architecture Behavioral of ALU_1_tb is
--****************************** COMPONENT_DECLARATION ******************************--
    component multimedia_ALU
        port(
             opcode : in std_logic_vector(3 downto 0); 
             reg_S1 : in std_logic_vector(63 downto 0);
             reg_S2 : in std_logic_vector(63 downto 0);
             reg_S2_instr_field : in std_logic_vector(3 downto 0);
             result : out std_logic_vector(63 downto 0)
             );
    end component;
    
--****************************** PORT_INITIALIZATION ******************************-- 
    -- INPUTS
    signal opcode : std_logic_vector(3 downto 0) := (others => '0');
    signal reg_S1 : std_logic_vector(63 downto 0) := (others => '0');
    signal reg_S2 : std_logic_vector(63 downto 0) := (others => '0');
    signal reg_S2_instr_field : std_logic_vector(3 downto 0) := (others => '0');
    
    --OUTPUTS
    signal result : std_logic_vector(63 downto 0);
    --OPCODE_CONSTANTS
    constant BCW_OP : STD_LOGIC_VECTOR(3 downto 0) := "0001";
    constant AND_OP : STD_LOGIC_VECTOR(3 downto 0) := "0010";
    constant OR_OP : STD_LOGIC_VECTOR(3 downto 0) := "0011";
    constant POPCNTH_OP : STD_LOGIC_VECTOR(3 downto 0) := "0100";
    constant CLZ_OP : STD_LOGIC_VECTOR(3 downto 0) := "0101";
    constant ROT_OP : STD_LOGIC_VECTOR(3 downto 0) := "0110";
    constant SHLHI_OP : STD_LOGIC_VECTOR(3 downto 0) := "0111";
    constant A_OP : STD_LOGIC_VECTOR(3 downto 0) := "1000";
    constant SFW_OP : STD_LOGIC_VECTOR(3 downto 0) := "1001";
    constant AH_OP : STD_LOGIC_VECTOR(3 downto 0) := "1010";
    constant SFH_OP : STD_LOGIC_VECTOR(3 downto 0) := "1011";
    constant AHS_OP : STD_LOGIC_VECTOR(3 downto 0) := "1100";
    constant SFHS_OP : STD_LOGIC_VECTOR(3 downto 0) := "1101";
    constant MPYU_OP : STD_LOGIC_VECTOR(3 downto 0) := "1110";
    constant ADBSDB_OP : STD_LOGIC_VECTOR(3 downto 0) := "1111";
begin
    UUT: multimedia_ALU 
        port map(opcode => opcode, reg_S1 => reg_S1, reg_S2 => reg_S2,
        reg_S2_instr_field => reg_S2_instr_field, result => result);
 
       --***************************** STIMULUS_PROCESS_(INPUT DATA FROM FILE) ******************************-- 
       stimulus: process  
       begin
           wait for 100 ns; -- Hold reset state for 100 ns
           
           --******************* TEST_FOR_BCW_OP ********************-- 
           opcode <= BCW_OP;
           reg_S1 <= X"00000000DEADBEEF";
           wait for 100 ns;
           
           --******************* TEST_FOR_AND_OP ********************-- 
           opcode <= AND_OP;
           reg_S1 <= X"000000000000BEEF";
           reg_S2 <= X"000000000000BEEF";
           wait for 100 ns;
           
           --******************* TEST_FOR_OR_OP ********************-- 
           opcode <= OR_OP;
           reg_S1 <= X"000000000000BEEF";
           reg_S2 <= X"000000000000BAAF";
           wait for 100 ns;
           
           --******************* TEST_FOR_POPCNTH_OP ********************-- 
           opcode <= POPCNTH_OP;
           reg_S1 <= X"0001001111101111";
           wait for 100 ns;
           
           --******************* TEST_FOR_CLZ_OP ********************-- 
           opcode <= CLZ_OP;
           reg_S1 <= X"0000000000000100";
           wait for 100 ns;
           
           --******************* TEST_FOR_ROT_OP ********************-- 
           opcode <= ROT_OP;
           reg_S1 <= X"0000000000000003";
           reg_S2 <= X"0000000000000002";
           wait for 100 ns;
           
           --******************* TEST_FOR_SHLHI_OP ********************-- 
           opcode <= SHLHI_OP;
           reg_S1 <= X"0000000000000003";
           reg_S2_instr_field <= "0010";
           wait for 100 ns;
        
           --******************* TEST_FOR_ROT_OP ********************-- 
           opcode <= A_OP;
           reg_S1 <= X"0000000400000003";
           reg_S2 <= X"0000000300000002";
           wait for 100 ns;
           
           --******************* TEST_FOR_SFW_OP ********************-- 
           opcode <= SFW_OP;
           reg_S1 <= X"0000000400000003";
           reg_S2 <= X"0000000300000002";
           wait for 100 ns;
           
           --******************* TEST_FOR_AH_OP ********************-- 
           opcode <= AH_OP;
           reg_S1 <= X"0001000400020003";
           reg_S2 <= X"0001000300020002";
           wait for 100 ns;
           
           --******************* TEST_FOR_SFH_OP ********************-- 
           opcode <= SFH_OP;
           reg_S1 <= X"0009000400040003";
           reg_S2 <= X"0001000300020002";
           wait for 100 ns;
           
           --******************* TEST_FOR_AHS_OP ********************-- 
           opcode <= AHS_OP;
           reg_S1 <= X"800980048004FFFD";
           reg_S2 <= X"800180038002FFFE";
           wait for 100 ns;
                      
           opcode <= AHS_OP;
           reg_S1 <= X"7FFF7FFF7FFF7FFF";
           reg_S2 <= X"7FFF7FFF7FFF7FFF";
           wait for 100 ns;
                                 
           opcode <= AHS_OP;
           reg_S1 <= X"8000800080008000";
           reg_S2 <= X"FFFFFFFFFFFFFFFF";
           wait for 100 ns;
           
           --******************* TEST_FOR_SFHS_OP ********************-- 
           opcode <= SFHS_OP;
           reg_S1 <= X"800980048004FFF7";
           reg_S2 <= X"800180038002000A";
           wait for 100 ns;
           
           opcode <= SFHS_OP;
           reg_S1 <= X"7FFF7FFF7FFF7FFF";
           reg_S2 <= X"8001800180018001";
           wait for 100 ns;
           
           opcode <= SFHS_OP;
           reg_S1 <= X"8000800080008000";
           reg_S2 <= X"0001000100010001";
           wait for 100 ns;
           
           --******************* TEST_FOR_MPYU_OP ********************-- 
           opcode <= MPYU_OP;
           reg_S1 <= X"0000000200000008";
           reg_S2 <= X"0000000500000001";
           wait for 100 ns;
           
           --******************* TEST_FOR_ADBSDB_OP ********************-- 
           opcode <= ADBSDB_OP;
           reg_S1 <= X"0305050409060A03";
           reg_S2 <= X"0b0108030A020B02";
           wait for 100 ns;
           
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
            write(LINE_0, string'("S1,S2,S2Instr,OpCode,Result")); -- Display the input data
            writeline(RESULT_0, LINE_0); -- Write to Line
            HEADER_DONE := '0'; -- Header end
          end if;
          hwrite(LINE_0, reg_S1);
          write(LINE_0, string'(","));
          hwrite(LINE_0, reg_S2);
          write(LINE_0, string'(","));
          hwrite(LINE_0, reg_S2_instr_field);
          write(LINE_0, string'(","));
          hwrite(LINE_0, opcode);
          write(LINE_0, string'(","));
          hwrite(LINE_0, result);
          writeline(RESULT_0, LINE_0); -- Write to the line
          end process output_to_file;
end Behavioral;