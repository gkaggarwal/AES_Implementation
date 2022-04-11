-- written by Satyadev Ahlawat
-- Date : March 9th, 2020
-- Version : v.1.0


LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY top_aes IS
		PORT (clk, rst : IN std_logic;
			  start : IN std_logic_vector(1 downto 0);
			  key_data_in : IN std_logic_vector(15 downto 0); 
			  done : OUT std_logic;
			  cipher_out : OUT std_logic_vector(15 downto 0));
END top_aes;


ARCHITECTURE top_aes_logic OF top_aes IS

		SIGNAL cipher_reg : std_logic_vector(127 downto 0);
		SIGNAL round_reg : std_logic_vector(127 downto 0);


--------->>>>> signal and component declaration for data_loading_controller instantiation ---->>>>>

		SIGNAL data_avail,data_rdy : std_logic;
		SIGNAL data_ld_rnd : std_logic_vector(3 downto 0);


		COMPONENT data_loading_controller IS
				PORT (clk, rst, data_available : IN std_logic; 
					  data_ready : OUT std_logic; 
					  data_load_round : OUT std_logic_vector(3 downto 0));
		END COMPONENT;

-->>>>>>>>>>>>>>>>>>>>>>>>>---------------------------------------------------------<<<<<<<<<<<<<<<<<<

------------->>>>>>>>>> signal and component declaration for KeyLoading instantiation--------->>>>>>
		
		SIGNAL ld_key : std_logic;
		SIGNAL enc_key : std_logic_vector(127 downto 0);

	
		COMPONENT KeyLoading IS
				PORT (clk, rst, load_key : IN std_logic; 
					  data_load_round : IN std_logic_vector(3 downto 0); 
					  data_in : IN std_logic_vector(15 downto 0); 
					  encry_key : OUT std_logic_vector(127 downto 0));
		END COMPONENT;
		
		
-->>>>>>>>>>>>>>>>>>>>>>>>>---------------------------------------------------------<<<<<<<<<<<<<<<<<<

------------->>>>>>>>>> signal and component declaration for KeyExpansion instantiation--------->>>>>>

        SIGNAL  rnd_key : std_logic_vector(127 downto 0);
        SIGNAL enc_key_in :std_logic_vector(127 downto 0);
        
        COMPONENT KeyExpansion IS
        PORT (clk : IN std_logic;
			 data_load_round : IN std_logic_vector(3 downto 0);
			 encry_key_in : IN std_logic_vector(127 downto 0);
			 round_key : INOUT std_logic_vector(127 downto 0));
		END component;
		

-->>>>>>>>>>>>>>>>>>>>>>>>>---------------------------------------------------------<<<<<<<<<<<<<<<<<<

------------->>>>>>>>>> signal and component declaration for PlaintextLoading instantiation--------->>>>>>
		
		SIGNAL ld_plaintext : std_logic;
		SIGNAL plain_txt : std_logic_vector(127 downto 0);
		
		COMPONENT PlaintextLoading IS
				PORT (clk, rst, load_plaintext : IN std_logic; 
					  data_load_round : IN std_logic_vector (3 downto 0); 
					  data_in : IN std_logic_vector (15 downto 0); 
					  plain_text : OUT std_logic_vector (127 downto 0));
		END COMPONENT;
		
		
-->>>>>>>>>>>>>>>>>>>>>>>>>---------------------------------------------------------<<<<<<<<<<<<<<<<<<

------------->>>>>>>>>> signal and component declaration for encry_round_controller instantiation--------->>>>>>

		
		SIGNAL encry_rnd : std_logic_vector(3 downto 0);
		
		COMPONENT encry_round_controller IS
				PORT (clk, rst, start : IN std_logic; 
					  cipher_text_ready : OUT std_logic; 
					  encry_round : OUT std_logic_vector (3 downto 0));
		END COMPONENT;
		
		
-->>>>>>>>>>>>>>>>>>>>>>>>>---------------------------------------------------------<<<<<<<<<<<<<<<<<<

------------->>>>>>>>>> signal and component declaration for PreRound instantiation--------->>>>>>
		
		
		SIGNAL pre_rnd_out : std_logic_vector(127 downto 0);
		
		COMPONENT pre_round IS
		PORT (plain_text : IN std_logic_vector(127 downto 0);
		      encry_key : IN std_logic_vector(127 downto 0);
		      pre_round_out : OUT std_logic_vector(127 downto 0));
		END COMPONENT;
		
		
		
-->>>>>>>>>>>>>>>>>>>>>>>>>---------------------------------------------------------<<<<<<<<<<<<<<<<<<

------------->>>>>>>>>> signal and component declaration for SBox instantiation--------->>>>>>

		
		SIGNAL sbx_in : std_logic_vector(127 downto 0);
		SIGNAL sbx_out : std_logic_vector(127 downto 0);
		
		COMPONENT SBox IS
				PORT (SBox_in : IN std_logic_vector(127 downto 0); 
					  SBox_out : OUT std_logic_vector(127 downto 0));
		END COMPONENT;
		
-->>>>>>>>>>>>>>>>>>>>>>>>>---------------------------------------------------------<<<<<<<<<<<<<<<<<<

------------->>>>>>>>>> signal and component declaration for shiftrows instantiation--------->>>>>>


		SIGNAL shftrows_out : std_logic_vector(127 downto 0);
		
		COMPONENT shiftrows IS
				PORT (shiftrows_in : IN std_logic_vector (127 downto 0); 
					  shiftrows_out : OUT std_logic_vector(127 downto 0));
		END COMPONENT;
		
		
