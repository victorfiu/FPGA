-- UFRPE - UACSA
-- Aluno: Joao Victor Rodrigues dos Santos
-- Professor: Roberto Kenji Hiramatsu
-- testbench somador de n bits (for loop)

library IEEE;
use IEEE.std_logic_1164.all;


entity tb_somador is
end tb_somador;

architecture test of tb_somador is
component soma is 
    
    generic (n  : integer := 4);  -- inserindo o somador

    port (
        As, Bs : in std_logic_vector (n-1 downto 0);
        -- cin : in std_logic; 
        S : out std_logic_vector (n-1 downto 0)
        -- cout : out std_logic
    );
    end component;

	constant n: integer := 9;
	
	signal  As, Bs, S : std_logic_vector (n-1 downto 0); -- inserindo os sinais auxiliares utilizados para determinar os valores no componente
--	signal  cin, cout: std_logic;
	constant dt: time := 10 ns;
begin

entradas: soma generic map(n) port map (As, Bs, S); -- mapeando as portas que serao utilizadas e visualizadas no testbench
-- cin <= '0';
    fAs: FOR i IN 0 TO As'HIGH GENERATE -- loop e generate para ter valores aleatorios inseridos no testbench de acordo com o tempo
        process
        begin
            As(i) <= '0'; wait for 2**i*dt;
            As(i) <= '1'; wait for 2**i*dt;
        end process;
    END GENERATE fAs;
    process
    begin
        fBs: FOR i IN 0 TO Bs'HIGH LOOP
          Bs(i) <= '0'; wait for i*dt/2;
          Bs(i) <= '1'; wait for i*dt/2;
        END LOOP fBs;
    end process;
end test;

