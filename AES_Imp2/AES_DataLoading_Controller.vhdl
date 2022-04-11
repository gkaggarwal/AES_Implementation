-- Written by Satyadev Ahlawat
-- Date: 14th March, 2020
-- Version: v.1.0

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY data_loading_controller IS
		PORT (clk, rst, data_available : IN std_logic;
			data_ready : OUT std_logic;
			data_load_round : OUT std_logic_vector(3 downto 0));
END data_loading_controller;

ARCHITECTURE data_loading_controller_logic OF data_loading_controller IS
		TYPE load_state IS (D0,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,D12,D13,D14,D15);
		SIGNAL state : load_state;
--		attribute syn_encoding : string;
--		attribute syn_encoding of load_state : type is "0000 0001 0010 0011 0100 0101
--		0110 0111 1000 1001 1010 1011 1100 1101 1110 1111";
BEGIN
		PROCESS(clk,rst)
		BEGIN
				if (rst = '1') then
						state <= D0;
				elsif (clk'event AND clk='1' ) then
						CASE state IS
								when D0 =>
										if (data_available = '1') then
												state <= D1;
										else
												state <= D0;
										end if;
								when D1 =>
										if (data_available = '1') then
												state <= D2;
										else
												state <= D1;
										end if;
								when D2 =>
										if (data_available = '1') then
												state <= D3;
										else
												state <= D2;
										end if;
								when D3 =>
										if (data_available = '1') then
												state <= D4;
										else
												state <= D3;
										end if;
								when D4 =>
										if (data_available = '1') then
												state <= D5;
										else
												state <= D4;
										end if;
								when D5 =>
										if (data_available = '1') then
												state <= D6;
										else
												state <= D5;
										end if;
								when D6 =>
										if (data_available = '1') then
												state <= D7;
										else
												state <= D6;
										end if;
								when D7 =>
										if (data_available = '1') then
												state <= D8;
										else
												state <= D7;
										end if;
								when D8 =>
										if (data_available = '1') then
												state <= D9;
										end if;
								when D9 =>
										if (data_available = '1') then
												state <= D10;
										end if;
								when D10 =>
										if (data_available = '1') then
												state <= D1;
										else
												state <= D10;
										end if;
								when OTHERS =>
												state <= D0;
						END CASE;
				end if;
		END PROCESS;

		PROCESS (state)
		BEGIN
				CASE state is
						when D0 =>
								data_load_round <= "0000";
								data_ready <= '0';
						when D1 =>
								data_load_round <= "0001";
								data_ready <= '0';
						when D2 =>
								data_load_round <= "0010";
								data_ready <= '0';
						when D3 =>
								data_load_round <= "0011";
								data_ready <= '0';
						when D4 =>
								data_load_round <= "0100";
								data_ready <= '0';
						when D5 =>
								data_load_round <= "0101";
								data_ready <= '0';
						when D6 =>
								data_load_round <= "0110";
								data_ready <= '0';
						when D7 =>
								data_load_round <= "0111";
								data_ready <= '0';
						when D8 =>
								data_load_round <= "1000";
								data_ready <= '0';
						when D9 =>
								data_load_round <= "1001";
								data_ready <= '0';
						when D10 =>
								data_load_round <= "1010";
								data_ready <= '1';
						when OTHERS =>
								data_load_round <= "0000";
								data_ready <= '0';
				END CASE;
		END PROCESS;

END data_loading_controller_logic;