-->>>>>>>>>>>>>>>>>>>>>>>>>---------------------------------------------------------<<<<<<<<<<<<<<<<<<

------------->>>>>>>>>> signal and component declaration for MixColumn instantiation--------->>>>>>

		
		SIGNAL mxcolumn_out : std_logic_vector(127 downto 0);
		
		COMPONENT MixColumn IS
				PORT (MixColumn_in : IN std_logic_vector (127 downto 0); 
					  MixColumn_out : OUT std_logic_vector (127 downto 0));
		END COMPONENT;
		
		
-->>>>>>>>>>>>>>>>>>>>>>>>>---------------------------------------------------------<<<<<<<<<<<<<<<<<<

------------->>>>>>>>>> signal and component declaration for RoundkeyAddition instantiation--------->>>>>>
		
		SIGNAL rnd_keyadd_out , r_key_in: std_logic_vector(127 downto 0);
		
		COMPONENT RoundkeyAddition IS
		PORT (RoundkeyAddition_in, RoundKey : IN std_logic_vector (127 downto 0);
			 RoundkeyAddition_out : OUT std_logic_vector (127 downto 0));
		END COMPONENT;
		
-->>>>>>>>>>>>>>>>>>>>>>>>>---------------------------------------------------------<<<<<<<<<<<<<<<<<<


BEGIN
		
		DLC0 : data_loading_controller PORT MAP (clk,rst,data_avail,data_rdy,data_ld_rnd);
		KL0 : KeyLoading PORT MAP (clk,rst,ld_key,data_ld_rnd,key_data_in,enc_key);
		KE0 : KeyExpansion PORT MAP (clk,encry_rnd,enc_key_in,rnd_key);
		PTL0 : PlaintextLoading PORT MAP (clk,rst,ld_plaintext,data_ld_rnd,key_data_in,plain_txt);
		ERC0 : encry_round_controller PORT MAP (clk,rst,data_rdy,done,encry_rnd);
		PR0 : pre_round PORT MAP (plain_txt,enc_key,pre_rnd_out);
		SB0 : SBox PORT MAP (sbx_in, sbx_out);
		SR0 : shiftrows PORT MAP (sbx_out, shftrows_out);
		MC0 : MixColumn PORT MAP (shftrows_out,mxcolumn_out);
		RKA0 : RoundkeyAddition PORT MAP (r_key_in,rnd_key,rnd_keyadd_out);
		
		PROCESS(start)
		BEGIN
				if start="00" then
						ld_key <='0';
						ld_plaintext <='0';
						data_avail <='0';
				elsif start="01" then
						ld_key <='1';
						ld_plaintext <='0';
						data_avail <='1';
				elsif start="11" then
						ld_key <='0';
						ld_plaintext <='1';
						data_avail <='1';
				else
						ld_key <='0';
						ld_plaintext <='0';
						data_avail <='0';
				end if;
		END PROCESS;
		
		PROCESS(clk,rst)
		VARIABLE rnd_reg : std_logic_vector(127 downto 0);
		BEGIN
		      if rst='1' then
		          rnd_reg := (OTHERS=>'0');
		      elsif clk'event AND clk='1' then
		          rnd_reg := rnd_keyadd_out;
		      end if;
		      round_reg <= rnd_reg;		      
		 END PROCESS;
		
		
		PROCESS (encry_rnd)
		BEGIN
		          if encry_rnd="1010" then
		                  sbx_in <= pre_rnd_out;
		          else
		                  sbx_in <= round_reg;
		          end if;
		 END PROCESS;
	
		PROCESS (encry_rnd,clk,mxcolumn_out)
		BEGIN
		          if encry_rnd="1001" then
		                  r_key_in <= shftrows_out;
		          else
		                  r_key_in <= mxcolumn_out;
		          end if;
		 END PROCESS;
		 
		PROCESS (encry_rnd)
		BEGIN
		          if encry_rnd="1010" then
		                  enc_key_in <= enc_key;
		          else
		                  enc_key_in <= rnd_key;
		          end if;
		 END PROCESS;
		
		
		
		
		
		
	
		PROCESS(clk)
		BEGIN
		if clk'event AND clk='1' then
		          if encry_rnd="1001" then
		                  cipher_reg <= rnd_keyadd_out;
		          else
		                  cipher_reg <= cipher_reg;
		          end if;
		 end if;
		 END PROCESS;
		 
		 PROCESS(clk,rst)
		 BEGIN
		      if rst='1' then
		              cipher_out <= (OTHERS => '0');	 
		      elsif clk'event AND clk='1' then
		              CASE encry_rnd IS 
		                  WHEN "1010" =>
		                                  cipher_out <= 	cipher_reg(15 downto 0);
		                  WHEN "0001" =>
		                                  cipher_out <= cipher_reg(31 downto 16);
		                  WHEN "0010" =>
		                                  cipher_out <= 	cipher_reg(47 downto 32);
		                  WHEN "0011" =>
		                                  cipher_out <= cipher_reg(63 downto 48);
		                  WHEN "0100" =>
		                                  cipher_out <= 	cipher_reg(79 downto 64);
		                  WHEN "0101" =>
		                                  cipher_out <= cipher_reg(95 downto 80);
		                  WHEN "0110" =>
		                                  cipher_out <= 	cipher_reg(111 downto 96);
		                  WHEN "0111" =>
		                                  cipher_out <= cipher_reg(127 downto 112);
		                  WHEN OTHERS=>
		                                  cipher_out <= (OTHERS => '0');
		                  END CASE;
		      end if;
		      END PROCESS;


		END top_aes_logic;	






