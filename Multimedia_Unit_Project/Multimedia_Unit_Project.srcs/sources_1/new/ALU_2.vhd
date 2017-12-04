----------------------------------------------------------------------------------
-- Engineer(s): Wilmer Suarez, Himanshu Goel
-- 
-- Create Date: 11/03/2017 10:02:18 PM
-- Design Name: Multimedia_ALU_2
-- Module Name: multimedia_ALU_2 - Behavioral
-- Project Name: Multimedia Processor
-- Tool Versions: Vivado 2017.3
--
-- Description: This Arithmetic Logic Unit executes R4 format instructions.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity multimedia_ALU_2 is
    Port (
          --***** INPUTS *****--
          opcode : in std_logic_vector(1 downto 0); -- Opcode for R4 instruction format
          reg_S1 : in std_logic_vector(63 downto 0);  -- Register RS1
          reg_S2 : in std_logic_vector(63 downto 0);  -- Register RS2
          reg_S3 : in std_logic_vector(63 downto 0);  -- Register RS3     
          --***** OUTPUT *****--
          result : out std_logic_vector(63 downto 0)    -- Final Result to be written back to Register File
          );
end multimedia_ALU_2;

architecture Behavioral of multimedia_ALU_2 is
--******************** OP_CODE_VALUES ********************--
constant SIMALS_OP : STD_LOGIC_VECTOR(1 downto 0) := "00"; -- Signed integer multiple-add low with saturation
constant SIMAHS_OP : STD_LOGIC_VECTOR(1 downto 0) := "01"; -- Signed integer multiple-add high with saturation
constant SIMSLS_OP : STD_LOGIC_VECTOR(1 downto 0) := "10"; -- Signed integer multiple-subtract low with saturation
constant SIMSHS_OP : STD_LOGIC_VECTOR(1 downto 0) := "11"; -- Signed integer multiple-subtract high with saturation

function FMADD (
    a : std_logic_vector(15 downto 0);
    b : std_logic_vector(15 downto 0);
    c : std_logic_vector(31 downto 0))
return std_logic_vector is
            variable multiplicand : signed(15 downto 0) := (others => '0');  
            variable multiplier : signed(15 downto 0) := (others => '0');
            variable product : signed(31 downto 0) := (others => '0');
            variable final_result : signed(31 downto 0) := (others => '0');
            variable sign_test : std_logic_vector(2 downto 0) := (others => '0');
 begin
                 multiplicand := signed(a);
                 multiplier := signed(b);
                 product := multiplicand * multiplier;
                 final_result := product + signed(c);
                 
                 sign_test := product(31) & c(31) & final_result(31); 
                 
                 if(sign_test = "001") then
                     final_result := X"7FFFFFFF";
                 elsif (sign_test = "110") then
                     final_result := X"80000000";
                 end if;
 return std_logic_vector(final_result);
 end FMADD;

 function FMSUB (
     a : std_logic_vector(15 downto 0);
     b : std_logic_vector(15 downto 0);
     c : std_logic_vector(31 downto 0))
 return std_logic_vector is
             variable multiplicand : signed(15 downto 0) := (others => '0');  
             variable multiplier : signed(15 downto 0) := (others => '0');
             variable product : signed(31 downto 0) := (others => '0');
             variable final_result : signed(31 downto 0) := (others => '0');
             variable sign_test : std_logic_vector(2 downto 0) := (others => '0');
  begin
                  multiplicand := signed(a);
                  multiplier := signed(b);
                  product := multiplicand * multiplier;
                  final_result := signed(c) - product;
                  
                  sign_test := c(31) & product(31) & final_result(31); 
                  
                  if(sign_test = "011") then
                      final_result := X"7FFFFFFF";
                  elsif (sign_test = "100") then
                      final_result := X"80000000";
                  end if;
  return std_logic_vector(final_result);
  end FMSUB;
  
begin
    --********************************** ALU_PROCESS *********************************--
    ALU_proc: process(opcode, reg_S1, reg_S2, reg_S3) is
    begin
        case(opcode) is 
            --********************************** SIMALS_OP *********************************--
            when SIMALS_OP =>
                result(31 downto 0) <= FMADD(reg_S3(15 downto 0), reg_S2(15 downto 0), reg_S1(31 downto 0));
                result(63 downto 32) <= FMADD(reg_S3(47 downto 32), reg_S2(47 downto 32), reg_S1(63 downto 32));
            --********************************** SIMAHS_OP *********************************--
            when SIMAHS_OP =>
                result(31 downto 0) <= FMADD(reg_S3(31 downto 16), reg_S2(31 downto 16), reg_S1(31 downto 0));
                result(63 downto 32) <= FMADD(reg_S3(63 downto 48), reg_S2(63 downto 48), reg_S1(63 downto 32));
            --********************************** SIMSLS_OP *********************************--
            when SIMSLS_OP =>
                result(31 downto 0) <= FMSUB(reg_S3(15 downto 0), reg_S2(15 downto 0), reg_S1(31 downto 0));
                result(63 downto 32) <= FMSUB(reg_S3(47 downto 32), reg_S2(47 downto 32), reg_S1(63 downto 32));
            --********************************** SIMSHS_OP *********************************--
            when SIMSHS_OP =>
                result(31 downto 0) <= FMSUB(reg_S3(31 downto 16), reg_S2(31 downto 16), reg_S1(31 downto 0));
                result(63 downto 32) <= FMSUB(reg_S3(63 downto 48), reg_S2(63 downto 48), reg_S1(63 downto 32));
            when others => result <= (others => '0');
        end case;
    end process ALU_proc;
end Behavioral;
