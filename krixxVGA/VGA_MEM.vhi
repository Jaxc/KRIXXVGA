
-- VHDL Instantiation Created from source file VGA_MEM.vhd -- 22:05:52 04/04/2015
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT VGA_MEM
	PORT(
		clk : IN std_logic;
		rstn : IN std_logic;
		row_cnt : IN std_logic_vector(10 downto 0);
		col_cnt : IN std_logic_vector(9 downto 0);
		data_in : IN std_logic_vector(0 to 80);
		data_in_valid : IN std_logic;          
		VGA_out : OUT std_logic
		);
	END COMPONENT;

	Inst_VGA_MEM: VGA_MEM PORT MAP(
		clk => ,
		rstn => ,
		row_cnt => ,
		col_cnt => ,
		data_in => ,
		data_in_valid => ,
		VGA_out => 
	);


