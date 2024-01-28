library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity uart_tx is
  Port ( 
  clk, en, send, rst : in  std_logic;
  char               : in  std_logic_vector(7 downto 0);
  ready, tx          : out std_logic
  );
end uart_tx;

architecture Behavioral of uart_tx is
    type state is (idle, data, start);
    signal curr  : state  := idle;
    signal count : std_logic_vector(3 downto 0) := (others => '0');
    signal temp  : std_logic_vector(7 downto 0) := (others => '0');
begin
process(clk, rst, en)
begin
if rising_edge(clk) then
    if rst = '1' then
        curr  <= idle;
        count <= (others => '0');
        temp  <= (others => '0');
        tx <= '1';
        ready <= '1';
        end if;
    if en = '1' then
        case curr is
            when idle  =>
                ready <= '1';
                tx    <= '1';
                if rising_edge(send) or send = '1' then
                    temp <= char;
                    curr <= start;
                    ready <= '0';
                    
                end if;
            when data  =>
                if unsigned(count) < 8 then
                    tx <= temp(to_integer(unsigned(count)));
                   -- temp <= '0' & temp(7 downto 1);
                    count <= std_logic_vector(unsigned(count) + 1);
                    curr <= data;
                else
                    curr <= idle;
                    tx <= '1';
                end if;
            when start =>
             tx    <= '0';
                curr <= data;
                count <= (others => '0');
               
                
                    
        end case;
    end if;
    end if;
end process;

end Behavioral;
