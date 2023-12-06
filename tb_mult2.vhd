library IEEE;
use IEEE.std_logic_1164.all;


entity tb_mult2 is
end tb_mult2;

architecture test of tb_mult2 is
component mult2 is 
    
    generic (n  : integer := 3);
    port (
        A, B : in std_logic_vector (n downto 0);
        P : out std_logic_vector (n*2+1 downto 0)
    );
    end component;

	constant n: integer := 3;
	
	signal  A, B : std_logic_vector (n downto 0);
	signal   P : std_logic_vector (n*2+1 downto 0);
	constant dt: time := 10 ns;
begin

entradas: mult2 generic map(n) port map (A, B, P);
    fA: FOR i IN 0 TO A'HIGH GENERATE
        process
        begin
            A(i) <= '0'; wait for 2**i*dt;
            A(i) <= '1'; wait for 2**i*dt;
        end process;
    END GENERATE fA;
    process
    begin
        fB: FOR i IN 0 TO B'HIGH LOOP
          B(i) <= '0'; wait for i*dt/2;
          B(i) <= '1'; wait for i*dt/2;
        END LOOP fB;
    end process;
end test;

