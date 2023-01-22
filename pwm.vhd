library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity pwmm is
port(
end pwmm; 
Clkk_50: in std_logic; duty: in std_logic_vector(15 downto 0); pwmm : out std_logic); architecture behaviour of pwmm is
component clkdiv is
     port(
                clkk_50:in std_logic;
                clr: in std_logic;
                clkk_q:out std_logic);
end component;
signal count: std_logic_vector(15 downto 0); signal clk,pwmm_sig: std_logic; signal period :std_logic_vector(15 downto 0); 
signal clr:std_logic; 
begin
    period <= X"00C3";
clr <= '0'; 
     process(clk,clr)
     begin
           if (clr='1') then
                count<=X"0000";
           elsif (clk'event and clk='1') then
                if (count=period-1) then
                      count<=X"0000";
                else
                      count<= count+1;
                end if;
           end if;
     end process;
     process(count)
     begin
           if (count < duty) then
                pwmm_sig <='1';
           elsif(count > duty) then
                pwmm_sig <='0';
           end if;
     end process;
     pwmm <= pwmm_sig;
Clkk:clkdiv port map(clkk_50,'0',clk); -- divide 50Mhz clkk to clk_q6 
end architecture;
