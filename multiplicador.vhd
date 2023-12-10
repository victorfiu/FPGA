-- UFRPE - UACSA
-- Aluno: Joao Victor Rodrigues dos Santos
-- Professor: Roberto Kenji Hiramatsu
-- multiplicador de n bits (for loop)
-- exemplo, 2 entradas de 4 bits com uma saida de 8 bits
-- caso a segunda entrada tenha um item com 0 vai gerar um vetor de 4 bits = 0000 
-- +  se for 1, será igual a primeira entrada. 

--	     1010       --	     1010  
--	     0101       --	     0101
--	     x          --	     x
--	     1010       --	  0001010 PV(0) -- Esquema do Somador SV(0)+PV(0)=SV(1) -- SV(0) zerado ="0..." ou seja, SV(1) = PV(1)
--	    0000        --	  0000000 PV(1)                       SV(1)+PV(1)=SV(2) 
--         1010         --        0101000 PV(2)                       SV(2)+PV(2)=SV(3)
--        0000          --      + 0000000 PV(3)                       SV(3)+PV(3)=SV(4)
--        =             --      =
--        0110010	--        0110010	

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;


entity mult is
    generic (n  : integer := 4);  -- entrada generica que define o numero de bits de entrada e saida
    port (
        A, B: in std_logic_vector (n-1 downto 0); -- bits de posicao (3,2,1,0) que totalizam 4
        P : out std_logic_vector (n*2-1 downto 0)  -- a multiplicacao fornecera o dobro de bits da entrada como resultado
    );
    end mult;

architecture main of mult is

type PVt is array (integer range <>) of std_logic_vector (n*2-1 downto 0); -- array criado para comportar os vetores que irao para a soma
signal PV : PVt(0 to n-1); 
    
    component soma is -- inserindo o componente que fara a soma
    
        generic (n  : integer := 8); -- os produtos da multiplicacao sao inseridos aqui
    
        port (
            As, Bs : in std_logic_vector (n-1 downto 0);
            S : out std_logic_vector (n-1 downto 0)
        );
    end component;

type SVt is array (integer range <>) of std_logic_vector (n*2-1 downto 0);  -- array que comporta os vetores das saidas da soma
signal SV : SVt(0 to n); -- a primeira soma foi considerada zerada "0000..."
  

begin
    process (A,B) -- processo da quantidade de vetores que serão gerados no loop de acordo com a multiplicacao pelo fator 0 ou 1
    begin
       
 	 f1: for i in 0 to n-1 loop
 		PV(i) <= (others => '0'); -- o vetor produto = 0

         	if B(i) ='1' then  -- a menos que a posicao do vetor B seja 1
			PV(i)(n-1+i downto i) <= A(n-1 downto 0); -- dependendo da posicao, gerara um vetor PV = A deslocado
            	end if;

        end loop;
	end process;

SV(0) <= (others => '0');  -- apenas a primeira saida de soma zerada, devido ao metodo utilizado para interligar o circuito
	fg: for i in 0 to n-1 generate
	ss:	soma  -- inserido a instancia da soma fazemos a ligacao do portmap
    
        generic map (2*n) -- de acordo com a entrada dos PV's e o 'n' do inicio
    
        port map (
            As => SV(i),
 	        Bs => PV(i),
            S => SV(i+1) -- representa a ultima saida
        );
 	end generate;

P(n*2-1 downto 0) <= SV(n);	-- representa o resultado	

end main; 
