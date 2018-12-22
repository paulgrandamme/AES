library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

library AESLibrary;
use AESLibrary.state_definition_package.all;

library lib_sources;
use lib_sources.all;

entity InvAddRoundKey_tb is
end entity;

architecture InvAddRoundKey_tb_arch of InvAddRoundKey_tb is
component InvAddRoundKey
	port(
		data_i : in type_state;
		key_i : in type_state;
		data_o : out type_state);
end component;

signal data_i_s : type_state := ((X"79",X"47",X"8b",X"65"),(X"1b",X"8e",X"81",X"aa"),(X"66",X"b7",X"7c",X"6f"),(X"62",X"c8",X"e4",X"03"));
signal key_i_s : type_state := ((X"2b",X"28",X"ab",X"09"),(X"7e",X"ae",X"f7",X"cf"),(X"15",X"d2",X"15",X"4f"),(X"16",X"a6",X"88",X"3c"));
signal data_o_s : type_state;

begin
	DUT  : InvAddRoundKey
		port map(
				data_i => data_i_s,
				key_i => key_i_s,
				data_o => data_o_s);
end architecture InvAddRoundKey_tb_arch;

configuration InvAddRoundKey_tb_conf of InvAddRoundKey_tb is
	for InvAddRoundKey_tb_arch
		for DUT : InvAddRoundKey
			use entity lib_sources.InvAddRoundKey(InvAddRoundKey_arch);
		end for;
	end for;
end configuration InvAddRoundKey_tb_conf;
