----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/24/2020 04:33:09 PM
-- Design Name: 
-- Module Name: cordic_tb - Behavioral
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


--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

--entity cordic_tb is
----  Port ( );
--end cordic_tb;

--architecture Behavioral of cordic_tb is

--begin


--end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
Use ieee.numeric_std.All;


entity cordic_tb is
--  Port ( );
end cordic_tb;

architecture Behavioral of cordic_tb is
    constant N: integer := 17;
    constant iteration_num: integer:= 10;
    constant T: time := 10 ns; -- clock period
    signal clk, reset, start, result_ready: std_logic;
    signal beta: std_logic_vector(N-1 downto 0);
    signal sin_beta: std_logic_vector(N-1 downto 0);
    signal cos_beta: std_logic_vector(N-1 downto 0);
    --   signal mx1, my1, mz1, mx2, my2, mz2, ytemp, xtemp,x1reg, x2reg ,y1reg, y2reg , z1reg, z2reg: std_logic_vector(N-1 downto 0);

begin
    counter_unit:entity work.sin_cos(Behavioral)
        generic map(N => N, iteration_num=>iteration_num)
        port map(
            clk=>clk, reset=>reset, beta=>beta, cos_out=>cos_beta, sin_out=>sin_beta, result_ready=>result_ready, start=>start
        );
        
    process
    begin
        clk <= '0';
        wait for T/2;
        clk <= '1';
        wait for T/2;
    end process;

    reset <= '1', '0' after 2*T;
    
--other stimulus
    process
    begin
        wait for 2*T; 
        start <= '1';
--        wait for 2*T;
        beta <= "00000000000000000"; -- 0 degree = 0.0
        wait for 4*T;
        beta <= "00010000110000010"; -- 30 degree = pi/6 = 0.52359877559829887 = 0.5236 
        wait for 4*T;
        beta <= "00110010010000111"; -- 45 degree = pi/4 = 0.7853981633974483
        wait for 4*T;
        beta <= "00100111000110000"; -- 70 degree = pi/6 * 7/3 = 1.2217304763
        wait for 4*T;
        beta <= "00100001100000101"; -- 60 degree = pi/3 = 1.0471975511965
        wait for 4*T;
        beta <= "00110010010000111"; -- 90 degree = pi/2 = 1.570796326794896
        wait for 4*T;
        
--        beta <= "10010000110000010"; -- -30 degree = pi/6 = 0.52359877559829887 = 0.5236 
--        wait for 4*T;
--        beta <= "10110010010000111"; -- -45 degree = pi/4 = 0.7853981633974483
--        wait for 4*T;
--        beta <= "10100001100000101"; -- -60 degree = pi/3 = 1.0471975511965
--        wait for 4*T;

        beta <= "01000011000001010"; -- 120 degree = 3*pi/2 = 2.094395102393 
        wait for 4*T;
        beta <= "01010011110001101"; -- 150 degree = 5*pi/6 = 2.617993877991 
        wait for 4*T;
        beta <= "01100100100001111"; -- 180 degree = pi = 3.1415926535897932
        wait for 4*T;
        
        
        wait for 4*T;
--        beta <= "00010000110000010"; -- 30 degree = pi/6 = 0.52359877559829887 = 0.5236 
--        wait for 4*T;
--        beta <= "00100111000110000"; -- 70 degree = pi/6 * 7/3 = 1.2217304763
--        wait for 4*T;
--        beta <= "00100001100000101"; -- 60 degree = pi/3 = 1.0471975511965
        wait for 8500*T;
    
    end process;

--assert false
--    report "Simulation Completed"
--    severity failure;

end Behavioral;
