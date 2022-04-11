-- Written by Satyadev Ahlawat
-- Date: 19th March, 2020
-- Version: v.1.0


LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY KeyLoading IS
		PORT (clk, rst, load_key : IN std_logic;
			  data_load_round : IN std_logic_vector(3 downto 0);
			  data_in : IN std_logic_vector(15 downto 0);
			  encry_key : OUT std_logic_vector(127 downto 0));
END KeyLoading;


ARCHITECTURE KeyLoading_logic OF KeyLoading IS

 		SIGNAL reg0,reg1,reg2,reg3,reg4,reg5,reg6,reg7 : std_logic_vector(15 downto 0);

BEGIN
		PROCESS(clk, rst,data_in)
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
						if (load_key = '1') then
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

		encry_key(127 downto 112) <= reg7;
		encry_key(111 downto 96) <= reg6;
		encry_key(95 downto 80) <= reg5;
		encry_key(79 downto 64) <= reg4;
		encry_key(63 downto 48) <= reg3;
		encry_key(47 downto 32) <= reg2;
		encry_key(31 downto 16) <= reg1;
		encry_key(15 downto 0) <= reg0;

END KeyLoading_logic;


