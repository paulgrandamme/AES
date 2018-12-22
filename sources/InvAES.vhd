library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

library AESLibrary;
use AESLibrary.state_definition_package.all;

library lib_sources;
use lib_sources.all;

entity InvAES is
  port(
    start_i : in std_logic;
    clock_i : in std_logic;
    reset_i : in std_logic;
    data_i  : in bit128;

    aes_on_o : out std_logic;
    data_o   : out bit128);
end entity;

architecture InvAES_arch of InvAES is

  component Compteur
    port(
      resetb_i : in  std_logic;
      ce_i     : in  std_logic;
      clk_i    : in  std_logic;
      cpt_o    : out bit4);
  end component;

  component Inverseur
    port(
      data_i : in  std_logic;
      data_o : out std_logic);
  end component;

  component InvAES_FSM
    port(
      clk_i                  : in  std_logic;
      resetb_i               : in  std_logic;
      round_i                : in  bit4;
      start_i                : in  std_logic;
      done_o                 : out std_logic;
      enableCounter_o        : out std_logic;
      enableMixColumns_o     : out std_logic;
      enableOutput_o         : out std_logic;
      enableRoundComputing_o : out std_logic;
      getciphertext_o        : out std_logic;
      resetCounter_o         : out std_logic);
  end component;

  component KeyExpansion_table
    port(
      round_i         : in  bit4;
      expansion_key_o : out bit128);
  end component;

  component Multiplexeur
    port(
      data_i          : in  bit128;
      data_invAES_i   : in  bit128;
      getciphertext_i : in  std_logic;
      data_o          : out bit128);
  end component;

  component InvAESRound
    port(
      clk_i                 : in  std_logic;
      currentkey_i          :     bit128;
      currenttext_i         :     bit128;
      enableInvMixColumns_i : in  std_logic;
      enableRoundComputing  : in  std_logic;
      resetb_i              : in  std_logic;
      data_o                : out bit128);
  end component;

  component Registre
    port(
      resetb_i      : in  std_logic;
      D_i           : in  bit128;
      clk_i         : in  std_logic;
      Enable_output : in  std_logic;
      Q_o           : out bit128);
  end component;

  signal resetCompteur_s        : std_logic;
  signal enableCompteur_s       : std_logic;
  signal compteur_s             : bit4;
  signal resetb_s               : std_logic;
  signal enableMixColumns_s     : std_logic;
  signal enableOutput_s         : std_logic;
  signal enableRoundComputing_s : std_logic;
  signal getciphertext_s        : std_logic;
  signal expansion_key_s        : bit128;
  signal data2_s                 : bit128;
  signal currenttext_s          : bit128;


begin

  compteur0 : Compteur
    port map(
      resetb_i => resetCompteur_s,
      ce_i     => enableCompteur_s,
      clk_i    => clock_i,
      cpt_o    => compteur_s);

  inverseur0 : Inverseur
    port map(
      data_i => reset_i,
      data_o => resetb_s);

  invAES_fsm0 : InvAES_FSM
    port map(
      clk_i                  => clock_i,
      resetb_i               => resetb_s,
      round_i                => compteur_s,
      start_i                => start_i,
      done_o                 => aes_on_o,
      enableCounter_o        => enableCompteur_s,
      enableMixColumns_o     => enableMixColumns_s,
      enableOutput_o         => enableOutput_s,
      enableRoundComputing_o => enableRoundComputing_s,
      getciphertext_o        => getciphertext_s,
      resetCounter_o         => resetCompteur_s);

  keyexpansiontable0 : KeyExpansion_Table
    port map(
      round_i         => compteur_s,
      expansion_key_o => expansion_key_s);

  multiplexeur0 : Multiplexeur
    port map(
      data_i          => data_i,
      data_invAES_i   => data2_s,
      getciphertext_i => getciphertext_s,
      data_o          => currenttext_s);

  invAESRound0 : InvAESRound
    port map(
      clk_i                 => clock_i,
      currentkey_i          => expansion_key_s,
      currenttext_i         => currenttext_s,
      enableInvMixColumns_i => enableMixColumns_s,
      enableRoundComputing  => enableRoundComputing_s,
      resetb_i              => resetb_s,
      data_o                => data2_s);

  registre0 : Registre
    port map(
      resetb_i      => resetb_s,
      D_i           => data2_s,
      clk_i         => clock_i,
      Enable_output => enableOutput_s,
      Q_o           => data_o);

end architecture;

configuration InvAES_conf of InvAES is
  for InvAES_arch
    for compteur0 : Compteur
      use entity lib_sources.Compteur(Compteur_arch);
    end for;
    for inverseur0 : Inverseur
      use entity lib_sources.Inverseur(Inverseur_arch);
    end for;
    for invAES_fsm0 : InvAES_FSM
      use entity lib_sources.InvAES_FSM(InvAES_FSM_arch);
    end for;
    for keyexpansiontable0 : KeyExpansion_Table
      use entity lib_sources.KeyExpansion_Table(KeyExpansion_Table_arch);
    end for;
    for multiplexeur0 : Multiplexeur
      use entity lib_sources.Multiplexeur(Multiplexeur_arch);
    end for;
    for invAESRound0 : InvAESRound
      use entity lib_sources.InvAESRound(InvAESRound_arch);
    end for;
    for registre0 : Registre
      use entity lib_sources.Registre(Registre_arch);
    end for;
  end for;
end InvAES_conf;
