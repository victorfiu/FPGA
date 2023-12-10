-- UFRPE - UACSA
-- Aluno: Joao Victor Rodrigues dos Santos
-- Professor: Roberto Kenji Hiramatsu
-- testbench multiplicador de n bits (for loop)

library IEEE;
use IEEE.std_logic_1164.all;


entity tb_mult is
end tb_mult;

architecture test of tb_mult is
component mult is 
    
    generic (n  : integer := 4); -- inserindo o multiplicador
    
    port (
        A, B : in std_logic_vector (n-1 downto 0);
        P: out std_logic_vector (n*2-1 downto 0)
    );
    end component;

    constant n: integer := 4;
	
	signal  A, B : std_logic_vector (3 downto 0);  -- inserindo os sinais auxiliares utilizados para determinar os valores no componente
	signal   P : std_logic_vector (7 downto 0); -- nesse caso com valores fixos para o teste de 4 bits
	constant dt: time := 10 ns;
begin

entradas: mult generic map(n) port map (A, B, P); -- mapeando as portas que serao utilizadas e visualizadas no testbench
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

