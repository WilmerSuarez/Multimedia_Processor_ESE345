----------------------------------------------------------------------------------
-- Engineer(s): Wilmer Suarez, Himanshu Goel 
-- 
-- Create Date: 12/02/2017 09:00:15 PM
-- Design Name: Multimedia Processor
-- Module Name: Multimedia_Processor - Behavioral
-- Project Name: Multimedia_Processor
-- Tool Versions: Vivado 2017.3
--
-- Description: Multimedia Processor
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Multimedia_Processor is
    Port (
          --***** INPUTS *****--
          CLK : in std_logic;
          RESET : in std_logic;
          Write_Enable : in std_logic;
          Instruction_In : in std_logic_vector(23 downto 0)
          --***** OUTPUTS *****--
          --PC_Out_IF : out std_logic_vector(4 downto 0);
          --Instruction_Out_IF : out std_logic_vector(23 downto 0);
          --Instruction_Out_ID : out std_logic_vector(23 downto 0)
          );
end Multimedia_Processor;

architecture Behavioral of Multimedia_Processor is
--************* Connection Signals *************--
--********** IF_STAGE SIGNALS **********--
signal PC_wire : std_logic_vector(4 downto 0);
signal Instruction_wire_IF : std_logic_vector(23 downto 0);
--********** ID_STAGE SIGNALS **********--
signal Instruction_wire_ID : std_logic_vector(23 downto 0);
signal Register_rd_o_wire : std_logic_vector(4 downto 0); 
signal Immediate_16_o_wire : std_logic_vector(15 downto 0);   
signal LI_Offset_o_wire, Opcode_R4_o_wire : std_logic_vector(1 downto 0);
signal Opcode_R3_o_wire : std_logic_vector(6 downto 0);   
signal Reg_RS1_o_wire, Reg_RS2_o_wire, Reg_RS3_o_wire : std_logic_vector(4 downto 0);
signal instruction_o_wire : std_logic_vector(23 downto 0);
signal Result_Select_wire : std_logic_vector(1 downto 0);
signal Reg_write_enable_wire : std_logic;
signal Data_S1_wire, Data_S2_wire, Data_S3_wire : std_logic_vector(63 downto 0);
--********** EX&WB_STAGE SIGNALS **********--
signal Result_Select_EX : std_logic_vector(1 downto 0);
signal Register_RD_EX : std_logic_vector(4 downto 0);
signal Immediate_16_EX : std_logic_vector(15 downto 0);
signal LI_Offset_EX, Opcode_R4_EX: std_logic_vector(1 downto 0);
signal Opcode_R3_EX : std_logic_vector(1 downto 0);
signal Data_S1_EX, Data_S2_EX, Data_S3_EX : std_logic_vector(63 downto 0);
signal reg_S2_instr_field_EX : std_logic_vector(3 downto 0);
signal Reg_write_enable_EX : std_logic;
signal result_ALU_1, result_ALU_2, Result_LI, Final_Result : std_logic_vector(63 downto 0);
begin
--***************** Program_Counter *****************--
program_counter : entity work.program_counter_reg
    port map(
             CLK => CLK, 
             reset => RESET,
             PC_Out => PC_wire
             );
--*************** Instruction_Buffer ***************--
insturction_buffer : entity work.instruction_buffer
    port map(
             CLK => CLK,
             Write_Enable => Write_Enable,
             PC_In => PC_Wire,
             Instruction_In => Instruction_In,
             Instruction_Out => Instruction_wire_IF
             );
--***************** IF/ID_Register *****************--
IF_ID_REG : entity work.IF_ID_REG
    port map(
             CLK => CLK,
             Instruction_In => Instruction_wire_IF,
             Instruction_Out => Instruction_wire_ID
             );
