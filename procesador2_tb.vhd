--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:40:38 10/19/2017
-- Design Name:   
-- Module Name:   C:/Users/Daniel/Documents/Arquitectura/Primerprocesador1/procesador2_tb.vhd
-- Project Name:  Primerprocesador1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Procesador1
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
 
ENTITY procesador2_tb IS
END procesador2_tb;
 
ARCHITECTURE behavior OF procesador2_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Procesador1
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         ALUresult : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal ALUresult : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Procesador1 PORT MAP (
          clk => clk,
          rst => rst,
          ALUresult => ALUresult
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		rst <= '1';
      wait for 100 ns;
		rst <= '0';

      -- insert stimulus here 

      wait;
   end process;

END;
