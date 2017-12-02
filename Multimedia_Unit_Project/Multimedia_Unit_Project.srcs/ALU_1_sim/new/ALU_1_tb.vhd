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
    constant BCW_OP : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    constant AND_OP : STD_LOGIC_VECTOR(3 downto 0) := "0001";
    constant OR_OP : STD_LOGIC_VECTOR(3 downto 0) := "0010";
    constant POPCNTH_OP : STD_LOGIC_VECTOR(3 downto 0) := "0011";
    constant CLZ_OP : STD_LOGIC_VECTOR(3 downto 0) := "0100";
    constant ROT_OP : STD_LOGIC_VECTOR(3 downto 0) := "0101";
    constant SHLHI_OP : STD_LOGIC_VECTOR(3 downto 0) := "0110";
    constant A_OP : STD_LOGIC_VECTOR(3 downto 0) := "0111";
    constant SFW_OP : STD_LOGIC_VECTOR(3 downto 0) := "1000";
    constant AH_OP : STD_LOGIC_VECTOR(3 downto 0) := "1001";
    constant SFH_OP : STD_LOGIC_VECTOR(3 downto 0) := "1010";
    constant AHS_OP : STD_LOGIC_VECTOR(3 downto 0) := "1011";
    constant SFHS_OP : STD_LOGIC_VECTOR(3 downto 0) := "1100";
    constant MPYU_OP : STD_LOGIC_VECTOR(3 downto 0) := "1101";
    constant ADBSDB_OP : STD_LOGIC_VECTOR(3 downto 0) := "1110";
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
           reg_S1 <= X"000000000000BEEF";
           reg_S2 <= X"000000000000BEEF";
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
           --opcode <= CLZ_OP;
           --reg_S1 <= X"0000000100010000";
           --wait for 100 ns;
           
           --******************* TEST_FOR_ROT_OP ********************-- 
           opcode <= ROT_OP;
           reg_S1 <= X"0000000000000003";
           reg_S2 <= X"0000000000000002";
           wait for 100 ns;
           
           --******************* TEST_FOR_SHLHI_OP ********************-- 
          -- opcode <= SHLHI_OP;
       --    reg_S1 <= X"0000000000000003";
        --   reg_S2 <= X"0000000000000002";
        --   wait for 100 ns;
        
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
          -- opcode <= AHS_OP;
          -- reg_S1 <= X"0009000400040003";
         --  reg_S2 <= X"0001000300020002";
          -- wait for 100 ns;
           
           --******************* TEST_FOR_SFHS_OP ********************-- 
          -- opcode <= SFHS_OP;
          -- reg_S1 <= X"8009800480048003";
         --  reg_S2 <= X"8001800380028002";
         --  wait for 100 ns;
           
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
         
end Behavioral;