--******************** Decoder ********************--
decoder : entity work.decoder
    port map(
             instruction => Instruction_wire_ID,
             Register_rd_o => Register_rd_o_wire,
             Immediate_16_o => Immediate_16_o_wire,
             LI_Offset_o => LI_Offset_o_wire,
             Opcode_R4_o => Opcode_R4_o_wire,
             Opcode_R3_o => Opcode_R3_o_wire,
             Reg_RS1_o => Reg_RS1_o_wire, 
             Reg_RS2_o => Reg_RS2_o_wire,
             Reg_RS3_o => Reg_RS3_o_wire,
             instruction_o => instruction_o_wire
             );
--******************** Control_Unit ********************--
control_unit : entity work.control_unit
    port map(
             Instruction => instruction_o_wire,
             Result_Select => Result_Select_wire,
             Reg_write_enable => Reg_write_enable_wire
             ); 
--******************** Register_File ********************--
register_file : entity work.register_file
    port map(
             CLK => CLK,
             Write_Register => Register_RD_EX,
             Data_In => Final_Result,
             Read_Register_S1 => Reg_RS1_o_wire,
             Read_Register_S2 => Reg_RS2_o_wire,
             Read_Register_S3 => Reg_RS3_o_wire,
             Write_enable => Reg_write_enable_wire,
             Data_S1 => Data_S1_wire,
             Data_S2 => Data_S2_wire,
             Data_S3 => Data_S3_wire
             );
--******************** ID_EX_WB_REG ********************--
ID_EX_WB_REG : entity work.ID_EX_WB_REG
    port map(
             CLK => CLK,
             Result_Select => Result_Select_wire,
             Register_RD => Register_rd_o_wire,
             Immediate_16 => Immediate_16_o_wire,
             LI_Offset => LI_Offset_o_wire,
             Opcode_R4 => Opcode_R4_o_wire,
             Opcode_R3 => Opcode_R3_o_wire,
             Data_S1 => Data_S1_wire,
             Data_S2 => Data_S2_wire,
             Data_S3 => Data_S3_wire,
             reg_S2_instr_field => Reg_RS2_o_wire,
             Reg_write_enable => Reg_write_enable_wire, 
             Result_Select_o => Result_Select_EX,
             Register_RD_o => Register_RD_EX,
             Immediate_16_o => Immediate_16_EX,
             LI_Offset_o => LI_Offset_EX,
             Opcode_R4_o => Opcode_R4_EX,
             Opcode_R3_o => Opcode_R3_EX,
             Data_S1_o => Data_S1_EX,
             Data_S2_o => Data_S2_EX,
             Data_S3_o => Data_S3_EX,
             reg_S2_instr_field_o => reg_S2_instr_field_EX,
             Reg_write_enable_o => Reg_write_enable_EX
             );
--******************** Multimedia_ALU ********************--
multimedia_ALU : entity work.multimedia_ALU
    port map(
             opcode => Opcode_R3_o_wire,
             reg_S1 => Data_S1_EX,
             reg_S2 => Data_S2_EX,
             reg_S2_instr_field => reg_S2_instr_field_EX,
             result => result_ALU_1
             );
--******************** Multimedia_ALU_2 ********************--
multimedia_ALU_2 : entity work.multimedia_ALU_2
    port map(
             opcode => Opcode_R4_EX,
             reg_S1 => Data_S1_EX,
             reg_S2 => Data_S2_EX,
             reg_S3 => Data_S3_EX,
             result => result_ALU_2
             );
--****************** Load_Immediate_SHIFTER ******************--
li_shift : entity work.li_shift
    port map(
             Immediate_16 => Immediate_16_EX,
             LI_Offset => LI_Offset_EX,
             Result => Result_LI
             );
--******************* Register_Select_Mux *******************--
mux_3 : entity work.mux_3
    port map(
             Result_Select => Result_Select_EX,
             R3_Result => result_ALU_1,
             R4_Result => result_ALU_2,
             LI_Result => Result_LI,
             Final_Result => Final_Result
             );
end Behavioral;
