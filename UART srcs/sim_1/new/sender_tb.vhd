----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/23/2023 08:20:12 PM
-- Design Name: 
-- Module Name: sender_tb - Behavioral
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

entity sender_tb is
--  Port ( );
end sender_tb;

architecture Behavioral of sender_tb is
component MasterChief is
    Port (TXD,clk: in std_logic;
         btn: in std_logic_vector(1 downto 0);
         RXD: out std_logic  );
end component;
signal clk, txd, rxd  : std_logic;
signal btn : std_logic_vector(1 downto 0) := "00";
begin
    -- clock process @125 MHz
    process begin
        clk <= '0';
        wait for 4 ns;
        clk <= '1';
        wait for 4 ns;
    end process;
    process begin
    txd <= '0';
    btn(1) <= '0';
    wait for 4687200 ns;
    btn(1) <= '1';
    wait for 4687200 ns;
    
    end process;
bruh: MasterChief 
port map(
txd => txd,
clk => clk,
btn => btn,
rxd => rxd
);
end Behavioral;
