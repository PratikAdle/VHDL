library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity bit_pair_multiplication is
	generic (M : INTEGER := 8 ; P : INTEGER := 16) ;
	    Port ( multiplier : in  STD_LOGIC_VECTOR(M-1 downto 0);
				multiplicand : in  STD_LOGIC_VECTOR(M-1 downto 0);
				mul_answer : out  STD_LOGIC_VECTOR(P-1 downto 0));
end bit_pair_multiplication;

architecture arch_bit_pair of bit_pair_multiplication is

	component bin_adder_Nbit									   -- Declaring Component 9 bit adder 
		generic (N : INTEGER) ;
		Port ( A : in  STD_LOGIC_VECTOR(N-1 downto 0);		-- LSB is the implied zero
           B : in  STD_LOGIC_VECTOR(N-1 downto 0);
			  C_IN : in  STD_LOGIC;
           S : out  STD_LOGIC_VECTOR(N-1 downto 0);
           C_OUT : out  STD_LOGIC);
	end component bin_adder_Nbit ;
	

	
	signal A,A_COMP,S,S_COMP,Q: STD_LOGIC_VECTOR(P downto 0) ;
	
	signal P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12,P13,P14,P15,P16 : STD_LOGIC_VECTOR(P downto 0) ;
	
	signal partial_product1 , partial_product2 , 
			 partial_product3 , partial_product4  : STD_LOGIC_VECTOR(P downto 0) ;
			 
	signal partial_product1_shift , partial_product2_shift , 
		    partial_product3_shift , partial_product4_shift : STD_LOGIC_VECTOR(P downto 0) ;
			 
	signal Z , complement1_mulpr , complement2_mulpr : STD_LOGIC_VECTOR(M-1 downto 0) ;
	
