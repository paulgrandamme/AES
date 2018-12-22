library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

library AESLibrary;
use AESLibrary.state_definition_package.all;

library lib_sources;
use lib_sources.all;

entity registre is
port(
	resetb_i : in std_logic;
	D_i : in bit128;
	clk_i : in std_logic;
	Enable_output :in std_logic;

	Q_o : out bit128);
end entity;

architecture registre_arch of registre is

signal q_s : bit128;

begin

	seq0 : process(clk_i,resetb_i)
	begin
		if resetb_i = '0' then
			q_s <= (others => '0');
		elsif clk_i'event and clk_i='1' then
			if Enable_output = '1' then
				q_s <= D_i;
			else
				q_s <= q_s;
			end if;
		else
			q_s <= q_s;
		end if;
	end process;
Q_o <= q_s;
end architecture;
