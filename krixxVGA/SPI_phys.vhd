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

entity SPI_phys is
    Port ( 
		clk 	: IN STD_LOGIC;
		rstn	: IN STD_LOGIC;
		SPI_CLK	: IN STD_LOGIC;

		transmit: IN STD_LOGIC;
		Byteout	: in STD_LOGIC_VECTOR(7 downto 0);
		Bytein	: OUT STD_LOGIC_VECTOR(7 downto 0);
		Bytedone: OUT STD_LOGIC;
		

		
		MISO	: IN STD_LOGIC;
		MOSI	: OUT STD_LOGIC;
		SCLK	: OUT STD_LOGIC;
		CS	: OUT STD_LOGIC
		);

end SPI_phys;

architecture Behavioral of SPI_phys is
	signal bit_cnt : integer range 0 to 7;
	alias byteout_rev : STD_LOGIC_VECTOR(0 to 7) is byteout;
begin

process(SPI_CLK,rstn)
begin
	if rstn = '0' then
		bit_cnt <= 0;
		Bytedone <= '0';
		MOSI <= '1';
		Bytein <= (others => '0');
	elsif rising_edge(SPI_CLK) then
		if transmit = '1' then
			if bit_cnt = 7 then
				BYTEdone <= '1';
				bit_cnt <= 0;
			else
				BYTEdone <= '0';
				bit_cnt <= bit_cnt +1;
			end if;
			MOSI <= Byteout_rev(bit_cnt);
			bytein(bit_cnt) <= MISO;
		else
			Bytedone <= '0';
		end if;
	end if;

end process;

SCLK <= spi_clk;

process(SPI_clk)
begin
	if rising_edge(SPI_clk) then
		CS <= not transmit;
	end if;
end process;


end Behavioral;

