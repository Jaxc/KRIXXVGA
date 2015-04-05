----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:22:59 04/04/2015 
-- Design Name: 
-- Module Name:    VGA_cont - Behavioral 
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
use IEEE.numeric_std.all;

library work;
use work.charrom_package.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity VGA_cont is
    Port ( clk : in  STD_LOGIC;
           rstn : in  STD_LOGIC;
			  vga_in : in STD_LOGIC_VECTOR(7 downto 0);
			  data_in	: in STD_LOGIC_VECTOR(col_pixels-1 downto 0);
			  data_in_Valid : in std_logic;
           VGA_hsync : out  STD_LOGIC;
           VGA_vsync : out  STD_LOGIC;
           VGA_Red : out  STD_LOGIC;
           VGA_Blue : out  STD_LOGIC;
           VGA_Green : out  STD_LOGIC;
			  DEBUG		: out STD_LOGIC_VECTOR(3 downto 0));
end VGA_cont;

architecture Behavioral of VGA_cont is


type statetype is (Display,front,back,pulse);

type reg2 is record
	state : statetype;
	cnt 	: natural;
	pix_cnt : natural range 0 to char_per_line;
end record;

type reg is record
	v : reg2;
	h : reg2;
end record;

signal crnt,nxt : reg;

signal vga_out : std_logic;

signal row_cnt : std_logic_vector(8 downto 0);
signal col_cnt : std_logic_vector(9 downto 0);

signal row_char : std_logic_Vector(3 downto 0);
signal col_Char : std_logic_vector(2 downto 0);
--procedure inc_v_cnt (crnt : in reg; nxt : out reg) is
--begin
--	nxt.v.cnt <= crnt.v.cnt + 1;
--end inc_v_cnt;
--
--procedure inc_h_cnt (crnt : in reg; nxt : out reg) is
--begin
--	nxt.h.cnt <= crnt.h.cnt + 1;
--end inc_h_cnt;

	COMPONENT VGA_MEM
	PORT(
		clk : IN std_logic;
		rstn : IN std_logic;
		col_cnt : IN std_logic_vector(9 downto 0);
		row_cnt : IN std_logic_vector(8 downto 0);
		row_char : IN std_logic_Vector(3 downto 0);
		col_Char : IN std_logic_vector(2 downto 0);
		data_in : IN STD_LOGIC_VECTOR(col_pixels-1 downto 0);
		data_in_valid : IN std_logic;          
		VGA_out : OUT std_logic
		);
	END COMPONENT;

begin

row_cnt <= std_logic_vector(to_unsigned(crnt.v.cnt / lines_per_Screen,9));
col_cnt <= std_logic_vector(to_unsigned(crnt.h.cnt / pix_per_char,10));

row_char <= std_logic_vector(to_unsigned(crnt.v.pix_cnt,4));
col_char <= std_logic_vector(to_unsigned(crnt.h.pix_cnt,3));


	Inst_VGA_MEM: VGA_MEM PORT MAP(
		clk => clk,
		rstn => rstn,
		data_in => data_in,
		row_cnt => row_cnt,
		col_cnt => col_cnt,
		row_char => row_char,
		col_char => col_char,
		data_in_valid => data_in_Valid,
		VGA_out => VGA_out
	);

process(crnt)


begin
	nxt.v.cnt <= crnt.v.cnt;
	nxt.h.cnt <= crnt.h.cnt;
	nxt.v.state <= crnt.v.state;
	nxt.h.state <= crnt.h.state;
	nxt.v.pix_cnt <= crnt.v.pix_cnt;
	nxt.h.pix_cnt <= 0;
	case crnt.v.state is
	
	when pulse =>
		if crnt.v.cnt = 2 then
			nxt.v.state <= front;
			nxt.v.cnt <= 0;
		end if;
		debug <= "0001";
		nxt.v.pix_cnt <= 0;
	when front =>
		if crnt.v.cnt = 10 then
			nxt.v.state <= display;
			nxt.v.cnt <= 0;
		end if;
		debug <= "0010";
		nxt.v.pix_cnt <= 0;
	when display =>
		if crnt.v.cnt = row_pixels-1 then
			nxt.v.state <= back;
			nxt.v.cnt <= 0;
		end if;
	debug <= "0011";
		if crnt.v.pix_cnt = lines_per_char then
			nxt.v.pix_cnt <= 0;
		end if;
	
	when back =>
			if crnt.v.cnt = 29 then
				nxt.v.state <= pulse;
				nxt.v.cnt <= 0;
			end if;
			debug <= "0100";
	end case;
	

	case crnt.h.state is 
	
	when pulse =>
		if crnt.h.cnt = 95 then
			nxt.h.state <= front;
			nxt.h.cnt <= 0;
		else
			nxt.h.cnt <= crnt.h.cnt + 1;
		end if;
		
	when front =>
			if crnt.h.cnt = 15 then
				nxt.h.state <= display;
				nxt.h.cnt <= 0;
			else
				nxt.h.cnt <= crnt.h.cnt + 1;
			end if;
		
	when display =>
		if crnt.h.cnt = col_pixels-1 then
			nxt.h.state <= back;
			nxt.h.cnt <= 0;
		else
			nxt.h.cnt <= crnt.h.cnt + 1;
		end if;
			
		if crnt.h.pix_cnt = char_per_line - 1 then
			nxt.h.pix_cnt <= 0;
		else
			nxt.h.pix_cnt <= crnt.h.pix_cnt + 1;
		end if;
		
	when back =>
				if crnt.h.cnt = 47 then
					nxt.h.state <= pulse;
					nxt.h.cnt <= 0;
					nxt.v.cnt <= crnt.v.cnt + 1;
					nxt.v.pix_cnt <= crnt.v.pix_cnt + 1;
				else
					nxt.h.cnt <= crnt.h.cnt + 1;
				end if;
				
	end case;
end process;

process(clk, rstn)
begin
	if rstn = '0' then
		crnt.v.state <= pulse;
		crnt.h.state <= pulse;
		crnt.h.cnt <= 0;
		crnt.v.cnt <= 0;
		VGA_hsync <= '0';
		VGA_vsync <= '0';
		crnt.v.pix_cnt <= 0;
		crnt.h.pix_cnt <= 0;
	elsif rising_edge(clk) then
		crnt <= nxt;

		if crnt.v.state = pulse then
			VGA_vsync <= '0';
		else
			VGA_vsync <= '1';
		end if;
		
		
			if crnt.h.state = pulse then
				VGA_hsync <= '0';
				VGA_red <= '0';
				VGA_blue <= '0';
				VGA_green <= '0';
			else
				vgA_hsync <= '1'; 
				VGA_red <= vga_out;
				VGA_blue <= vga_out;
				VGA_green <= vga_out;
			end if;
		
	end if;	
end process;


end Behavioral;

