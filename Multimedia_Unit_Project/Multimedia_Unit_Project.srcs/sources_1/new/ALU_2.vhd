----------------------------------------------------------------------------------
-- Engineer(s): Wilmer Suarez, Himanshu Goel
-- 
-- Create Date: 11/03/2017 10:02:18 PM
-- Design Name: Multimedia_ALU_2
-- Module Name: multimedia_ALU_2 - Behavioral
-- Project Name: Multimedia Processor
-- Target Devices: 
-- Tool Versions: Vivado 2017.3
-- Description: 
-- 
-- Dependencies: 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity multimedia_ALU_2 is
    Port (
          opcode : in std_logic_vector(1 downto 0);      
          reg_S1 : in std_logic_vector(63 downto 0);
          reg_S2 : in std_logic_vector(63 downto 0);
          reg_S3 : in std_logic_vector(63 downto 0);
          result : out std_logic_vector(63 downto 0)
          );
end multimedia_ALU_2;

architecture Behavioral of multimedia_ALU_2 is
--******************** OP_CODE_VALUES ********************--
constant SIMALS_OP : STD_LOGIC_VECTOR(1 downto 0) := "00"; -- Signed integer multiple-add low with saturation
constant SIMAHS_OP : STD_LOGIC_VECTOR(1 downto 0) := "01"; -- Signed integer multiple-add high with saturation
constant SIMSLS_OP : STD_LOGIC_VECTOR(1 downto 0) := "10"; -- Signed integer multiple-subtract low with saturation
constant SIMSHS_OP : STD_LOGIC_VECTOR(1 downto 0) := "11"; -- Signed integer multiple-subtract high with saturation
begin
    --********************************** ALU_PROCESS *********************************--
    ALU_proc: process(opcode) is
        variable multiplicand : integer := 0;
        variable multiplier : integer := 0;
        variable product : integer := 0;
        variable final_result : integer := 0;
    begin
        case(opcode) is 
            --********************************** SIMALS_OP *********************************--
            when SIMALS_OP =>
                multiplicand := to_integer(signed(reg_S3(15 downto 0)));
                multiplier := to_integer(signed(reg_S2(15 downto 0)));
                product := multiplicand * multiplier;
                final_result := product + (to_integer(signed(reg_S1(31 downto 0))));
                if(final_result > (2**31-1)) then
                    result(31 downto 0) <= std_logic_vector(to_signed(2**31-1, 32));
                else 
                    result(31 downto 0) <= std_logic_vector(to_signed(final_result, 32));
                end if; 
                multiplicand := to_integer(signed(reg_S3(47 downto 32)));
                multiplier := to_integer(signed(reg_S2(47 downto 32)));
                product := multiplicand * multiplier;
                final_result := product + (to_integer(signed(reg_S1(63 downto 32))));
                if(final_result > (2**31-1)) then
                    result(63 downto 32) <= std_logic_vector(to_signed(2**31-1, 32));
                else 
                    result(63 downto 32) <= std_logic_vector(to_signed(final_result, 32));
                end if;
            --********************************** SIMAHS_OP *********************************--
            when SIMAHS_OP =>
                multiplicand := to_integer(signed(reg_S3(31 downto 16)));
                multiplier := to_integer(signed(reg_S2(31 downto 16)));
                product := multiplicand * multiplier;
                final_result := product + (to_integer(signed(reg_S1(31 downto 0))));
                if(final_result > (2**31-1)) then
                    result(31 downto 0) <= std_logic_vector(to_signed(2**31-1, 32));
                else 
                    result(31 downto 0) <= std_logic_vector(to_signed(final_result, 32));
                end if; 
                multiplicand := to_integer(signed(reg_S3(63 downto 48)));
                multiplier := to_integer(signed(reg_S2(63 downto 48)));
                product := multiplicand * multiplier;
                final_result := product + (to_integer(signed(reg_S1(63 downto 32))));
                if(final_result > (2**31-1)) then
                    result(63 downto 32) <= std_logic_vector(to_signed(2**31-1, 32));
                else 
                    result(63 downto 32) <= std_logic_vector(to_signed(final_result, 32));
                end if;
            --********************************** SIMSLS_OP *********************************--
            when SIMSLS_OP =>
            
            --********************************** SIMSHS_OP *********************************--
            when SIMSHS_OP =>
            
        end case;
    end process ALU_proc;
end Behavioral;
