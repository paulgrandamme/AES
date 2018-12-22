library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

library AESLibrary;
use AESLibrary.state_definition_package.all;

library lib_sources;
use lib_sources.all;

entity InvSubByte is
port (
	data_i : in type_state;
	data_o : out type_state);
end InvSubByte;

architecture InvSubByte_arch of InvSubByte is
component InvSbox
	port(
		byte_i  : in bit8;
		byte_o : out bit8
	);
end component;
begin
	ligne : for I in 0 to 3 generate
		colonne : for J in 0 to 3 generate
			mat : InvSbox
			port map(
				byte_i => data_i(I)(J),
				byte_o => data_o(I)(J));
		end generate colonne;
	end generate ligne;
end architecture InvSubByte_arch;

configuration InvSubByte_conf of InvSubByte is
	for InvSubByte_arch
		for ligne
			for colonne
				for mat : InvSbox
					use entity lib_sources.InvSbox(InvSbox_arch);
				end for;
			end for;
		end for;
	end for;
end configuration;
