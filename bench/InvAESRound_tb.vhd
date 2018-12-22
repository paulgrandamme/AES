library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

library AESLibrary;
use AESLibrary.state_definition_package.all;

library lib_sources;
use lib_sources.all;

entity InvAESRound_tb is
end entity;

architecture InvAESRound_tb_arch of InvAESRound_tb is
component InvAESRound
	port (
		clk_i : in std_logic;
		currentkey_i : bit128;
		currenttext_i : bit128;
		enableInvMixColumns_i : in std_logic;
		enableRoundComputing : in std_logic;
		resetb_i : in std_logic;

		data_o : out bit128);

end component;

signal clk_s : std_logic := '0';
signal currentkey_s : bit128;
signal currenttext_s : bit128;
signal enableInvMixColumns_s : std_logic;
signal enableRoundComputing_s : std_logic;
signal resetb_s : std_logic;
signal data_s : bit128;

begin

DUT : InvAESRound
port map(
	clk_i => clk_s,
	currentkey_i => currentkey_s,
	currenttext_i => currenttext_s,
	enableInvMixColumns_i => enableInvMixColumns_s,
	enableRoundComputing => enableRoundComputing_s,
	resetb_i => resetb_s,
	data_o => data_s);

--exemple round 8

clk_s <= not clk_s after 50 ns;
currentkey_s <= X"ead27321b58dbad2312bf5607f8d292f";
currenttext_s <= X"362baab27ee343ff292dea22bfea0fc0";
enableInvMixColumns_s <= '1';
enableRoundComputing_s <= '1';
resetb_s <= '1','0' after 30 ns, '1' after 50 ns;

end architecture;

configuration InvAESRound_tb_conf of InvAESRound_tb is
for InvAESRound_tb_arch
	for DUT : InvAESRound
		use entity lib_sources.InvAESRound(InvAESRound_arch);
	end for;
end for;
end InvAESRound_tb_conf;
