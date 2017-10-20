----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:45:39 09/28/2017 
-- Design Name: 
-- Module Name:    DataPath - Behavioral 
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

entity DataPath is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           instruction : out  STD_LOGIC_VECTOR (31 downto 0));
end DataPath;

architecture Behavioral of DataPath is

COMPONENT suma_module
	PORT(
		data1 : IN std_logic_vector(31 downto 0);
		data2 : IN std_logic_vector(31 downto 0);          
		result : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT Register_mod
	PORT(
		data : IN std_logic_vector(31 downto 0);
		clk : IN std_logic;
		rst : IN std_logic;          
		data_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
		COMPONENT i_memory
	PORT(
		address : IN std_logic_vector(5 downto 0);
		rst : IN std_logic;          
		instruction : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

signal data1: std_logic_vector(31 downto 0):=(others => '0');
signal data2: std_logic_vector(31 downto 0):=(others => '0');
signal dir: std_logic_vector(31 downto 0):=(others => '0');
signal aux: std_logic_vector(5 downto 0):=(others => '0');
begin

	aux(5 downto 0) <= dir(5 downto 0);	


	SUMADOR: suma_module PORT MAP(
		data1 => "00000000000000000000000000000001",
		data2 => data1,
		result => data2
	);
	
	nPC: Register_mod PORT MAP(
		data => data2,
		clk => clk,
		rst => rst,
		data_out => data1
	);
	
	PC: Register_mod PORT MAP(
		data => data1,
		clk => clk,
		rst => rst,
		data_out => dir
	);
	
	IM: i_memory PORT MAP(
		address => aux,
		rst => rst,
		instruction => instruction 
	);

end Behavioral;

