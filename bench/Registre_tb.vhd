library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

library AESLibrary;
use AESLibrary.state_definition_package.all;

library lib_sources;
use lib_sources.all;

entity registre_tb is
end entity;

architecture registre_tb_arch of registre_tb is

component Registre
port(
	resetb_i : in std_logic;
	D_i : in bit128;
	clk_i : in std_logic;
	Enable_output :in std_logic;

	Q_o : out bit128);
end component;

signal resetb_i_s : std_logic;
signal D_i_s : bit128;
signal clk_i_s : std_logic := '0';
signal Enable_output_s : std_logic;
signal Q_o_s : bit128;

begin

DUT : Registre
port map(
	resetb_i => resetb_i_s,
	D_i => D_i_s,
	clk_i => clk_i_s,
	Enable_output => Enable_output_s,
	Q_o => Q_o_s);

clk_i_s <= not clk_i_s after 50 ns;
resetb_i_s <= '1','0' after 30 ns, '1' after 40 ns;
D_i_s <= (others => '1');
Enable_output_s <= '0','1' after 50 ns;

end architecture;

configuration registre_tb_conf of registre_tb is
for registre_tb_arch
	for DUT : Registre
		use entity lib_sources.registre(registre_arch);
	end for;
end for;
end registre_tb_conf;
