library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

library AESLibrary;
use AESLibrary.state_definition_package.all;

library lib_sources;
use lib_sources.all;

entity InvShiftRows is
	port(
		data_i : in type_state;
		data_o : out type_state);
end entity;

architecture InvShiftRows_arch of InvShiftRows is
begin
	data_o(0) <= data_i(0);
	data_o(1) <= data_i(1)(3)&data_i(1)(0)&data_i(1)(1)&data_i(1)(2);
	data_o(2) <= data_i(2)(2)&data_i(2)(3)&data_i(2)(0)&data_i(2)(1);
	data_o(3) <= data_i(3)(1)&data_i(3)(2)&data_i(3)(3)&data_i(3)(0);
end architecture InvShiftRows_arch;
