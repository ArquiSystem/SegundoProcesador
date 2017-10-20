----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:25:15 10/15/2017 
-- Design Name: 
-- Module Name:    PSR_MODIFIER - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PSR_MODIFIER is
	Port( CRS1 : in  STD_LOGIC_VECTOR (31 downto 0);
         CRS2 : in  STD_LOGIC_VECTOR (31 downto 0);
			ALU_RESULT: in STD_LOGIC_VECTOR (31 downto 0);
			ALU_OP: in STD_LOGIC_VECTOR(5 downto 0);
			NZVC: out STD_LOGIC_VECTOR(3 downto 0):="0000");
end PSR_MODIFIER;

architecture Behavioral of PSR_MODIFIER is

begin
process(CRS1,CRS2,ALU_RESULT,ALU_OP)
	begin
	if(ALU_OP="010000" or ALU_OP="011000")then --addcc and addxcc
		NZVC(3)<=ALU_RESULT(31);
	if ALU_RESULT = "00000000000000000000000000000000" then
		NZVC(2)<='1';
	else
		NZVC(2)<='0';
	end if;
		NZVC(1)<= ((CRS1(31) and CRS2(31) and (not ALU_RESULT(31)))OR((not CRS1(31)) AND (not CRS2(31)) AND ALU_RESULT(31)));
		NZVC(0)<=(CRS1(31) and CRS2(31)) or ((not ALU_RESULT(31)) and (CRS1(31) or CRS2(31)));
	end if;
	if(ALU_OP="011100" OR ALU_OP="010100")then --subcc and subxcc
		NZVC(3)<=ALU_RESULT(31);
	if ALU_RESULT = "00000000000000000000000000000000" then
		NZVC(2)<='1';
	else
		NZVC(2)<='0';
	end if;
		NZVC(1)<=((CRS1(31) and (NOT CRS2(31)) and (not ALU_RESULT(31)))OR((not CRS1(31)) AND CRS2(31) AND ALU_RESULT(31)));
		NZVC(0)<=((NOT CRS1(31)) and CRS2(31)) or (ALU_RESULT(31) and ((NOT CRS1(31)) or CRS2(31)));
	end if;
	--    ANDCC           ANDNCC              ORCC                 ORNCC              XORCC               XNORCC
	if(ALU_OP="010001"OR ALU_OP="010101" OR ALU_OP="010010" OR ALU_OP="010110"OR ALU_OP="010011" OR ALU_OP="010111")then
	NZVC(3)<=ALU_RESULT(31);
	if ALU_RESULT = "00000000000000000000000000000000" then
		NZVC(2)<='1';
	else
		NZVC(2)<='0';
	end if;
		NZVC(1)<='0';
		NZVC(0)<='0';
	end if;
	
end process;
end Behavioral;

