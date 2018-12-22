library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

library AESLibrary;
use AESLibrary.state_definition_package.all;

library lib_sources;
use lib_sources.all;

entity InvAddRoundKey is
	port(
		data_i : in type_state;
		key_i : in type_state;
		data_o : out type_state);
end entity InvAddRoundKey;

architecture InvAddRoundKey_arch of InvAddRoundKey is
begin
	ligne : for i in 0 to 3 generate
		colonne : for j in 0 to 3 generate
			data_o(i)(j) <= data_i(i)(j) xor key_i(i)(j);
		end generate colonne;
	end generate ligne;
end architecture InvAddRoundKey_arch;
