library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;


entity mult2 is
    generic (n  : integer := 3);
    port (
        A, B : in std_logic_vector (n downto 0);
        P : out std_logic_vector (n*2+1 downto 0)
    );
    end mult2;

architecture main of mult2 is
    
begin
    process (A,B)
    variable PV, BP: std_logic_vector (n*2+1 downto 0);
    begin
        PV := (others => '0');
        BP  := "0000" & B;
        for i in 0 to n loop
            if A(i) = '1' then
                PV := PV + BP;
            end if;
            BP := BP (n*2 downto 0) & '0';
        end loop;
        P <= PV;
    end process;
end main; 