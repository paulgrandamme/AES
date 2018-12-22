library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

library AESLibrary;
use AESLibrary.state_definition_package.all;

library lib_sources;
use lib_sources.all;

entity InvMCColumn is
	port(
		colonne_i : in column_state;
		colonne_o : out column_state);
end entity;

architecture InvMCColumn_arch of InvMCColumn is
signal colonne2_s : column_state;
signal colonne4_s : column_state;
signal colonne8_s : column_state;
signal colonne9_s : column_state;
signal colonne11_s : column_state;
signal colonne13_s : column_state;
signal colonne14_s : column_state;

begin
	Mulpar2 : for i in 0 to 3 generate
	colonne2_s(i) <= colonne_i(i)(6 downto 0)&'0' xor "000"&colonne_i(i)(7)&colonne_i(i)(7)&'0'&colonne_i(i)(7)&colonne_i(i)(7);
	end generate Mulpar2;

	Mulpar4 : for i in 0 to 3 generate
	colonne4_s(i) <= colonne2_s(i)(6 downto 0)&'0' xor "000"&colonne2_s(i)(7)&colonne2_s(i)(7)&'0'&colonne2_s(i)(7)&colonne2_s(i)(7);
	end generate Mulpar4;

	Mulpar8 : for i in  0 to 3 generate
	colonne8_s(i) <= colonne4_s(i)(6 downto 0)&'0' xor "000"&colonne4_s(i)(7)&colonne4_s(i)(7)&'0'&colonne4_s(i)(7)&colonne4_s(i)(7);
	end generate Mulpar8;

	Mulpar9 : for i in 0 to 3 generate
	colonne9_s(i) <= colonne8_s(i) xor colonne_i(i);
	end generate Mulpar9;

	Mulpar11 : for i in 0 to 3 generate
	colonne11_s(i) <= colonne8_s(i) xor colonne2_s(i) xor colonne_i(i);
	end generate Mulpar11;

	Mulpar13 : for i in 0 to 3 generate
	colonne13_s(i) <= colonne8_s(i) xor colonne4_s(i) xor colonne_i(i);
	end generate Mulpar13;

	Mulpar14 : for i in 0 to 3 generate
	colonne14_s(i) <= colonne8_s(i) xor colonne4_s(i) xor colonne2_s(i);
	end generate Mulpar14;

	colonne_o(0) <= colonne14_s(0) xor colonne11_s(1) xor colonne13_s(2) xor colonne9_s(3);
	colonne_o(1) <= colonne9_s(0) xor colonne14_s(1) xor colonne11_s(2) xor colonne13_s(3);
	colonne_o(2) <= colonne13_s(0) xor colonne9_s(1) xor colonne14_s(2) xor colonne11_s(3);
	colonne_o(3) <= colonne11_s(0) xor colonne13_s(1) xor colonne9_s(2) xor colonne14_s(3);

end architecture InvMCColumn_arch;
