library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

library AESLibrary;
use AESLibrary.state_definition_package.all;

library lib_sources;
use lib_sources.all;

entity multiplexeur is
	port(
		data_i : in bit128;
		data_invAES_i : in bit128;
		getciphertext_i : in std_logic;

		data_o : out bit128);
end entity;

architecture multiplexeur_arch of multiplexeur is

signal data_s : bit128;

begin
	seq0 : process(getciphertext_i,data_i,data_invAES_i)
	begin
		if (getciphertext_i ='1') then
			data_o <= data_invAES_i;
		else
			data_o <= data_i;
		end if;
	end process;
end architecture;
