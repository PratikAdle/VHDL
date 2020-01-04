
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity full_add is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           c_in : in  STD_LOGIC;
           sum : out  STD_LOGIC;
           c_out : out  STD_LOGIC);
end full_add;

architecture arch_full_add of full_add is

	begin
	
		sum <= a xor b xor c_in ;
		c_out <= ( a and b ) or ( b and c_in ) or ( c_in and a ) ;


end arch_full_add ;

