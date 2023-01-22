library ieee;
use ieee.std_logic_1164.all;
entity trig_gen is port(clk: in std_logic; 
                trigg : out std_logic);
end entity; 
architecture behaviour of trig_gen is 
component counter is
     generic(n : positive :=10);
     port( clk: in std_logic;
enable : in std_logic; rst : in std_logic; -- active low countout: out std_logic_vector(n-1 downto 0)); 
end component;
signal rstCounter:std_logic; signal out_count: std_logic_vector(23 downto 0); 
begin 
trigger_gen:counter generic map(24)
                        port
map(clk,'1',rstCounter,out_count); process(clk) 
constant ms100:std_logic_vector(23 downto 0):=“010011000100101101000000";
constant ms100And20us: std_logic_vector(23 downto 0):="010011000100110100110011";     begin
           if(out_count > ms100 and out_count <
ms100And20us) then
                trigg <= '1';
           else
                trigg <='0';
end if; 
if(out_count = ms100and20us or out_count="XXXXXXXXXXXXXXXXXXXXXXXX") then 
                rstCounter <= '0';
           else
                rstCounter <= '1';
           end if;
     end process;
end architecture;
