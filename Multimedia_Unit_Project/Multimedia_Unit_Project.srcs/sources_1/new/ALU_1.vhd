----------------------------------------------------------------------------------
-- Engineer(s): Wilmer Suarez, Himanshu Goel
-- 
-- Create Date: 11/03/2017 06:46:10 PM
-- Design Name: Multimedia_ALU
-- Module Name: multimedia_ALU - Behavioral
-- Project Name: Multimedia_Processor
-- Tool Versions: Vivado 2017.3
--
-- Description: This Arithmetic Logic Unit executes R3 format instructions.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity multimedia_ALU is    
    Port(
        --***** INPUTS *****--
        opcode : in std_logic_vector(3 downto 0);   -- R3 instruction format Opcode
        reg_S1 : in std_logic_vector(63 downto 0);  -- Register RS1
        reg_S2 : in std_logic_vector(63 downto 0);  -- Register RS2
        reg_S2_instr_field : in std_logic_vector(3 downto 0); -- 4 bit immediate for SHLHI instruction
        --***** OUTPUT *****--
        result : out std_logic_vector(63 downto 0)  -- Final Result to be written back to Register File
    );
end multimedia_ALU;

architecture Behavioral of multimedia_ALU is
--******************** OP_CODE_VALUES ********************--
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
    --********************************** ALU_PROCESS *********************************--
    ALU_proc: process(opcode) is
        variable count : integer := 0;  -- Count variable for POPCNTH_OP and CLZ_OP
        variable minuend : integer := 0; -- Minuend variable for ADBSDB_OP, SFHS_OP, and SFH_OP
        variable subtrahend : integer := 0; -- Subtrahend variable for ADBSDB_OP, SFHS_OP, and SFH_OP
        variable minuend_s : signed(15 downto 0); -- Minuend Saturation variable for AHS_OP 
        variable subtrahend_s : signed(15 downto 0); -- Subtrahend Saturation variable for AHS_OP 
        variable augend : signed(15 downto 0); -- Augend variable for AHS_OP
        variable addend : signed(15 downto 0); -- Addend variable for AHS_OP
        variable multiplicand : integer := 0;   -- Multiplicand variable for MPYU_OP
        variable multiplier : integer := 0; -- Multiplier variable for MPYU_OP
        variable shift_result : integer := 0; -- Shift Result variable for SHLHI_OP

    begin
        case opcode is
                --********************************** BCW_OP *********************************-- 
                when BCW_OP => result <= reg_S1(31 downto 0) & reg_S1(31 downto 0);
                --********************************** AND_OP *********************************--
                when AND_OP => result <= reg_S1 AND reg_S2;
                --********************************** OR_OP **********************************--
                when OR_OP => result <= reg_S1 OR reg_S2;
                --******************************** POPCNTH_OP *******************************--
                when POPCNTH_OP =>
                    for i in 0 to 3 loop
                        count := 0;
                        for j in 0 to 15 loop
                            if  (reg_S1(16*i + j) = '1') then
                                count := count + 1;
                            end if;
                        end loop;
                        result((i+1)*16-1 downto i*16) <= std_logic_vector(to_unsigned(count, 16));
                    end loop; 
                --********************************** CLZ_OP *********************************--   
                when CLZ_OP =>
                    for i in 0 to 1 loop
                        count := 0;
                        for j in 0 to 31 loop
                            if(reg_S1(i*32 + j) = '0') then
                                count := count +  1;
                            else 
                                exit;
                            end if;
                        end loop;
                        result((i+1)*32-1 downto i*32) <= std_logic_vector(to_unsigned(count, 32));
                    end loop;  
                --********************************** ROT_OP *********************************-- 
                when ROT_OP =>
                    count := to_integer(unsigned(reg_S2(5 downto 0)));
                    result <= std_logic_vector(rotate_right(unsigned(reg_S1), count));
                --********************************* SHLHI_OP ********************************--
                when SHLHI_OP =>
                for i in 0 to 3 loop
                    shift_result := to_integer(shift_left(unsigned(reg_S1((i+1)*16-1 downto i*16)), to_integer(unsigned(reg_S2_instr_field))));
                    result((i+1)*16-1 downto i*16) <= std_logic_vector(to_unsigned(shift_result, 16));
                end loop;
                --*********************************** A_OP **********************************--
                when A_OP =>
                for i in 0 to 1 loop
                    minuend := to_integer(unsigned(reg_S1((i+1)*32-1 downto i*32)));
                    subtrahend := to_integer(unsigned(reg_S2((i+1)*32-1 downto i*32)));
                    result((i+1)*32-1 downto i*32) <= std_logic_vector(to_unsigned((minuend + subtrahend), 32));
                end loop;
                --********************************** SFW_OP *********************************--
                when SFW_OP =>
                for i in 0 to 1 loop
                    minuend := to_integer(unsigned(reg_S1((i+1)*32-1 downto i*32)));
                    subtrahend := to_integer(unsigned(reg_S2((i+1)*32-1 downto i*32)));
                    result((i+1)*32-1 downto i*32) <= std_logic_vector(to_unsigned((minuend - subtrahend), 32));
                end loop;
                --********************************** AH_OP **********************************--
                when AH_OP =>
                for i in 0 to 3 loop
                    minuend := to_integer(unsigned(reg_S1((i+1)*16-1 downto i*16)));
                    subtrahend := to_integer(unsigned(reg_S2((i+1)*16-1 downto i*16)));
                    result((i+1)*16-1 downto i*16) <= std_logic_vector(to_unsigned((minuend + subtrahend), 16));
                end loop;
                --********************************** SFH_OP *********************************--
                when SFH_OP =>
                for i in 0 to 3 loop
                    minuend := to_integer(unsigned(reg_S1((i+1)*16-1 downto i*16)));
                    subtrahend := to_integer(unsigned(reg_S2((i+1)*16-1 downto i*16)));
                    result((i+1)*16-1 downto i*16) <= std_logic_vector(to_unsigned((minuend - subtrahend), 16));
                end loop;
                --********************************** AHS_OP *********************************--
                when AHS_OP =>
                    for i in 0 to 3 loop
                        augend := (signed(reg_S1((i+1)*16-1 downto i*16)));
                        addend := (signed(reg_S2((i+1)*16-1 downto i*16)));
                        if((addend + augend) > (2**15-1)) then
                            result((i+1)*16-1 downto i*16) <= std_logic_vector(to_signed(2**15-1, 16));
                        elsif((augend + augend) < (-2**15)) then
                            result((i+1)*16-1 downto i*16) <= std_logic_vector(to_signed(-2**15, 16));
                        else
                            result((i+1)*16-1 downto i*16) <= std_logic_vector((augend + addend));
                        end if;
                    end loop;
                --********************************** SFHS_OP ********************************--
                when SFHS_OP =>
                    for i in 0 to 3 loop
                        minuend_s := (signed(reg_S1((i+1)*16-1 downto i*16)));
                        subtrahend_s := (signed(reg_S2((i+1)*16-1 downto i*16)));
                        if((minuend_s - subtrahend_s) < (-2**15)) then
                            result((i+1)*16-1 downto i*16) <= std_logic_vector(to_signed(-2**15, 16));
                        elsif((minuend_s - subtrahend_s) > (2**15-1)) then
                            result((i+1)*16-1 downto i*16) <= std_logic_vector(to_signed(2**15-1, 16));
                        else 
                            result((i+1)*16-1 downto i*16) <= std_logic_vector((minuend_s - subtrahend_s));
                        end if;
                    end loop;
                --********************************* MPYU_OP *********************************--
                when MPYU_OP => 
                    multiplicand := to_integer(unsigned(reg_S1(15 downto 0)));
                    multiplier := to_integer(unsigned(reg_S2(15 downto 0)));
                        result(31 downto 0) <= std_logic_vector(to_unsigned(multiplicand * multiplier, 32));
                    multiplicand := to_integer(unsigned(reg_S1(47 downto 32)));
                    multiplier := to_integer(unsigned(reg_S2(47 downto 32)));
                        result(63 downto 32) <= std_logic_vector(to_unsigned(multiplicand * multiplier, 32));
                --******************************** ADBSDB_OP ********************************--
                when ADBSDB_OP => 
                    for i in 0 to 7 loop
                        minuend  := to_integer(unsigned(reg_S1((i+1)*8-1 downto i*8)));
                        subtrahend := to_integer(unsigned(reg_S2((i+1)*8-1 downto i*8))); 
                        result((i+1)*8-1 downto i*8) <= std_logic_vector(to_unsigned(abs(minuend - subtrahend), 8));
                    end loop;
                when others => result <= (others => '0');
        end case;
    end process ALU_proc;
end Behavioral;