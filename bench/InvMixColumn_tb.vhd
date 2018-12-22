library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

library AESLibrary;
use AESLibrary.state_definition_package.all;

library lib_sources;
use lib_sources.all;

entity InvMixColumn_tb is
end entity;

architecture InvMixColumn_tb_arch of InvMixColumn_tb is
component InvMixColumn
	port(
		data_i : in type_state;
		data_o : out type_state);
end component;

signal data_i_s : type_state := ((X"37", X"4d",X"4e",X"b0"),(X"cf", X"f1",X"c3",X"81"),(X"02",X"02",X"d4",X"10"),(X"3e",X"10",X"13",X"03"));
signal data_o_s : type_state;

begin

DUT : InvMixColumn
port map(
	data_i => data_i_s,
	data_o => data_o_s);

end InvMixColumn_tb_arch;

configuration InvMixColumn_tb_conf of InvMixColumn_tb is
for InvMixColumn_tb_arch
	for DUT : InvMixColumn
		use configuration lib_sources.InvMixColumn_conf;
	end for;
end for;
end InvMixColumn_tb_conf;
