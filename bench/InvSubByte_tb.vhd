library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library AESLibrary;
use AESLibrary.state_definition_package.all;

library lib_sources;
use lib_sources.all;

entity InvSubByte_tb is
end entity;

architecture InvSubByte_tb_arch of InvSubByte_tb is
component InvSubByte
	port(
		data_i : in type_state;
		data_o : out type_state);
end component;

signal data_i_s : type_state := ((X"b6",X"a0",X"3d",X"4d"),(X"af",X"19",X"0c",X"ac"),(X"33",X"a9",X"10",X"a8"),(X"aa",X"e8",X"69",X"7b"));
signal data_o_s : type_state;

begin
	DUT : InvSubByte
		port map(
			data_i => data_i_s,
			data_o => data_o_s);

end architecture InvSubByte_tb_arch;

configuration InvSubByte_tb_conf of InvSubByte_tb is
	for InvSubByte_tb_arch
		for DUT : InvSubByte
			use entity lib_sources.InvSubByte(InvSubByte_arch);
		end for;
	end for;
end configuration InvSubByte_tb_conf;
