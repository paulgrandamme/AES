library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library AESLibrary;
use AESLibrary.state_definition_package.all;

entity InvSbox_tb is
end entity InvSbox_tb;

architecture InvSbox_tb_arch of InvSbox_tb is
component InvSbox
	port(
		byte_i  : in bit8;
		byte_o : out bit8
	);
end component;

signal byte_i_s : bit8;
signal byte_o_s : bit8;

begin 
	DUT : InvSbox
	Port map (
		byte_i => byte_i_s,
		byte_o => byte_o_s);

	P0: process
	--variable compteur : bit8 := "00000000";
	begin
		
		--wait for 200 ns;
		--if (compteur = "11111111") then
		--	compteur := "00000000";
		--else
		--	compteur := std_logic_vector(compteur + 1);
		--end if;
		--byte_o_s <= std_logic_vector(compteur);
		byte_i_s <= X"00";
		wait for 30 ns;
		byte_i_s <= X"01";
		wait for 30 ns;
		byte_i_s <= X"02";
		wait;
	end process P0;
end architecture InvSbox_tb_arch;


