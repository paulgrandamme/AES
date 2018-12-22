library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

library AESLibrary;
use AESLibrary.state_definition_package.all;

library lib_sources;
use lib_sources.all;

entity InvAESRound is
	port(
		clk_i : in std_logic;
		currentkey_i : bit128;
		currenttext_i : bit128;
		enableInvMixColumns_i : in std_logic;
		enableRoundComputing : in std_logic;
		resetb_i : in std_logic;

		data_o : out bit128);
end entity;

architecture InvAESRound_arch of InvAESRound is

component Conv_typestate_to_bit128
port(
	data_i : in type_state;
	data_o : out bit128);
end component;

component Conv_bit128_to_typestate
port(
	data_i : in bit128;
	data_o : out type_state);
end component;

component Multiplexeur
port(
	data_i : in bit128;
	data_invAES_i : in bit128;
	getciphertext_i : in std_logic;
	data_o : out bit128);
end component;

component InvShiftRows
port(
	data_i : in type_state;
	data_o : out type_state);
end component;

component InvSubByte
port(
	data_i : in type_state;
	data_o : out type_state);
end component;

component InvAddRoundKey
port(
	data_i : in type_state;
	key_i : in type_state;
	data_o : out type_state);
end component;

component InvMixColumn
port(
	data_i:in type_state;
	data_o:out type_state);
end component;

component Registre
port(
	resetb_i : in std_logic;
	D_i : in bit128;
	clk_i : in std_logic;
	Enable_output :in std_logic;

	Q_o : out bit128);
end component;

signal data_s_1 : type_state;
signal data_s_o_ISR : type_state;
signal data_s_o_ISB : type_state;
signal data_s_2 : bit128;
signal data_s_3 : bit128;
signal data_s_o_multi1 : bit128;
signal data_s_4 :type_state;
signal data_s_o_ARK : type_state;
signal data_s_o_IMC : type_state;
signal data_s_5 :bit128;
signal data_s_6 : bit128;
signal data_s_o_multi2 : bit128;
signal currentkey_s : type_state;

begin

conv0 : Conv_bit128_to_typestate
port map(
	data_i => currenttext_i,
	data_o => data_s_1);

invshiftrows0 : InvShiftRows
port map(
	data_i => data_s_1,
	data_o => data_s_o_ISR);

invsubbyte0 : InvSubByte
port map(
	data_i => data_s_o_ISR,
	data_o => data_s_o_ISB);

conv1 : Conv_typestate_to_bit128
port map(
	data_i => data_s_1,
	data_o => data_s_2);

conv2 : Conv_typestate_to_bit128
port map(
	data_i => data_s_o_ISB,
	data_o => data_s_3);

multiplexeur0 : Multiplexeur
port map(
	data_i => data_s_3,
	data_invAES_i => data_s_3,
	getciphertext_i => enableRoundComputing,
	data_o => data_s_o_multi1);

conv3 : Conv_bit128_to_typestate
port map(
	data_i => data_s_o_multi1,
	data_o => data_s_4);

conv6 : Conv_bit128_to_typestate
port map(
	data_i => currentkey_i,
	data_o => currentkey_s);

invaddroundkey0 : InvAddRoundKey
port map(
	data_i => data_s_4,
	key_i => currentkey_s,
	data_o => data_s_o_ARK);

invmixcolumn0 : InvMixColumn
port map(
	data_i => data_s_o_ARK,
	data_o => data_s_o_IMC);

conv4 : Conv_typestate_to_bit128
port map(
	data_i => data_s_o_ARK,
	data_o => data_s_5);

conv5 : Conv_typestate_to_bit128
port map(
	data_i => data_s_o_IMC,
	data_o => data_s_6);

multiplexeur1 : Multiplexeur
port map(
	data_i => data_s_6,
	data_invAES_i => data_s_5,
	getciphertext_i => enableInvMixColumns_i,
	data_o => data_s_o_multi2);

registre0 : Registre
port map(
	resetb_i => resetb_i,
	D_i => data_s_o_multi2,
	clk_i => clk_i,
	Enable_output => enableRoundComputing,
	Q_o => data_o);

end architecture;

configuration InvAESRound_conf of InvAESRound is
for InvAESRound_arch
	for all : Conv_typestate_to_bit128
		use entity lib_sources.Conv_typestate_to_bit128(Conv_typestate_to_bit128_arch);
	end for;
	for all : Conv_bit128_to_typestate
		use entity lib_sources.Conv_bit128_to_typestate(Conv_bit128_to_typestate_arch);
	end for;
	for all : Multiplexeur
		use entity lib_sources.Multiplexeur(Multiplexeur_arch);
	end for;
	for invshiftrows0 : InvShiftRows
		use entity lib_sources.InvShiftRows(InvShiftRows_arch);
	end for;
	for invsubbyte0 : InvSubByte
		use entity lib_sources.InvSubByte(InvSubByte_arch);
	end for;
	for invaddroundkey0 : InvAddRoundKey
		use entity lib_sources.InvAddRoundKey(InvAddRoundKey_arch);
	end for;
	for invmixcolumn0 : InvMixColumn
		use entity lib_sources.InvMixColumn(InvMixColumn_arch);
	end for;
	for registre0 : Registre
		use entity lib_sources.Registre(Registre_arch);
	end for;
end for;
end InvAESRound_conf;
