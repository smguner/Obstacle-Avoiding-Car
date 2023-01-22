library ieee;
use ieee.std_logic_1164.all;
entity 3sens is
     port(
basysclk: in std_logic; pulse:in std_logic_vector(2 downto 0); 
trigout:out std_logic_vector(2 downto 0); 
ultrasens_out:out std_logic_vector(2 downto 0)); 
end entity; 
architecture behaviour of 3sens is 
component ultrasonic is
     port(
                basysclk: in std_logic;
                pulse: in std_logic; -- echo
                trigout:out std_logic; -- trigger out
                obstacle:out std_logic);
end component;
begin
ultrasonic_Left:ultrasonic port map(basysclk,pulse(0),trigout(0),ultrasens_out(2)); ultrasonic_Middle:ultrasonic port map(basysclk,pulse(1),trigout(1),ultrasens_out(1)); ultrasonic_Right:ultrasonic port map(basysclk,pulse(2),trigout(2),ultrasens_out(0)); 
end architecture;
