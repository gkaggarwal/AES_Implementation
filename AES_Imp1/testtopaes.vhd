library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testtopaes is
end testtopaes;
Architecture behavior of testtopaes is
component top_aes IS
		PORT (clk, rst : IN std_logic;
			  start : IN std_logic_vector(1 downto 0);
			  key_data_in : IN std_logic_vector(15 downto 0); 
			  done :out std_logic;
			  
			  cipher_out : OUT std_logic_vector(15 downto 0)
			  );
END component;
signal clk : std_logic := '0';
	signal rst : std_logic;
	
	--signal data_a :std_logic;
	signal datak :std_logic_vector(15 downto 0) := x"0000";
	signal start : std_logic_vector(1 downto 0);
	signal keyd,plaintextd : std_logic_vector(127 downto 0);
	signal done :std_logic;
	
	signal ciphertext : std_logic_vector(15 downto 0);	
	
	-- Clock period definition
	constant period : time := 10 ns;
	begin
	dut : top_aes
		port map(
			clk => clk,
			rst => rst,
			
		--	dav=>data_a,
		   		
			start => start,
			key_data_in  => datak,
			cipher_out => ciphertext,
			done => done
			
		);	
		--keyd<=x"aaaaffffaaaaffffaaaaffffaaaaffff";
                      --key_NIST=2b7e151628aed2a6abf7158809cf4f3c
                      --Plain_Text NIST = 3243f6a8885a308d313198a2e0370734
                      --cipher_Text NIST 3925841d02dc09fbdc118597196a0b32
		keyd<=x"2b7e151628aed2a68bf7158809cf4f3c";
		plaintextd <= x"dda97ca4864cdfe06eaf70a0ec0d7191";
		--ciphertext<= x"ef0bc156ed8ff21223f247b3e0318A99";  // expected output written here for verification
		--keyd<= x"6a84867cd77e12ad07ea1be895c53fa3";
 --plaintextd <= x"6a84867cd77e12ad07ea1be895c53fa3";
 
 --datak<=x"0000";
	-- clock process definitions
	clk_process : process is
	begin
		clk <= '0';
		wait for period/2;
		clk <= '1';
		wait for period/2;
	end process clk_process;

reset :process is
begin
--rst<='0';
--wait for period/2;

--rst<='1';

rst <= '1';
wait for period/2;
rst <= '0';
--wait for period * 10;
--wait until done = '1';
wait;
end process reset;

str1 :process 
begin
--wait for period/2;
wait until clk'event and clk='1';
start <= "01";

wait for period * 11;
start <="11";
wait for period * 11;
end process str1;

--load_d1 :process
--begin
--wait until clk'event and clk = '1'; 

--rst<='1';
--wait for period/2;

--rst<='0';

--data_a<='1';
--wait for period;

--wait for period * 7;
--data_a<='-';
--wait for period;
--data_a<='X';
--wait for period;
--data_a<='1';

--end process load_d1;

load_k :process
begin
 --wait until start = "01" and rst = '0' ;
 wait until start = "01";
 datak<= keyd(15 downto 0);
 wait for period;
 datak <= keyd(31 downto 16);
 wait for period;
 datak <= keyd(47 downto 32);
 wait for period;
 datak <= keyd(63 downto 48);
 wait for period;
 datak <= keyd(79 downto 64);
 wait for period;
datak <= keyd(95 downto 80);
 wait for period; 
 datak <= keyd(111 downto 96);
 wait for period;
 datak <= keyd(127 downto 112);
 
--wait until start ="11" and rst ='0';
wait until start ="11";
wait for period/2 ;

 datak<= plaintextd(15 downto 0);
 wait for period; 
 datak <= plaintextd(31 downto 16);
 wait for period;
 datak <= plaintextd(47 downto 32);
 wait for period;
 datak <= plaintextd(63 downto 48);
 wait for period;
 datak <= plaintextd(79 downto 64);
 wait for period;
datak <= plaintextd(95 downto 80);
 wait for period; 
 datak <= plaintextd(111 downto 96);
 wait for period;
 datak <= plaintextd(127 downto 112);

  end process load_k;


end behavior;	
	
	
	
	
