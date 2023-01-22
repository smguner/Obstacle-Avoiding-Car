library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity clkdiv is
     port(
                clkk_50:in std_logic;
                clr: in std_logic;
                clkk_q:out std_logic);
end entity;
architecture behaviour of clkdiv is
11 
signal q:std_logic_vector(23 downto 0);
begin
     --clkk divider
     process(clkk_50,clr)
     begin
           if clr = '1' then
                q <= X"000000"; -- hex number
           elsif clkk_50'event and clkk_50='1' then
                q <= q+1;
           end if;
     end process;
     clkk_q <= q(6);
end architecture;
