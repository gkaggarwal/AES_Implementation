-- Written by Satyadev Ahlawat
-- Date: 15th March, 2020
-- Version: v.1.0

LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY PlaintextLoading IS
		PORT (clk, rst, load_plaintext : IN std_logic;
			  data_load_round : IN std_logic_vector (3 downto 0);
			  data_in : IN std_logic_vector (15 downto 0);
			  plain_text : OUT std_logic_vector (127 downto 0));
END PlaintextLoading;


ARCHITECTURE PlaintextLoading_logic OF PlaintextLoading IS

 		SIGNAL reg0,reg1,reg2,reg3,reg4,reg5,reg6,reg7 : std_logic_vector(15 downto 0);

BEGIN
		PROCESS(clk, rst)
		BEGIN
				if (rst = '1') then
						reg0 <= X"0000";
						reg1 <= X"0000";
						reg2 <= X"0000";
						reg3 <= X"0000";
						reg4 <= X"0000";
						reg5 <= X"0000";
						reg6 <= X"0000";
						reg7 <= X"0000";
				elsif (clk'event AND clk='1') then
						if (load_plaintext = '1') then
								CASE data_load_round IS
										when "0000" =>
												reg0 <= data_in;
												reg1 <= reg1;
												reg2 <= reg2;
												reg3 <= reg3;
												reg4 <= reg4;
												reg5 <= reg5;
												reg6 <= reg6;
												reg7 <= reg7;
										when "0001" =>
												reg0 <= reg0;
												reg1 <= data_in;
												reg2 <= reg2;
												reg3 <= reg3;
												reg4 <= reg4;
												reg5 <= reg5;
												reg6 <= reg6;
												reg7 <= reg7;
										when "0010" =>
												reg0 <= reg0;
												reg1 <= reg1;
												reg2 <= data_in;
												reg3 <= reg3;
												reg4 <= reg4;
												reg5 <= reg5;
												reg6 <= reg6;
												reg7 <= reg7;
										when "0011" =>
												reg0 <= reg0;
												reg1 <= reg1;
												reg2 <= reg2;
												reg3 <= data_in;
												reg4 <= reg4;
												reg5 <= reg5;
												reg6 <= reg6;
												reg7 <= reg7;
										when "0100" =>
												reg0 <= reg0;
												reg1 <= reg1;
												reg2 <= reg2;
												reg3 <= reg3;
												reg4 <= data_in;
												reg5 <= reg5;
												reg6 <= reg6;
												reg7 <= reg7;
										when "0101" =>
												reg0 <= reg0;
												reg1 <= reg1;
												reg2 <= reg2;
												reg3 <= reg3;
												reg4 <= reg4;
												reg5 <= data_in;
												reg6 <= reg6;
												reg7 <= reg7;
										when "0110" =>
												reg0 <= reg0;
												reg1 <= reg1;
												reg2 <= reg2;
												reg3 <= reg3;
												reg4 <= reg4;
												reg5 <= reg5;
												reg6 <= data_in;
												reg7 <= reg7;
										when "0111" =>
												reg0 <= reg0;
												reg1 <= reg1;
												reg2 <= reg2;
												reg3 <= reg3;
												reg4 <= reg4;
												reg5 <= reg5;
												reg6 <= reg6;
												reg7 <= data_in;
										when "1010" =>
												reg0 <= data_in;
												reg1 <= reg1;
												reg2 <= reg2;
												reg3 <= reg3;
												reg4 <= reg4;
												reg5 <= reg5;
												reg6 <= reg6;
												reg7 <= reg7;
										when OTHERS =>
												reg0 <= reg0;
												reg1 <= reg1;
												reg2 <= reg2;
												reg3 <= reg3;
												reg4 <= reg4;
												reg5 <= reg5;
												reg6 <= reg6;
												reg7 <= reg7;
								END CASE;
						else
								reg0 <= reg0;
								reg1 <= reg1;
								reg2 <= reg2;
								reg3 <= reg3;
								reg4 <= reg4;
								reg5 <= reg5;
								reg6 <= reg6;
								reg7 <= reg7;
						end if;
				end if;
		END PROCESS;

		plain_text(127 downto 112) <= reg7;
		plain_text(111 downto 96) <= reg6;
		plain_text(95 downto 80) <= reg5;
		plain_text(79 downto 64) <= reg4;
		plain_text(63 downto 48) <= reg3;
		plain_text(47 downto 32) <= reg2;
		plain_text(31 downto 16) <= reg1;
		plain_text(15 downto 0) <= reg0;

END PlaintextLoading_logic;


