--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:24:33 10/19/2017
-- Design Name:   
-- Module Name:   C:/Users/Daniel/Documents/Arquitectura/Primerprocesador1/ALU_TB.vhd
-- Project Name:  Primerprocesador1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY ALU_TB IS
END ALU_TB;
 
ARCHITECTURE behavior OF ALU_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         DATA_I : IN  std_logic_vector(31 downto 0);
         DATA_II : IN  std_logic_vector(31 downto 0);
         SELEC : IN  std_logic_vector(5 downto 0);
         C : IN  std_logic_vector(0 downto 0);
         RESULT : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal DATA_I : std_logic_vector(31 downto 0) := (others => '0');
   signal DATA_II : std_logic_vector(31 downto 0) := (others => '0');
   signal SELEC : std_logic_vector(5 downto 0) := (others => '0');
   signal C : std_logic_vector(0 downto 0) := (others => '0');

 	--Outputs
   signal RESULT : std_logic_vector(31 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          DATA_I => DATA_I,
          DATA_II => DATA_II,
          SELEC => SELEC,
          C => C,
          RESULT => RESULT
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      DATA_I<=  "00000000000000000000000000001000";
		DATA_II<= "11111111111111111111111111111001";
		SELEC<= "000000";
		C<="0";
		wait for 10 ns;
		
		DATA_I<="00000000000000000000000000001000";
		DATA_II<="00000000000000000000000000000001";
		SELEC<="100110";
		C<="0";
		wait for 10 ns;
		
		DATA_I<="00000000000000000000000000001000";
		DATA_II<="00000000000000000000000000000001";
		SELEC<="001100";
		C<="1";
      wait for 10 ns; 

      wait;
   end process;

END;
