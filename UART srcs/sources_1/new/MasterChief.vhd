----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/23/2023 07:59:49 PM
-- Design Name: 
-- Module Name: MasterChief - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MasterChief is
    Port (txd,clk: in std_logic;
         btn: in std_logic_vector(1 downto 0);
         rxd,cts,rts: out std_logic  );
end MasterChief;

architecture Behavioral of MasterChief is
    component Clock_div is
        Port (
            clk  : in  std_logic;
            div : out std_logic
        );
    end component;

    component debouncer is
        Port(  clk : in std_logic;
             btn : in std_logic;
             btno : out std_logic);
    end component;
    component Sender is
        Port (
            rst,clk,en,btn, ready : in std_logic;
            send : out std_logic;
            char : out std_logic_vector(7 downto 0)
        );
    end component;
    component uart is
        port (

            clk, en, send, rx, rst      : in std_logic;
            charSend                    : in std_logic_vector (7 downto 0);
            ready, tx, newChar          : out std_logic;
            charRec                     : out std_logic_vector (7 downto 0)

        );
    end component;
    signal dbnce1, dbnce2, div, ready, send: std_logic;
    signal charSend : std_logic_vector(7 downto 0);
begin
    cts <= '0';
    rts <= '0';
    u1 : debouncer
        port map(
            clk => clk,
            btn => btn(0),
            btno => dbnce1
        );
    u2 : debouncer
        port map(
            clk => clk,
            btn => btn(1),
            btno => dbnce2
        );
    u3: Clock_div
        port map(
            clk => clk,
            div => div
        );
    u4: Sender
        port map(
            btn    => dbnce2,
            clk    => clk,
            en     => div,
            ready  => ready,
            rst    => dbnce1,
            char   => CharSend,
            send   => send
        );
    u5: uart
        port map(
            charSend => charSend,
            clk => clk,
            en   => div,
            rst  => dbnce1,
            ready=> ready,
            rx   => txd,
            send => send,
            tx   => rxd

        );
end Behavioral;
