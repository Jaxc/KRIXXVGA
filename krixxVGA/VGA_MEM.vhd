----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:43:53 04/03/2015 
-- Design Name: 
-- Module Name:    VGA_MEM - Behavioral 
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
use IEEE.numeric_STD.all;

library work;
use work.charrom_package.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity VGA_MEM is
	port(
			clk 				: 	in STD_LOGIC;
			rstn 				:	in STD_LOGIC;
			col_cnt 			:	in STD_LOGIC_VECTOR(9 downto 0);
			row_cnt  		:	in STD_LOGIC_VECTOR(8 downto 0);
			row_char 		: 	IN std_logic_Vector(3 downto 0);
			col_Char 		: 	IN std_logic_vector(2 downto 0);
			data_in			: 	in STD_LOGIC_VECTOR(col_pixels-1 downto 0);
			data_in_valid 	:  in std_logic;
			VGA_out  		:  out  STD_LOGIC);
			
end VGA_MEM;

architecture Behavioral of VGA_MEM is





signal ram : data_array;

signal addr : std_logic_vector(11 downto 0);
signal data_out : std_logic_vector(0 to pix_per_char - 1);
signal crnt_row : integer range 0 to lines_per_screen;
signal crnt_col : integer range 0 to pix_per_char;
signal addr_int : STD_LOGIC_VECTOR(7 downto 0);
begin

addr_int <= ram(crnt_row)(8*crnt_col to (8*(crnt_col+1))-1);
addr <= row_char(3 downto 0) & addr_int;

VGA_out <= data_out(crnt_col);


process(rstn,clk)
begin
	if rstn = '0' then
		ram <= (others => (others => '0'));
	elsif rising_Edge(clk) then
		if data_in_Valid = '1' then 
			for i in 0 to lines_per_Screen -1 loop
				ram(i) <= ram(i+1);
			end loop;
			
			ram(lines_per_Screen) <= data_in;
		end if;
		
		--if to_integer(unsigned(row_cnt)) < 60 then
			crnt_row <= to_integer(unsigned(row_cnt));
	--	end if;
		
		--if to_integer(unsigned(col_cnt)) < 80 then
			crnt_col <= to_integer(unsigned(col_char));
		--end if;
	end if;
end process;


inst_charrom : CHARROM_old
  PORT MAP (
    clk => clk,
    addr => addr,
    data => data_out  );

end Behavioral;

