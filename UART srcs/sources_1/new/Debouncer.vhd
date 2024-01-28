library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity debouncer is
    Port(  clk : in std_logic;
         btn : in std_logic;
         btno : out std_logic);
end debouncer;

architecture Behavioral of debouncer is

signal counter : std_logic_vector(21 downto 0) := (others => '0');
begin

process(clk)
begin
    if(rising_edge(clk)) then
        if (btn = '1') then
            counter <= std_logic_vector(unsigned(counter)+1);
            if unsigned(counter) >= 250000 then
            btno <= '1';
            end if;
        else
            btno <= '0';
            counter <= (others => '0');
        end if;
    end if;
end process;
end Behavioral;