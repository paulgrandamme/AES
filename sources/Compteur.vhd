library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

library AESLibrary;
use AESLibrary.state_definition_package.all;

library lib_sources;
use lib_sources.all;

entity compteur is
	port(
		resetb_i : in std_logic;
		ce_i : in std_logic;
		clk_i : in std_logic;

		cpt_o : out bit4);
end entity;

architecture compteur_arch of compteur is

signal compteur_s : integer range 0 to 15;

begin
	seq0 : process(clk_i,resetb_i)
	begin
		if (resetb_i = '0') then
			compteur_s <= 10;
		elsif clk_i'event and clk_i = '1' then
			if ce_i ='1' then
				--compteur_s <= 10;
				if compteur_s = 0 then
					compteur_s <= 0;
				else
					compteur_s <= compteur_s - 1;
				end if;
			else
				compteur_s <= compteur_s;
			end if;
		end if;
	end process;

cpt_o <= std_logic_vector(to_unsigned(compteur_s,4));


end architecture;
