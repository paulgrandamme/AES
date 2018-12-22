library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

library AESLibrary;
use AESLibrary.state_definition_package.all;

library lib_sources;
use lib_sources.all;

entity Inverseur is
port(
	data_i : in std_logic;
	data_o : out std_logic);
end entity;

architecture Inverseur_arch of Inverseur is

begin

data_o <= not data_i;

end architecture;
