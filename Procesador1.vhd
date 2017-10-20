library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Procesador1 is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           ALUresult : out  STD_LOGIC_VECTOR (31 downto 0));
end Procesador1;

architecture Behavioral of Procesador1 is

COMPONENT DataPath
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;          
		instruction : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT ControlUnit
	PORT(
		op : IN std_logic_vector(1 downto 0);
		op3 : IN std_logic_vector(5 downto 0);          
		ALUOP : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;
	
	COMPONENT Register_file
	PORT(
		rs1 : IN std_logic_vector(5 downto 0);
		rs2 : IN std_logic_vector(5 downto 0);
		rd : IN std_logic_vector(5 downto 0);
		rst : IN std_logic;
		dwr : IN std_logic_vector(31 downto 0);          
		crs1 : OUT std_logic_vector(31 downto 0);
		crs2 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT Mux
	PORT(
		rs2 : IN std_logic_vector(31 downto 0);
		data_SEU : IN std_logic_vector(31 downto 0);
		i : IN std_logic;          
		data_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT seu
	PORT(
		imm : IN std_logic_vector(12 downto 0);          
		data_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT ALU
	PORT(
		DATA_I : IN std_logic_vector(31 downto 0);
		DATA_II : IN std_logic_vector(31 downto 0);
		SELEC : IN std_logic_vector(5 downto 0);
		C : IN std_logic_vector(0 downto 0);          
		RESULT : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT PSR_MODIFIER
	PORT(
		CRS1 : IN std_logic_vector(31 downto 0);
		CRS2 : IN std_logic_vector(31 downto 0);
		ALU_RESULT : IN std_logic_vector(31 downto 0);
		ALU_OP : IN std_logic_vector(5 downto 0);          
		NZVC : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
	
	COMPONENT PSR
	PORT(
		clk : IN std_logic;
		nzvc : IN std_logic_vector(3 downto 0);
		rst : IN std_logic;
		ncwp : in  STD_LOGIC_VECTOR(0 downto 0);
      cwp : out  STD_LOGIC_VECTOR(0 downto 0);
      c : out  STD_LOGIC_VECTOR(0 downto 0)
		);
	END COMPONENT;
	
	COMPONENT WINDOWS_MANAGER
	PORT(
		RS1 : IN std_logic_vector(4 downto 0);
		RS2 : IN std_logic_vector(4 downto 0);
		RD : IN std_logic_vector(4 downto 0);
		CWP : IN std_logic_vector(0 to 0);
		OP : IN std_logic_vector(1 downto 0);
		OP3 : IN std_logic_vector(5 downto 0);          
		NCWP : OUT std_logic_vector(0 to 0);
		nRS1 : OUT std_logic_vector(5 downto 0);
		nRS2 : OUT std_logic_vector(5 downto 0);
		nRD : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;


signal party: std_logic_vector(31 downto 0);
signal Crs1: std_logic_vector(31 downto 0);
signal Crs2: std_logic_vector(31 downto 0);
signal Data_mux : std_logic_vector(31 downto 0);
signal Data_ALU : std_logic_vector(31 downto 0);
signal control_ALU : std_logic_vector(5 downto 0);
signal bi: std_logic_vector(31 downto 0);
--------------//--------------------------- procesador 2
signal NZVC: STD_LOGIC_VECTOR(3 downto 0);
signal nCWP: STD_LOGIC_VECTOR(0 downto 0);
signal CWP: STD_LOGIC_VECTOR(0 downto 0);
signal CARRY: STD_LOGIC_VECTOR(0 downto 0);
signal nRS1: std_logic_vector(5 downto 0);
signal nRS2: std_logic_vector(5 downto 0);
signal nRD: std_logic_vector(5 downto 0);

begin

	Inst_DataPath: DataPath PORT MAP(
		clk => clk,
		rst => rst,
		instruction => party
	);
	
	Inst_ControlUnit: ControlUnit PORT MAP(
		op => party(31 downto 30),
		op3 => party(24 downto 19),
		ALUOP => control_ALU
	);
	
	Inst_Register_file: Register_file PORT MAP(
		rs1 => nRS1,
		rs2 => nRS2,
		rd => nRD,
		rst => rst,
		dwr => bi,
		crs1 => Crs1,
		crs2 => Crs2
	);
	
	Inst_Mux: Mux PORT MAP(
		rs2 => Crs2,
		data_SEU => Data_mux,
		i => party(13),
		data_out => Data_ALU
	);
	
	Inst_seu: seu PORT MAP(
		imm => party(12 downto 0),
		data_out => Data_mux
	);

	Inst_ALU: ALU PORT MAP(
		DATA_I => Crs1,
		DATA_II => Data_ALU,
		SELEC => control_ALU,
		C => CARRY,
		RESULT => bi
	);
	
	Inst_PSR_MODIFIER: PSR_MODIFIER PORT MAP(
		CRS1 => Crs1,
		CRS2 => Data_ALU,
		ALU_RESULT => bi,
		ALU_OP => control_ALU,
		NZVC => NZVC
	);
	
	Inst_PSR: PSR PORT MAP(
		clk => clk,
		nzvc => NZVC,
		rst => rst,
		ncwp => nCWP,
		cwp => CWP,
		c => CARRY
	);
	
	Inst_WINDOWS_MANAGER: WINDOWS_MANAGER PORT MAP(
		RS1 => party(18 downto 14),
		RS2 => party(4 downto 0),
		RD => party(29 downto 25),
		CWP => CWP,
		OP => party(31 downto 30),
		OP3 => party(24 downto 19),
		NCWP => nCWP,
		nRS1 => nRS1,
		nRS2 => nRS2,
		nRD => nRD
	);
	
	ALUresult <= bi;
	
end Behavioral;

