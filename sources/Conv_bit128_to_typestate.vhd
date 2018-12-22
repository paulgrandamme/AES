library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

library AESLibrary;
use AESLibrary.state_definition_package.all;

library lib_sources;
use lib_sources.all;

entity conv_bit128_to_typestate is
port(
	data_i : in bit128;
	data_o : out type_state);
end entity;

architecture conv_bit128_to_type_state_arch of conv_bit128_to_typestate is

signal conv_s : type_state;

begin

ligne : for i in 0 to 3 generate
	colonne : for j in 0 to 3 generate
		conv_s(i)(j) <= data_i(127-32*j-8*i downto 120-32*j-8*i);
	end generate;
end generate;

data_o <= conv_s;

end architecture;
