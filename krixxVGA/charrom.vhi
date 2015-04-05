
-- VHDL Instantiation Created from source file charrom.vhd -- 14:11:27 04/04/2015
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT charrom
	PORT(
		clk : IN std_logic;
		addr : IN std_logic_vector(11 downto 0);          
		data : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

	Inst_charrom: charrom PORT MAP(
		clk => ,
		addr => ,
		data => 
	);


