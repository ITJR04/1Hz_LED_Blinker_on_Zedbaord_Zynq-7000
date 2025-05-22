----------------------------------------------------------------------------------
-- Company: University of Connecticut
-- Engineer: Isai Torres
-- 
-- Create Date: 05/22/2025 10:13:54 AM
-- Design Name: 
-- Module Name: zedboard_1HZ_LED_blink_tb - Behavioral
-- Project Name:      1_HZ_LED_Blink
-- Target Devices:    ZedBoard Zynq-7000 (Simulation Only)
-- Tool Versions:     Vivado 2024.2
-- Description: 
-- This is a testbench for the `Zedboard_1HZ_LED_blink` module. It simulates
-- a 100 MHz clock and applies a reset signal. The testbench waits for multiple
-- toggles of the LED signal and reports when the LED turns ON and OFF to 
-- validate the 1 Hz enable behavior from the `enable_gen` component.
--
-- The simulation runs for 4 seconds of simulated time, allowing observation
-- of two full ON/OFF LED cycles (1 Hz blinking).
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- This file is intended for simulation only. It does not synthesize to hardware.
-- Use Vivado, GHDL, or another simulator to verify LED blinking behavior, in my case i used VHDL
-- also please do change the MAX_COUNT of in the Zedboard_1HZ_LED_blink.vhd to lower value
-- since we only care for simulation therefore we dont want to have a 4 second simulation, that takes some time to generate
--
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity zedboard_1HZ_LED_blink_tb is
--  Port ( );
end zedboard_1HZ_LED_blink_tb;

architecture Behavioral of zedboard_1HZ_LED_blink_tb is
component Zedboard_1HZ_LED_blink
port (
    clk : in std_logic;
    reset : in std_logic;
    led : out std_logic
);
end component;
signal clk : std_logic := '0';
signal reset : std_logic := '0';
signal led : std_logic;
constant clk_period : time := 10ns; -- 100Mhz freq clk
begin

uut: Zedboard_1HZ_LED_blink port map (
    clk => clk,
    reset => reset,
    led => led);

clk_process: process -- process for the clock
begin
   while now < 4 sec loop -- loops for 4 seconds 
    clk <= '0'; -- initial clock at 0
    wait for clk_period/2; -- wait for half the period 
    clk <= '1'; -- rising edge to 1
    wait for clk_period/2; -- again wait for half period
   end loop; -- restart till we reach 4 seconds
end process;


stim_proc: process -- stimulation process for this project
begin
    reset <= '1'; -- initial reset 
    wait for 20 ns; -- wait before changing reset to 0
    reset <= '0';
    wait until led <= '1'; -- once logic processes we wait 
    report "LED turned ON (1st time)" severity note; -- after led is 1 we report
    wait until led = '0'; -- wait agian
    report "LED turned OFF (1st time)" severity note; -- report first OFF
    wait until led <= '1'; -- wait again
    report "LED turned ON (2nd time)" severity note; -- report second ON
    wait until led <= '0'; -- wait again
    report "LED turned OFF (2nd time)" severity note; -- report second OFF
    wait;
end process;

end Behavioral;
