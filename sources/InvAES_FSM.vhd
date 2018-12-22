library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

library AESLibrary;
use AESLibrary.state_definition_package.all;

library lib_sources;
use lib_sources.all;

entity InvAES_FSM is
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
end entity;

architecture InvAES_FSM_arch of InvAES_FSM is
	--liste des états de la fsm
	type state_t is (init, first, middle, last, fin);
	-- déclaration des signaux
	signal etat_present : state_t;
	signal etat_futur : state_t;

	begin
		seq0 : process (clk_i,resetb_i)
		begin
			if (resetb_i ='0') then
				etat_present <= init;
			elsif (clk_i'event and clk_i = '1') then
				etat_present <= etat_futur;
			end if;
		end process seq0;

		comb0 : process(etat_present, start_i,round_i)
		begin
			case etat_present is
				when init =>
					if start_i = '1' then
						etat_futur <= first;
					else
						etat_futur <= init;
					end if;
				when first =>
					etat_futur <= middle;
				when middle =>
					if (round_i = "0000") then
						etat_futur <= last;
					else
						etat_futur <= middle;
					end if;
				when last =>
					etat_futur <= fin;
				when fin =>
					if start_i='1' then
						etat_futur <= last;
					else
						etat_futur <= init;
					end if;
			end case;
		end process comb0;

		comb1 : process(etat_present)
		begin
			case etat_present is
				when init =>
					done_o <= '0';
					enableCounter_o <= '0';
					enableMixColumns_o <= '0';
					enableOutPut_o <= '0';
					enableRoundComputing_o <= '0';
					getciphertext_o <= '0';
					resetCounter_o <= '1';
				when first =>
					done_o <= '0';
					enableCounter_o <= '0';
					enableMixColumns_o <= '0';
					enableOutPut_o <= '0';
					enableRoundComputing_o <= '0';
					getciphertext_o <= '1';
					resetCounter_o <= '0';
				when middle =>
					done_o <= '0';
					enableCounter_o <= '1';
					enableMixColumns_o <= '1';
					enableOutPut_o <= '0';
					enableRoundComputing_o <= '1';
					getciphertext_o <= '0';
					resetCounter_o <= '0';
				when last =>
					done_o <= '0';
					enableCounter_o <= '0';
					enableMixColumns_o <= '0';
					enableOutPut_o <= '0';
					enableRoundComputing_o <= '0';
					getciphertext_o <= '0';
					resetCounter_o <= '0';
				when fin =>
					done_o <= '1';
					enableCounter_o <= '0';
					enableMixColumns_o <= '0';
					enableOutPut_o <= '1';
					enableRoundComputing_o <= '0';
					getciphertext_o <= '0';
					resetCounter_o <= '0';
			end case;
		end process;
end architecture;
