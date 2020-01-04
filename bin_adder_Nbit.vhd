
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bin_adder_Nbit is
			generic (N : INTEGER := 9) ;
			Port ( A : in  STD_LOGIC_VECTOR(N-1 downto 0);		-- LSB is the implied zero
           B : in  STD_LOGIC_VECTOR(N-1 downto 0);
			  C_IN : in  STD_LOGIC;
           S : out  STD_LOGIC_VECTOR(N-1 downto 0);
           C_OUT : out  STD_LOGIC);
end bin_adder_Nbit;

architecture arch_bin_adder_Nbit of bin_adder_Nbit is

	component full_add is 
		port(a,b,c_in : in STD_LOGIC ; 
				sum,c_out : out STD_LOGIC);
	end component full_add ;
	
	signal CARRY : STD_LOGIC_VECTOR(N downto 0) ;
	
	begin
	
		CARRY(0) <= C_IN ;
	
		GK : for K in N-1 downto 0 generate 
			FA : full_add port map (CARRY(K),A(K),B(K),S(K),CARRY(K+1)) ;   -- Association of Component ports with Entity Ports .
		end generate GK ;
	
		C_OUT <= CARRY(N) ;


end arch_bin_adder_Nbit;

