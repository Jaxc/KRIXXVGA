------------------------------------------------------------------------------
--  This file is a part of the GRLIB VHDL IP LIBRARY
--  Copyright (C) 2003 - 2008, Gaisler Research
--  Copyright (C) 2008 - 2014, Aeroflex Gaisler
--
--  This program is free software; you can redistribute it and/or modify
--  it under the terms of the GNU General Public License as published by
--  the Free Software Foundation; either version 2 of the License, or
--  (at your option) any later version.
--
--  This program is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  GNU General Public License for more details.
--
--  You should have received a copy of the GNU General Public License
--  along with this program; if not, write to the Free Software
--  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA 
-----------------------------------------------------------------------------
-- Package:     charrom_package
-- File:        charrom_package.vhd
-- Author:      Marcus Hellqvist
-- Description: Charrom types and component
-----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
--library grlib;
--use grlib.stdlib.all;

package charrom_package is

type rom_type is record
 addr           : std_logic_vector(11 downto 0);
 data           : std_logic_vector(7 downto 0);
end record;

component charrom_old
  port(
    clk         : in std_ulogic;
    addr        : in std_logic_vector(11 downto 0);
    data        : out std_logic_vector(7 downto 0)
    );
end component;

COMPONENT CHARROM
  PORT (
    clka : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END COMPONENT;

constant col_pixels : integer := 640;
constant row_pixels : integer := 480;
constant pix_per_char : integer := 8;
constant lines_per_char	: integer := 16;
constant char_per_line : integer := col_pixels/pix_per_char;
constant lines_per_screen : integer := row_pixels/lines_per_char;
--type message_array : STD_LOGIC_VECTOR(col_pixels-1 downto 0);

type message_array is array (0 to char_per_line) of STD_LOGIC_VECTOR(0 to 7);
type data_array is array (0 to lines_per_screen) of message_array;



end package;
