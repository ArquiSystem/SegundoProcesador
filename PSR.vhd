----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:33:18 10/15/2017 
-- Design Name: 
-- Module Name:    PSR - Behavioral 
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

entity PSR is
    Port ( clk : in  STD_LOGIC;
           nzvc : in  STD_LOGIC_VECTOR (3 downto 0);
           rst : in  STD_LOGIC;
           ncwp : in  STD_LOGIC_VECTOR(0 downto 0);
           cwp : out  STD_LOGIC_VECTOR(0 downto 0);
           c : out  STD_LOGIC_VECTOR(0 downto 0));
end PSR;

architecture Behavioral of PSR is

signal psregister: std_logic_vector(4 downto 0):= (others =>'0') ;

begin
	c(0) <= psregister(1);
	cwp(0) <= psregister(0);
	process(clk,psregister,rst,ncwp,nzvc)
	begin
	if rst = '1' then
			psregister <= (others => '0');
	else
		if (rising_edge(clk))then
			psregister(0) <= ncwp(0);
			psregister (4 downto 1) <= nzvc;
		end if;
	end if;
	end process;

end Behavioral;

