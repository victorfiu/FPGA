-- UFRPE - UACSA
-- Aluno: Joao Victor Rodrigues dos Santos
-- Professor: Roberto Kenji Hiramatsu
-- somador de n bits (for loop)

library IEEE;
use IEEE.std_logic_1164.all;

entity soma is
    generic (n  : integer := 4);
    port (
        As, Bs : in std_logic_vector (n-1 downto 0);
      --  cin : in std_logic; -- nao sera necessario o indice que "ultrapassa" porque nao havera 1 em duas posicoes mais significativas
        S : out std_logic_vector (n-1 downto 0)
     --   cout : out std_logic 
    );
    end soma;

architecture main of soma is
    
begin
    entradas: process (As,Bs) -- entradas: process (As,Bs,cin) -- caso fosse necessario
    variable v : std_logic_vector (n downto 0); -- variavel que auxiliara na acao de "levar um" no somador completo
    begin
        v(0) := '0'; -- v(0) := cin;  
        fl : for i in 0 to n-1 loop
            v(i+1) := (As(i) and Bs(i)) or (As(i) and v(i)) or (Bs(i) and v(i));
            S(i) <= As(i) xor Bs(i) xor v(i);
        end loop fl;
      --  cout <= v(v'high);
    end process entradas; 
end architecture main;
