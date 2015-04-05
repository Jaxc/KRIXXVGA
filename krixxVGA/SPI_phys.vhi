
-- VHDL Instantiation Created from source file SPI_phys.vhd -- 21:04:59 04/04/2015
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT SPI_phys
	PORT(
		clk : IN std_logic;
		rstn : IN std_logic;
		SPI_CLK : IN std_logic;
		transmit : IN std_logic;
		Byteout : IN std_logic_vector(7 downto 0);
		MISO : IN std_logic;          
		Bytein : OUT std_logic_vector(7 downto 0);
		Bytedone : OUT std_logic;
		MOSI : OUT std_logic;
		SCLK : OUT std_logic;
		CS : OUT std_logic
		);
	END COMPONENT;

	Inst_SPI_phys: SPI_phys PORT MAP(
		clk => ,
		rstn => ,
		SPI_CLK => ,
		transmit => ,
		Byteout => ,
		Bytein => ,
		Bytedone => ,
		MISO => ,
		MOSI => ,
		SCLK => ,
		CS => 
	);


