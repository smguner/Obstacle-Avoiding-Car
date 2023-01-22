library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std;
entity ultrasonic is
     port(
                basysclk: in std_logic;
                pulse: in std_logic; -- echo
                trigout:out std_logic; -- trigger out
                obstacle:out std_logic);
end entity; 
architecture behaviour of ultrasonic is
component counter is
     generic(n : positive :=10);
     port( clk: in std_logic;
enable : in std_logic; rst : in std_logic; -- active low countout: out std_logic_vector(n-1 downto 0)); 
end component;
component trig_gen is port(clk: in std_logic; 
                trigg : out std_logic);
end component;
signal pulse_width: std_logic_vector(21 downto 0); signal trigg:std_logic; 
begin 
c :
     counter generic map(22) port
map(basysclk,pulse,not(trigg),pulse_width); trigger_generation : 
trig_gen port map(basysclk,trigg); 
obstacle_detection: process(pulse_width) begin 
           if(pulse_width < 55000) then
                obstacle <= '1';
           else
                obstacle <= '0';
           end if;
     end process;
     trigout <= trigg;
end architecture;
