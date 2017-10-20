library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity Register_file is
    Port ( rs1 : in  STD_LOGIC_VECTOR (5 downto 0);
           rs2 : in  STD_LOGIC_VECTOR (5 downto 0);
           rd : in  STD_LOGIC_VECTOR (5 downto 0);
           rst : in  STD_LOGIC;
           dwr : in  STD_LOGIC_VECTOR (31 downto 0);
           crs1 : out  STD_LOGIC_VECTOR (31 downto 0);
           crs2 : out  STD_LOGIC_VECTOR (31 downto 0));
end Register_file;

architecture Behavioral of Register_file is

type ram_type is array (0 to 39) of std_logic_vector (31 downto 0); 
			
	 signal RAM: ram_type := (	"00000000000000000000000000000000",
										"00000000000000000000000000001111",
										"00000000000000000000000000000011",
										others => "00000000000000000000000000000000");
	 
begin
	
	process(rst,rs1,rs2,rd,dwr,RAM)
	begin
	if rst = '1' then
		RAM <= (others => "00000000000000000000000000000000");
		crs1 <= (others =>'0');
		crs2 <= (others =>'0');
	else
		crs1 <= RAM(conv_integer(rs1));
		crs2 <= RAM(conv_integer(rs2));
		if rd /= "000000" then
			RAM(conv_integer(rd)) <= dwr;
		end if;
	end if;
	end process;
end Behavioral;