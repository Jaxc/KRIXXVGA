----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:54:49 04/18/2014 
-- Design Name: 
-- Module Name:    I2CInterface - Behavioral 
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

entity spi_cont is
    Port (	clk : in std_logic;
		rstn : in std_logic;
		

		
		IRQ	: in STD_LOGIC;
		MISO	: IN STD_LOGIC;
		MOSI	: OUT STD_LOGIC;
		SCLK	: OUT STD_LOGIC;
		CS	: OUT STD_LOGIC
		);
end spi_cont;

architecture Behavioral of spi_cont is

signal clk_div_cnt : integer range 0 to 1;
signal SPI_CLK		: std_logic := '0';
signal transmit		: std_logic;
signal byteout		: std_logic_vector(7 downto 0);
signal Bytein		: std_logic_vector(7 downto 0);
signal bytedone		: std_logic;

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
		
begin

	Inst_SPI_phys: SPI_phys PORT MAP(
		clk => clk,
		rstn => rstn,
		SPI_CLK => SPI_CLK,
		transmit => transmit,
		Byteout => byteout,
		Bytein => bytein,
		Bytedone => bytedone,
		MISO => MISO,
		MOSI => MOSI,
		SCLK => SCLK,
		CS => CS
	);

process(clk,rstn)
begin
	if rstn = '0' then
		clk_div_cnt <= 0;
	elsif rising_edge(clk) then
		if clk_div_cnt = 1 then
			clk_div_cnt <= 0;
			SPI_CLK <= not SPI_CLK;
		else
			clk_div_cnt <= clk_div_cnt + 1;
		end if;
	end if;
end process;

end Behavioral;

