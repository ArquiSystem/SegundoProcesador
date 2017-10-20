----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:02:11 10/17/2017 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( DATA_I : in  std_logic_vector(31 downto 0);
           DATA_II : in  std_logic_vector(31 downto 0);
           SELEC : in  std_logic_vector(5 downto 0);
			  C : in std_logic_vector(0 DOWNTO 0);
			  RESULT	: OUT std_logic_vector(31 DOWNTO 0)
			  );
end ALU;

architecture Behavioral of ALU is
begin
process (SELEC,DATA_I,DATA_II)
begin
   case SELEC is
		-- LOGICAL INSTRUCTIONS	
      when "000001" => RESULT <= DATA_I AND DATA_II;
      when "000101" => RESULT <= DATA_I AND not DATA_II;
      when "000010" => RESULT <=	DATA_I OR DATA_II;
      when "000110" => RESULT <= DATA_I OR not DATA_II;
		when "000011" => RESULT <= DATA_I XOR DATA_II;
		when "000111" => RESULT <= DATA_I XNOR DATA_II;
		-- ADD INSTRUCTIONS
		when "000000" => RESULT <= DATA_I + DATA_II;
		-- SUBTRACT INSTRUCTIONS
		when "000100" => RESULT <= DATA_I - DATA_II;  -- sub
		
		when "010000" => RESULT <= DATA_I + DATA_II; --addcc
		
		when "001000" => RESULT <= DATA_I + DATA_II + C; --addx

		when "011000" => RESULT <= DATA_I + DATA_II + C; --ADXCC 
		
		when "010100" => RESULT <= DATA_I - DATA_II; --subcc
	
		when "001100" => RESULT <= DATA_I - DATA_II - C; --subx
		
		when "011100" => RESULT <= DATA_I - DATA_II - C; --	SUBXCC
		
		when "010001"  => RESULT <= DATA_I AND DATA_II; --andcc
		
		when "010010" => RESULT <= DATA_I OR DATA_II; --orcc
		
		when "010101" => RESULT <= DATA_I AND NOT(DATA_II); --nandcc
		
		when "010110" => RESULT <= DATA_I OR NOT(DATA_II); --norcc
		
		when "010011" => RESULT <= DATA_I XOR DATA_II; --xorcc
		
		when "010111" => RESULT <= DATA_I XNOR DATA_II; --xnorcc
		
		when "100101" => RESULT <=  std_logic_vector(unsigned(DATA_I) SLL to_integer(unsigned(DATA_II))); --shift left logic
		
		when "100110" => RESULT <= std_logic_vector(unsigned(DATA_I) SRL to_integer(unsigned(DATA_II))); --shift right logic
		
		--when "111100" => RESULt 
		
      when others => RESULT <= X"00000000";
   end case;
end process;

end Behavioral;

