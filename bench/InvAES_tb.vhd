library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

library AESLibrary;
use AESLibrary.state_definition_package.all;

library lib_sources;
use lib_sources.all;

entity InvAES_tb is
end entity;

architecture InvAES_tb_arch of InvAES_tb is
  component InvAES
    port(
      start_i : in std_logic;
      clock_i : in std_logic;
      reset_i : in std_logic;
      data_i  : in bit128;

      aes_on_o : out std_logic;
      data_o   : out bit128);
  end component;

  signal start_s  : std_logic;
  signal clk_s    : std_logic := '0';
  signal reset_s  : std_logic;
  signal data_i_s : bit128;

  signal aes_on_s : std_logic;
  signal data_o_s : bit128;

begin

  DUT : InvAES
    port map(
      start_i  => start_s,
      clock_i  => clk_s,
      reset_i  => reset_s,
      data_i   => data_i_s,
      aes_on_o => aes_on_s,
      data_o   => data_o_s);

  start_s  <= '0', '1'  after 200 ns,'0' after 550 ns;
  clk_s    <= not clk_s after 50 ns;
  reset_s  <= '1', '1'  after 70 ns,'0' after 180 ns;
  data_i_s <= X"d6efa6dc4ce8efd2476b9546d76acdf0";

end architecture;

configuration InvAES_tb_conf of InvAES_tb is
  for InvAES_tb_arch
    for DUT : InvAES
      use configuration lib_sources.InvAES_conf;
    end for;
  end for;
end InvAES_tb_conf;
