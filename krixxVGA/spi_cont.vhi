
-- VHDL Instantiation Created from source file spi_cont.vhd -- 21:05:38 04/04/2015
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT spi_cont
	PORT(
		clk : IN std_logic;
		rstn : IN std_logic;
		IRQ : IN std_logic;
		MISO : IN std_logic;          
		MOSI : OUT std_logic;
		SCLK : OUT std_logic;
		CS : OUT std_logic
		);
	END COMPONENT;

	Inst_spi_cont: spi_cont PORT MAP(
		clk => ,
		rstn => ,
		IRQ => ,
		MISO => ,
		MOSI => ,
		SCLK => ,
		CS => 
	);


