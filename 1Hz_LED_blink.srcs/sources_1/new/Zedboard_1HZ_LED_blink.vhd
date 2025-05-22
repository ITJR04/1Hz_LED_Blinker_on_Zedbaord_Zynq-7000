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
-- This module toggles an onboard LED at a rate of 1 Hz using an external
-- enable signal generated from a 100 MHz clock. It demonstrates basic 
-- synchronous design principles, signal toggling using clock enables, 
-- and top-level module instantiation.
--
-- The design instantiates an `enable_gen` component which generates a 
-- 1 Hz enable pulse. On every asserted enable, the LED state toggles.
--
-- Dependencies: None
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- Introductory FPGA project for me on the ZedBoard. Designed to 
-- teach modular design, signal instantiation, and synchronous LED control 
-- using a non-divided clock approach which is what i gained from this project
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

entity Zedboard_1HZ_LED_blink is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           led : out STD_LOGIC);
end Zedboard_1HZ_LED_blink;

architecture Behavioral of Zedboard_1HZ_LED_blink is 
    signal led_state : std_logic; -- signal for led state on('1') or off('0')
    signal enable_1hz : std_logic; -- signal that will be used in order to indicate what led state will be
    
    component enable_gen 
    port(CLK : in std_logic;
         RESET : in std_logic;
         ENABLE : out std_logic
         );
    end component;
begin
    U1: enable_gen port map ( -- instantiation of enable_gen for led_state
        CLK => CLK,
        RESET => RESET,
        ENABLE => enable_1hz
    ); 
    
    process(CLK) -- process for led blink logic
    begin
        if rising_edge(CLK) then 
            if reset = '1' then
                led_state <= '0';
            elsif enable_1hz = '1' then
                led_state <= not led_state;
            end if;
        end if;  
    end process;
    led <= led_state; -- after each process execution assign led_state to led
end Behavioral;
