
-- VHDL Instantiation Created from source file VGA_cont.vhd -- 22:26:46 04/04/2015
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT VGA_cont
	PORT(
		clk : IN std_logic;
		rstn : IN std_logic;
		vga_in : IN std_logic_vector(7 downto 0);
		data_in : IN std_logic_vector(0 to 80);
		data_in_Valid : IN std_logic;          
		VGA_hsync : OUT std_logic;
		VGA_vsync : OUT std_logic;
		VGA_Red : OUT std_logic;
		VGA_Blue : OUT std_logic;
		VGA_Green : OUT std_logic;
		DEBUG : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;

	Inst_VGA_cont: VGA_cont PORT MAP(
		clk => ,
		rstn => ,
		vga_in => ,
		data_in => ,
		data_in_Valid => ,
		VGA_hsync => ,
		VGA_vsync => ,
		VGA_Red => ,
		VGA_Blue => ,
		VGA_Green => ,
		DEBUG => 
	);