begin
	
	A(P downto M+1) <= multiplier ;
	A(M downto 0) <= ( others => '0') ;
	
	complement1_mulpr <= not(multiplier) ;
	Z <= ( 0 => '1' , others => '0') ;
	A_COMP(P downto M+1) <= complement2_mulpr  ;
	A_COMP(M downto 0) <= ( others => '0') ;
	
	S(P downto 1) <= A(P-1 downto 0) ;
	S(0) <= '0' ;
	
	S_COMP(P downto 1) <= A_COMP(P-1 downto 0) ;
	S_COMP(0) <= '0' ;
	
	Q(P downto M+1) <= ( others => '0') ;
	Q(M downto 1) <= multiplicand ;
	Q(0) <= '0' ;
	
	partial_product1 <= Q when(Q(2 downto 0 ) = "000" or Q(2 downto 0) = "111") else 			
								P1 when (Q(2 downto 0) = "001" or Q(2 downto 0) = "010") else			-- P1 = Q+A					
								P2 when (Q(2 downto 0) = "101" or Q(2 downto 0) = "110") else			-- P2 = Q+A_COMP	
								P3 when Q(2 downto 0) = "011" else												-- P3 = Q+S
								P4 when Q(2 downto 0) = "100";													-- P4 = Q+S_COMP

	partial_product1_shift (P-2 downto 0) <= partial_product1(P downto 2) ;
	partial_product1_shift (P) <= partial_product1(P) ;
	partial_product1_shift (P-1) <= partial_product1(P) ;
	
	
	
	
	partial_product2 <= partial_product1_shift when(partial_product1_shift(2 downto 0 ) = "000" or 
							  partial_product1_shift(2 downto 0) = "111") else 			
								P5 when (partial_product1_shift(2 downto 0) = "001" or 
											partial_product1_shift(2 downto 0) = "010") else			-- P5 = partial_product1_shift+A					
								P6 when (partial_product1_shift(2 downto 0) = "101" or 
											partial_product1_shift(2 downto 0) = "110") else			-- P6 = partial_product1_shift+A_COMP	
								P7 when partial_product1_shift(2 downto 0) = "011" else				-- P7 = partial_product1_shift+S
								P8 when partial_product1_shift(2 downto 0) = "100";					-- P8 = partial_product1_shift+S_COMP

	partial_product2_shift (P-2 downto 0) <= partial_product2(P downto 2) ;
	partial_product2_shift (P) <= partial_product2(P) ;
	partial_product2_shift (P-1) <= partial_product2(P) ;
	
	
	
	partial_product3 <= partial_product2_shift when(partial_product2_shift(2 downto 0 ) = "000" or 
							  partial_product1_shift(2 downto 0) = "111") else 			
								P9 when (partial_product2_shift(2 downto 0) = "001" or 
											partial_product2_shift(2 downto 0) = "010") else			-- P9 = partial_product2_shift+A					
								P10 when (partial_product2_shift(2 downto 0) = "101" or 
											partial_product2_shift(2 downto 0) = "110") else			-- P10 = partial_product2_shift+A_COMP	
								P11 when partial_product2_shift(2 downto 0) = "011" else				-- P11 = partial_product2_shift+S
								P12 when partial_product2_shift(2 downto 0) = "100";					-- P12 = partial_product2_shift+S_COMP

	partial_product3_shift (P-2 downto 0) <= partial_product3(P downto 2) ;
	partial_product3_shift (P) <= partial_product3(P) ;
	partial_product3_shift (P-1) <= partial_product3(P) ;
	
	
	partial_product4 <= partial_product3_shift when(partial_product3_shift(2 downto 0 ) = "000" or 
							  partial_product3_shift(2 downto 0) = "111") else 			
								P13 when (partial_product3_shift(2 downto 0) = "001" or 
											partial_product3_shift(2 downto 0) = "010") else			-- P13 = partial_product3_shift+A					
								P14 when (partial_product3_shift(2 downto 0) = "101" or 
											partial_product3_shift(2 downto 0) = "110") else			-- P14 = partial_product3_shift+A_COMP	
								P15 when partial_product3_shift(2 downto 0) = "011" else				-- P15 = partial_product3_shift+S
								P16 when partial_product3_shift(2 downto 0) = "100";					-- P16 = partial_product3_shift+S_COMP

	partial_product4_shift (P-2 downto 0) <= partial_product4(P downto 2) ;
	partial_product4_shift (P) <= partial_product4(P) ;
	partial_product4_shift (P-1) <= partial_product4(P) ;
	
	
	
	BA4_1 : bin_adder_Nbit generic map (M) port map (complement1_mulpr,Z,'0',complement2_mulpr) ;
	
	BAN_1 : bin_adder_Nbit generic map (P+1) port map (Q,A,'0',P1) ;
	BAN_2 : bin_adder_Nbit generic map (P+1) port map (Q,A_COMP,'0',P2) ;
	BAN_3 : bin_adder_Nbit generic map (P+1) port map (Q,S,'0',P3) ;
	BAN_4 : bin_adder_Nbit generic map (P+1) port map (Q,S_COMP,'0',P4) ;
	BAN_5 : bin_adder_Nbit generic map (P+1) port map (partial_product1_shift,A,'0',P5) ;
	BAN_6 : bin_adder_Nbit generic map (P+1) port map (partial_product1_shift,A_COMP,'0',P6) ;
	BAN_7 : bin_adder_Nbit generic map (P+1) port map (partial_product1_shift,S,'0',P7) ;
	BAN_8 : bin_adder_Nbit generic map (P+1) port map (partial_product1_shift,S_COMP,'0',P8) ; 
	BAN_9 : bin_adder_Nbit generic map (P+1) port map (partial_product2_shift,A,'0',P9) ;
	BAN_10 : bin_adder_Nbit generic map (P+1) port map (partial_product2_shift,A_COMP,'0',P10) ;
	BAN_11 : bin_adder_Nbit generic map (P+1) port map (partial_product2_shift,S,'0',P11) ;
	BAN_12 : bin_adder_Nbit generic map (P+1) port map (partial_product2_shift,S_COMP,'0',P12) ;
	BAN_13 : bin_adder_Nbit generic map (P+1) port map (partial_product3_shift,A,'0',P13) ;
	BAN_14 : bin_adder_Nbit generic map (P+1) port map (partial_product3_shift,A_COMP,'0',P14) ;
	BAN_15 : bin_adder_Nbit generic map (P+1) port map (partial_product3_shift,S,'0',P15) ;
	BAN_16 : bin_adder_Nbit generic map (P+1) port map (partial_product3_shift,S_COMP,'0',P16) ;	-- Association of Component ports with Entity Ports
	

	mul_answer <= partial_product4_shift(P downto 1) ;


end arch_bit_pair;

