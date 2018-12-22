library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

library AESLibrary;
use AESLibrary.state_definition_package.all;

library lib_sources;
use lib_sources.all;

entity InvAES_FSM_tb is
end entity;

architecture InvAES_FSM_tb_arch of InvAES_FSM_tb is
component InvAES_FSM
port(
		clk_i : in std_logic;
		resetb_i : in std_logic;
		round_i : in bit4;
		start_i : in std_logic;

		done_o : out std_logic;
		enableCounter_o : out std_logic;
		enableMixColumns_o : out std_logic;
		enableOutput_o : out std_logic;
		enableRoundComputing_o : out std_logic;
		getciphertext_o : out std_logic;
		resetCounter_o : out std_logic);
end component;

signal clk_s : std_logic:='0';
signal resetb_s : std_logic;
signal round_s : bit4;
signal start_s: std_logic;

signal done_s : std_logic;
signal enableCounter_s : std_logic;
signal enableMixColumns_s : std_logic;
signal enableOutput_s : std_logic;
signal enableRoundComputing_s : std_logic;
signal getciphertext_s : std_logic;
signal resetCounter_s : std_logic;

begin

DUT : InvAES_FSM
port map(
	clk_i => clk_s,
	resetb_i => resetb_s,
	round_i => round_s,
	start_i => start_s,

	done_o => done_s,
	enableCounter_o => enableCounter_s,
	enableMixColumns_o => enableMixColumns_s,
	enableOutput_o => enableOutput_s,
	enableRoundComputing_o => enableRoundComputing_s,
	getciphertext_o => getciphertext_s,
	resetCounter_o => resetCounter_s);

clk_s <= not clk_s after 50 ns;
resetb_s <= '1', '0' after 50 ns,'1' after 60 ns;
round_s <= "1010", "1001" after 250 ns, "1000" after 300 ns, "0111" after 350 ns, "0110" after 400 ns, "0101" after 450 ns, "0100" after 500 ns, "0011" after 550 ns, "0010" after 600 ns, "0001" after 650 ns, "0000" after 700 ns;
start_s <= '0','1' after 50 ns, '0' after 200 ns;

end architecture;


configuration InvAES_FSM_tb_conf of InvAES_FSM_tb is
for InvAES_FSM_tb_arch
	for DUT : InvAES_FSM
		use entity lib_sources.InvAES_FSM(InvAES_FSM_arch);
	end for;
end for;
end InvAES_FSM_tb_conf;
