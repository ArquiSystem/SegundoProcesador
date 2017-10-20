library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Register_mod is
    Port ( data : in  STD_LOGIC_VECTOR (31 downto 0);
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           data_out : out  STD_LOGIC_VECTOR(31 downto 0));
end Register_mod;

architecture Behavioral of Register_mod is

signal regist: std_logic_vector(31 downto 0):=(others=>'0');

begin
	process(clk,rst,regist,data)
	begin
		if rst = '1' then
			data_out <= "00000000000000000000000000000000";
		elsif(clk'event and clk='1')then  
			regist <= data;
		end if;
		data_out <= regist;
	end process;

end Behavioral;

