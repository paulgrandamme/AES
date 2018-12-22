library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

library AESLibrary;
use AESLibrary.state_definition_package.all;

library lib_sources;
use lib_sources.all;

entity InvMCColumn_tb is
end entity;

architecture InvMCColumn_tb_arch of InvMCColumn_tb is
component InvMCColumn
port(
	colonne_i : in column_state;
	colonne_o : out column_state);
end component;

signal colonne_i_s : column_state := (X"37",X"cf",X"02",X"3e");
signal colonne_o_s : column_state;

begin
	DUT : InvMCColumn
		port map(
			colonne_i => colonne_i_s,
			colonne_o => colonne_o_s);
end architecture;

configuration InvMCColumn_tb_conf of InvMCColumn_tb is
	for InvMCColumn_tb_arch
		for DUT : InvMCColumn
			use entity lib_sources.InvMCColumn(InvMCColumn_arch);
		end for;
	end for;
end configuration InvMCColumn_tb_conf;
