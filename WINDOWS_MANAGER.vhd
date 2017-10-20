----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:31:33 10/15/2017 
-- Design Name: 
-- Module Name:    WINDOWS_MANAGER - Behavioral 
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

entity WINDOWS_MANAGER is
    Port ( RS1 : in  STD_LOGIC_VECTOR (4 downto 0);
           RS2 : in  STD_LOGIC_VECTOR (4 downto 0);
           RD : in  STD_LOGIC_VECTOR (4 downto 0);
           CWP : in  STD_LOGIC_VECTOR (0 downto 0);
           OP : in  STD_LOGIC_VECTOR (1 downto 0);
           OP3 : in  STD_LOGIC_VECTOR (5 downto 0);
           NCWP : out  STD_LOGIC_VECTOR (0 downto 0);
           nRS1 : out  STD_LOGIC_VECTOR (5 downto 0);
			  nRS2 : out  STD_LOGIC_VECTOR (5 downto 0);
			  nRD : out  STD_LOGIC_VECTOR (5 downto 0));
end WINDOWS_MANAGER;

architecture Behavioral of WINDOWS_MANAGER is

begin
process(RS1,RS2,RD,CWP,OP,OP3)
begin
 --                          save              restore
	if not (OP="10" AND ((OP3 = "111100") or (OP3 = "111101")))then
		if RS1>="11000" and RS1<="11111" then -- 24 - 31
			nRS1<= RS1-(CWP*"10000");
		end if;
		if (RS1>="10000" and RS1<="10111")or(RS1>="01000" and RS1<="01111") then -- 8 - 23
			nRS1 <= RS1+(CWP*"10000");
		end if;
		if RS1 >= "00000" and  RS1 <= "00111" then -- 0 - 7
			nRS1 <= '0' & RS1;
		end if;
		
		if RS2>="11000" and RS2<="11111" then -- 24 - 31
			nRS2<=RS2-(CWP*"10000");
		end if;
		if (RS2>="10000" and RS2<="10111")or(RS2>="01000" and RS2<="01111") then -- 8 - 23
			nRS2 <= RS2+(CWP*"10000");
		end if;
		if RS2>="00000" and  RS2 <= "00111" then -- 0 - 7
			nRS2 <= '0' & RS2;
		end if;
		
		if RD>="11000" and RD<="11111" then -- 24 - 31
			nRD<=RD-(CWP*"10000");
		end if;
		if (RD>="10000" and RD<="10111")or(RD>="01000" and RD<="01111") then -- 8 - 23
			nRD <= RD+(CWP*"10000");
		end if;
		if RD>="00000" and  RD <= "00111" then -- 0 - 7
			nRD <= '0' & RD;
		end if;
		nCWP<=CWP;
	else
		if OP3 = "111100" then -- save
			nCWP <= CWP - 1;
		end if;
		if OP3 = "111101" then -- restore
			nCWP <= CWP + 1;
		end if;
		nRS1 <= "000000";
		nRS2 <= "000000";
		nRD <= "000000";
	end if;

end process;

end Behavioral;

