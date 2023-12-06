library IEEE;
use IEEE.std_logic_1164.all;

entity soma is
    generic (n  : integer := 3);
    port (
        A, B : in std_logic_vector (n downto 0);
        cin : in std_logic; 
        S : out std_logic_vector (n downto 0);
        cout : out std_logic
    );
    end soma;

architecture main of soma is
    
begin
    entradas: process (A,B,cin)
    variable v : std_logic_vector (n+1 downto 0);
    begin
        v(0) := cin;
        fl : for i in 0 to n loop
            v(i+1) := (A(i) and B(i)) or (A(i) and v(i)) or (B(i) and v(i));
            S(i) <= A(i) xor B(i) xor v(i);
        end loop fl;
        cout <= v(v'high);
    end process entradas; 
end architecture main;