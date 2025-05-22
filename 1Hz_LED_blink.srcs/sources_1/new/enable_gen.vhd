----------------------------------------------------------------------------------
-- Company: University of Connecticut
-- Engineer: Isai Torres
-- 
-- Create Date: 05/21/2025 10:00:41 PM
-- Design Name: ZedBoard 1Hz LED Blinker
-- Module Name: Zedboard_1HZ_LED_blink - Behavioral
-- Project Name: 1_HZ_LED_Blink
-- Target Devices: ZedBoard Zynq-7000
-- Tool Versions: Vivado 2024.2
-- Description: 
-- This module generates a 1 Hz enable pulse from the ZedBoard’s 100 MHz clock.
-- It acts as a clock enable generator by counting clock cycles and asserting 
-- an enable signal once every second. This design avoids the use of actual 
-- clock division to ensure best practices for synchronous design.
--
-- Dependencies: None
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- This is a foundational beginner FPGA module which I created with the ZedBoard. 
-- It is intended to teach clock enable generation, counter design, and 
-- synchronous logic fundamentals. Designed for synthesis and simulation 
-- with Vivado which I have just learned through this
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

entity enable_gen is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           ENABLE : out STD_LOGIC);
end enable_gen;

architecture Behavioral of enable_gen is
    constant MAX_COUNT : integer := 100_000_000 - 1; -- 100M - 1 for 1HZ from 100Mhz zedboard clock
    signal counter : integer  range 0 to MAX_COUNT := 0; 
begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            if RESET = '1' then -- if reset is enable then counter and enable is zero
                counter <= 0;
                ENABLE <= '0';
            elsif counter = MAX_COUNT then -- checks if counter is equal to the max count
                ENABLE <= '1'; 
                counter <= 0;
            else
                counter <= counter +1; -- incremet till we hit MAX_COUNT again or we reset
                ENABLE <= '0';
            end if;
        end if;
    end process;
end Behavioral;
