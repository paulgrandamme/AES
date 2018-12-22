library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

library AESLibrary;
use AESLibrary.state_definition_package.all;

library lib_sources;
use lib_sources.all;

entity InvShiftRows_tb is
end entity;

architecture InvShiftRows_tb_arch of InvShiftRows_tb is
component InvShiftRows
port(
		data_i : in type_state;
		data_o : out type_state);
end component;

signal data_i_s : type_state := ((X"b6",X"a0",X"3d",X"4d"),(X"19",X"0c",X"ac",X"af"),(X"10",X"a8",X"33",X"a9"),(X"7b",X"aa",X"e8",X"69"));
signal data_o_s : type_state;

begin
	DUT : InvShiftRows
		port map(
			data_i => data_i_s,
			data_o => data_o_s);
end architecture;

configuration InvShiftRows_tb_conf of InvShiftRows_tb is
	for InvShiftRows_tb_arch
		for DUT : InvShiftRows
			use entity lib_sources.InvShiftRows(InvShiftRows_arch);
		end for;
	end for;
end configuration InvShiftRows_tb_conf;
