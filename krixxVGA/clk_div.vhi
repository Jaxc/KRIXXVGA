
-- VHDL Instantiation Created from source file clk_div.vhd -- 17:07:50 04/04/2015
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT clk_div
	PORT(
		CLKIN_IN : IN std_logic;
		RST_IN : IN std_logic;          
		CLKIN_IBUFG_OUT : OUT std_logic;
		CLK0_OUT : OUT std_logic;
		LOCKED_OUT : OUT std_logic
		);
	END COMPONENT;

	Inst_clk_div: clk_div PORT MAP(
		CLKIN_IN => ,
		RST_IN => ,
		CLKIN_IBUFG_OUT => ,
		CLK0_OUT => ,
		LOCKED_OUT => 
	);


