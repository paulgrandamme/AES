library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

library AESLibrary;
use AESLibrary.state_definition_package.all;

library lib_sources;
use lib_sources.all;

entity compteur_tb is
end entity;

architecture compteur_tb_arch of compteur_tb is

component Compteur
port(
		resetb_i : in std_logic;
		ce_i : in std_logic;
		clk_i : in std_logic;

		cpt_o : out std_logic_vector(3 downto 0));
end component;

signal resetb_i_s : std_logic;
signal ce_i_s : std_logic;
signal clk_i_s : std_logic := '0';
signal cpt_o_s : std_logic_vector(3 downto 0);

begin

DUT : Compteur
port map(
	resetb_i => resetb_i_s,
	ce_i => ce_i_s,
	clk_i => clk_i_s,
	cpt_o => cpt_o_s);


clk_i_s <= not clk_i_s after 50 ns;
resetb_i_s <= '1','0' after 30 ns, '1' after 40 ns;
ce_i_s <= '1';

end architecture;

configuration compteur_tb_conf of compteur_tb is
for compteur_tb_arch
	for DUT : Compteur
		use entity lib_sources.compteur(compteur_arch);
	end for;
end for;
end compteur_tb_conf;
