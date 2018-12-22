library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

library AESLibrary;
use AESLibrary.state_definition_package.all;

library lib_sources;
use lib_sources.all;

entity multiplexeur_tb is
end entity;

architecture multiplexeur_tb_arch of multiplexeur_tb is
component multiplexeur
port(
		data_i : in bit128;
		data_invAES_i : in bit128;
		getciphertext_i : in std_logic;

		data_o : out bit128);
end component;

signal data_i_s : bit128;
signal data_invAES_s : bit128;
signal getciphertext_s : std_logic;
signal data_o_s : bit128;

begin
DUT : multiplexeur
port map(
	data_i => data_i_s,
	data_invAES_i => data_invAES_s,
	getciphertext_i => getciphertext_s,
	data_o => data_o_s);

data_i_s <= (others => '0');
data_invAES_s <= (others =>'1');
getciphertext_s <= '0', '1' after 100 ns, '0' after 200 ns;

end architecture;

configuration multiplexeur_tb_conf of multiplexeur_tb is
for multiplexeur_tb_arch
	for DUT : Multiplexeur
		use entity lib_sources.multiplexeur(multiplexeur_arch);
	end for;
end for;
end multiplexeur_tb_conf;
