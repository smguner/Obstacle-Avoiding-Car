library ieee;
use ieee.std_logic_1164.all;
entity car is
     port(
                basysclk: in std_logic;
                echo: in std_logic_vector(2 downto 0);
                trigger: out std_logic_vector(2 downto 0);
                LED : out std_logic_vector(2 downto 0);
               Leftm_forw,
               Rightm_forw,
               Leftm_backw,
               Rightm_backw: out std_logic);
end entity;
architecture behaviour of car is
component pwmm is
--generic(N : integer:=7);
port(
           Clkk_50: in std_logic;
           duty: in std_logic_vector(15 downto 0);
           pwmm : out std_logic);
end component;
component 3sens is
port( 
end component;
basysclk: in std_logic; pulse:in std_logic_vector(2 downto 0); 
trigout:out std_logic_vector(2 downto 0); 
ultrasens_out:out std_logic_vector(2 downto 0)); 
signal ultrasonic: std_logic_vector(2 downto 0); 
signal pwmm_1,pwmm_2 : std_logic; signal forw,backw,turnL,turnR:std_logic; 
signal duty_1,duty_2:std_logic_vector(15 downto 0); 
begin 
Pwmm1:pwmm port map(basysclk,duty_1,pwmm_1); 
Pwmm2:pwmm port map(basysclk,duty_2,pwmm_2); 
process(forw,backw,turnL,turnR) begin 
     if(forw = '1') then
          Rightm_forw <= pwmm_1;
          Leftm_forw <= pwmm_2;
          Leftm_backw <= '0';
          Rightm_backw <= '0';
     elsif(backw = '1') then
          Rightm_backw <= pwmm_2;
          Leftm_backw <= pwmm_1;
          Rightm_forw <= '0';
          Leftm_forw <= '0';
     elsif(turnR = '1') then
          Leftm_forw <= pwmm_2;
          Rightm_backw <= pwmm_1;
          Rightm_forw <= '0';
          Leftm_backw <= '0';
     elsif(turnL = '1') then
          Rightm_forw <= pwmm_2;
          Leftm_backw <= pwmm_1;
          Rightm_backw <= '0';
          Leftm_forw <= '0';
     end if;
end process;
rangesens:3sens port map(basysclk,echo,trigger,ultrasonic); 
process(ultrasonic)
begin
     case (ultrasonic) is
when "000" => forw <= '1';backw <= '0';turnR<='0';turnL<='0'; duty_1 <= X"00BE"; duty_2 <= X"00C3"; 
when "001" => forw <= '0';backw <= '0';turnR<='0';turnL<='1'; duty_1 <= X"00C3"; duty_2 <= X"00C3"; when "010" => backw <= '1';forw <= '0';turnR<='0';turnL<='0'; duty_1 <= X"0041"; duty_2 <= X"00C3"; 
when "011" => turnL <= '0';backw <= '1';forw <= '0';turnR<='0'; duty_1 <= X"00C3"; duty_2 <= X"0041"; when "100" => forw <= '0';backw <= '0';turnR<='1';turnL<='0';duty_1 <= X"00C3"; duty_2 <= X"00C3";
when "101" => forw <= '1';backw <= '0';turnR<='0';turnL<='0';duty_1 <= X"00BE"; duty_2 <= X"00C3"; 
when "110" => turnR <= '0';turnL <= '0';backw <= '1';forw <= '0'; duty_1 <= X"0041"; duty_2 <= X"00C3";
when "111" => backw <= '1';forw <= '0';turnR<='0';turnL<='0';duty_1 <= X"00C3"; duty_2 <= X"0041"; 
     end case;
end process;
LED(2)<= not(ultrasonic(2));
LED(1)<= not(ultrasonic(1));
LED(0)<= not(ultrasonic(0));
end architecture;
