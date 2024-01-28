library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Sender is
    Port (
        rst,clk,en,btn, ready : in std_logic;
        send : out std_logic;
        char : out std_logic_vector(7 downto 0)
    );
end Sender;

architecture Behavioral of Sender is
    type str is array (0 to 5) of std_logic_vector(7 downto 0);
    signal NETID : str := (x"61", x"73", x"70",x"32",x"36",x"35");
    type state is (idle, busyA, busyB, busyC);
    signal curr : state := idle;
    signal i: integer := 0;
begin
    process (clk)
    begin
        if rising_edge(CLK) and en = '1' then
            if rst = '1' then
                send <= '0';
                char <= (others => '0');
                i <= 0;
                curr <= idle;
            end if;
            case curr is
                when idle =>
                    if (ready = '1' and btn = '1' and i < 6) then
                         
                            send <= '1';
                            char <= netid(i);
                            i <= i+1;
                            curr <= busyA;
                        elsif (ready = '1' and btn = '1' and  i = 6) then
                            i <= 0;
                            curr <= idle;
                        
                    end if;
                when busyA =>
                    curr <= busyB;
                when busyB =>
                    send<= '0';
                    curr <= busyC;
                when busyC =>
                    if ready = '1' and btn ='0' then
                        curr <= idle;
                    end if;

            end case;
        end if;
    end process;
end Behavioral;
