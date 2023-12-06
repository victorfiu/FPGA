library IEEE;
use IEEE.std_logic_1164.all;


entity tb_somador2 is
end tb_somador2;

architecture test of tb_somador2 is
component soma is 
    
    generic (n  : integer := 3);

    port (
        A, B : in std_logic_vector (n downto 0);
        cin : in std_logic; 
        S : out std_logic_vector (n downto 0);
        cout : out std_logic
    );
    end component;

	constant n: integer := 9;
	
	signal  A, B, S : std_logic_vector (n downto 0);
	signal  cin, cout: std_logic;
	constant dt: time := 10 ns;
begin

entradas: soma generic map(n) port map (A, B, cin, S, cout);
cin <= '0';
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

