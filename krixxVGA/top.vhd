----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:20:12 04/04/2015 
-- Design Name: 
-- Module Name:    top - Behavioral 
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

library work;
use work.charrom_package.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    Port ( clk_100 : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  psh : in STD_LOGIC_VECTOR(1 downto 0);
			  btn_in : in STD_LOGIC_VECTOR(7 downto 0);
			  VGA_hsync : OUT std_logic;
			  VGA_vsync : OUT std_logic;
			  VGA_Red : OUT std_logic;
			  VGA_Blue : OUT std_logic;
			  VGA_Green : OUT std_logic;
			  vsync2		: out std_logic;
			  led			: out STD_logic_vector(6 downto 0);
           VGA_out : out  STD_LOGIC_VECTOR (2 downto 0);
			  
			  
			  
			  
			  IRQ	: in STD_LOGIC;
			  MISO	: IN STD_LOGIC;
			  MOSI	: OUT STD_LOGIC;
			  SCLK	: OUT STD_LOGIC;
			  CS	: OUT STD_LOGIC
			  
			  );
end top;

architecture Behavioral of top is

	signal vsync_int : std_logic;
	signal clk : std_logic;
	signal rstn : std_logic;
	signal data_in : STD_LOGIC_VECTOR(col_pixels-1 downto 0);
	signal data_in_Valid : std_logic;
	signal data_in_cnt : integer range 0 to char_per_line;
	
		COMPONENT clk_div
	PORT(
		CLKIN_IN : IN std_logic;
		RST_IN : IN std_logic;          
		CLKIN_IBUFG_OUT : OUT std_logic;
		CLK0_OUT : OUT std_logic;
		LOCKED_OUT : OUT std_logic
		);
	END COMPONENT;
	
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
	
	component clk_man
port
 (-- Clock in ports
  CLK_IN1           : in     std_logic;
  -- Clock out ports
  CLK_OUT1          : out    std_logic;
  -- Status and control signals
  RESET             : in     std_logic;
  LOCKED            : out    std_logic
 );
end component;
	
	COMPONENT VGA_MEM
	PORT(
		clk : IN std_logic;
		rst_n : IN std_logic;
		data_in : IN std_logic_vector(7 downto 0);          
		VGA_out : OUT std_logic_vector(2 downto 0)
		);
	END COMPONENT;
	
	COMPONENT VGA_cont
	PORT(
		clk : IN std_logic;
		rstn : IN std_logic;
		vga_in : IN std_logic_vector(7 downto 0);
		data_in : IN STD_LOGIC_VECTOR(col_pixels-1 downto 0);
		data_in_Valid : IN std_logic;          
		VGA_hsync : OUT std_logic;
		VGA_vsync : OUT std_logic;
		VGA_Red : OUT std_logic;
		VGA_Blue : OUT std_logic;
		VGA_Green : OUT std_logic;
		DEBUG : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
begin
--

	
		Inst_VGA_cont: VGA_cont PORT MAP(
		clk => clk,
		rstn => rstn,
		vga_in => btn_in,
		VGA_hsync => VGA_hsync,
		VGA_vsync => vsync_int,
		data_in 	=> data_in,
		data_in_valid => data_in_valid,
		DEBUG		=> led (6 downto 3),
		VGA_Red => VGA_red,
		VGA_Blue => VGA_blue,
		VGA_Green => VGA_green 
	);
	
	
--		Inst_clk_div: clk_div PORT MAP(
--		CLKIN_IN => clk_100,
--		RST_IN => rst,
--		CLKIN_IBUFG_OUT => open,
--		CLK0_OUT => clk,
--		LOCKED_OUT => led(0)
--	);
	
	inst_clk_man : clk_man
  port map
   (-- Clock in ports
    CLK_IN1 => clk_100,
    -- Clock out ports
    CLK_OUT1 => clk,
    -- Status and control signals
    RESET  => rst,
    LOCKED => led(0));
--	
		Inst_spi_cont: spi_cont PORT MAP(
		clk => clk,
		rstn => rstn,
		IRQ => IRQ,
		MISO => MISO,
		MOSI => MOSI,
		SCLK => SCLK,
		CS => CS
	);

process(clk,rstn)
begin
	if rstn = '0' then
		data_in_valid <= '0';
		data_in_cnt <= 0;
		data_in <= (others => '0');
	elsif rising_edge(clk) then

		if psh(1) = '1' then
			Data_in_valid <= '1';
			data_in_cnt <= 0;
		elsif psh(0) = '1' then
			data_in(8*(data_in_cnt+1)-1 downto 8*data_in_cnt) <= btn_in;
			data_in_cnt <= data_in_cnt + 1;
		else
			data_in_valid <= '0';
		end if;
	end if;
end process;

rstn <= not rst;
led(1) <= rst;
led(2) <= vsync_int;
vsync2 <= '0';
vga_vsync <= vsync_int;
end Behavioral;
