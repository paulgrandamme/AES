library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

library AESLibrary;
use AESLibrary.state_definition_package.all;

library lib_sources;
use lib_sources.all;

entity Inverseur_tb is
end entity;

architecture Inverseur_tb_arch of Inverseur_tb is
component Inverseur
port(
	data_i : in std_logic;
	data_o : out std_logic);
end component;

signal data_s_i : std_logic;
signal data_s_o : std_logic;

begin

DUT : Inverseur
port map(
	data_i => data_s_i,
	data_o => data_s_o);
data_s_i <= '1','0' after 100 ns;

end architecture;

configuration Inverseur_tb_conf of Inverseur_tb is
  for Inverseur_tb_arch
    for DUT : Inverseur
      use entity lib_sources.Inverseur(Inverseur_arch);
    end for;
  end for;
end Inverseur_tb_conf;
