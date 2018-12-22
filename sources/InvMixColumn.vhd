library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

library AESLibrary;
use AESLibrary.state_definition_package.all;

library lib_sources;
use lib_sources.all;

entity InvMixColumn is
	port(
		data_i:in type_state;
		data_o:out type_state);
end entity;
architecture InvMixColumn_arch of InvMixColumn is
	component InvMCColumn
	port(
		colonne_i :in column_state;
		colonne_o :out column_state
	);
end component;

signal colonne0_i_s, colonne1_i_s, colonne2_i_s, colonne3_i_s : column_state;
signal colonne0_o_s, colonne1_o_s, colonne2_o_s, colonne3_o_s : column_state;

begin



colonne0_i_s(0) <= data_i(0)(0);
colonne0_i_s(1) <= data_i(1)(0);
colonne0_i_s(2) <= data_i(2)(0);
colonne0_i_s(3) <= data_i(3)(0);

colonne1_i_s(0) <= data_i(0)(1);
colonne1_i_s(1) <= data_i(1)(1);
colonne1_i_s(2) <= data_i(2)(1);
colonne1_i_s(3) <= data_i(3)(1);

colonne2_i_s(0) <= data_i(0)(2);
colonne2_i_s(1) <= data_i(1)(2);
colonne2_i_s(2) <= data_i(2)(2);
colonne2_i_s(3) <= data_i(3)(2);

colonne3_i_s(0) <= data_i(0)(3);
colonne3_i_s(1) <= data_i(1)(3);
colonne3_i_s(2) <= data_i(2)(3);
colonne3_i_s(3) <= data_i(3)(3);

InvMCColumn0 : InvMCColumn
port map(
	colonne_i => colonne0_i_s,
	colonne_o => colonne0_o_s);
InvMCColumn1 : InvMCColumn
port map(
	colonne_i => colonne1_i_s,
	colonne_o => colonne1_o_s);
InvMCColumn2 : InvMCColumn
port map(
	colonne_i => colonne2_i_s,
	colonne_o => colonne2_o_s);
InvMCColumn3 : InvMCColumn
port map(
	colonne_i => colonne3_i_s,
	colonne_o => colonne3_o_s);

data_o(0)(0) <= colonne0_o_s(0);
data_o(0)(1) <= colonne1_o_s(0);
data_o(0)(2) <= colonne2_o_s(0);
data_o(0)(3) <= colonne3_o_s(0);

data_o(1)(0) <= colonne0_o_s(1);
data_o(1)(1) <= colonne1_o_s(1);
data_o(1)(2) <= colonne2_o_s(1);
data_o(1)(3) <= colonne3_o_s(1);

data_o(2)(0) <= colonne0_o_s(2);
data_o(2)(1) <= colonne1_o_s(2);
data_o(2)(2) <= colonne2_o_s(2);
data_o(2)(3) <= colonne3_o_s(2);

data_o(3)(0) <= colonne0_o_s(3);
data_o(3)(1) <= colonne1_o_s(3);
data_o(3)(2) <= colonne2_o_s(3);
data_o(3)(3) <= colonne3_o_s(3);

end InvMixColumn_arch;

configuration InvMixColumn_conf of InvMixColumn is
for InvMixColumn_arch
	for all : InvMCColumn
		use entity lib_sources.InvMCColumn(InvMCColumn_arch);
	end for;
end for;
end InvMixColumn_conf;
