library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

library AESLibrary;
use AESLibrary.state_definition_package.all;

library lib_sources;
use lib_sources.all;

entity conv_typestate_to_bit128 is
port(
	data_i : in type_state;
	data_o : out bit128);
end entity;

architecture conv_typestate_to_bit128_arch of conv_typestate_to_bit128 is

signal conv_s : bit128;

begin

ligne : for i in 0 to 3 generate
	colonne : for j in 0 to 3 generate
		conv_s(127-32*j-8*i downto 120-32*j-8*i) <= data_i(i)(j);
	end generate;
end generate;

data_o <= conv_s;

end architecture;
