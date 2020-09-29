----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/24/2020 01:33:20 AM
-- Design Name: 
-- Module Name: Cordic - Behavioral
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
use ieee.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity Cordic is
	GENERIC (
		N: INTEGER := 5 -- number of input bits 
	);
	PORT (
	    start,reset,clk: IN STD_LOGIC;
		x, y, z: IN STD_LOGIC_VECTOR (N+2 DOWNTO 0);
		x_out, y_out, z_out: OUT STD_LOGIC_VECTOR (N+2 DOWNTO 0);
		i: IN INTEGER;
		done: OUT STD_LOGIC
	);
end Cordic;

architecture Behavioral of Cordic is
	TYPE state_type IS (idle, op1, op2, done_s);
	TYPE rom_type IS ARRAY (0 TO 17) OF
	   unsigned(18 DOWNTO 0);
	CONSTANT look_up_table: rom_type := (
		"0011001000111101011", -- arctan(2^(0)) = pi/4 = 0.785398
		"0001110110101011100", -- arctan(2^(-1)) = 0.463647
		"0000111110101101100", -- arctan(2^(-2)) = 0.244978
		"0000011111110101010", -- arctan(2^(-3)) = 0.124354
		"0000001111111110101", -- arctan(2^(-4)) = 0.062418
		"0000000111111111110", -- arctan(2^(-5)) = 0.031239
		"0000000011111111111", -- arctan(2^(-6)) = 0.015623
		"0000000001111111111", -- arctan(2^(-7)) = 0.007812
		"0000000000111111111", -- arctan(2^(-8)) = 0.003906
		"0000000000011111111", -- arctan(2^(-9)) = 0.001953
		"0000000000001111111", -- arctan(2^(-10)) = 0.000976
		"0000000000000111111", -- arctan(2^(-11)) = 0.000488
		"0000000000000011111", -- arctan(2^(-12))
		"0000000000000001111", -- arctan(2^(-13))
		"0000000000000000111", -- arctan(2^(-14))
		"0000000000000000011", -- arctan(2^(-15))
		"0000000000000000001", -- arctan(2^(-16))
		"0000000000000000000"  -- arctan(2^(-17))
	);
	SIGNAL x2_reg, x2_next: unsigned(N+2 DOWNTO 0);
	SIGNAL y2_reg, y2_next: unsigned(N+2 DOWNTO 0);
	SIGNAL z2_reg, z2_next: unsigned(N+2 DOWNTO 0);
	
	SIGNAL mag_y3, mag_x3, mag_z3, y_temp, x_temp: unsigned(N+1 DOWNTO 0);
	SIGNAL z_temp: unsigned(18 DOWNTO 0);
	SIGNAL sigma, sign_x, sign_y, sign_z: STD_LOGIC;
	SIGNAL state_reg, state_next: state_type;


BEGIN
	PROCESS (clk, reset)
	BEGIN
		IF reset = '1' THEN
	--		x_out <= (OTHERS => '0');
	--		z_out <= (OTHERS => '0');
	--		y_out <= (OTHERS => '0');
			state_reg <= idle;
			x2_reg <= (others=>'0');
			y2_reg <= (others=>'0');
			z2_reg <= (others=>'0');
 
		ELSIF (clk'EVENT AND clk = '1') THEN
			x2_reg <= x2_next;
			y2_reg <= y2_next;
			z2_reg <= z2_next;
			state_reg <= state_next;
		END IF;
	END PROCESS;
	
	PROCESS (x, y, i, z, x2_reg, y2_reg, z2_reg, sigma, state_reg, start)
		BEGIN
			x2_next <= x2_reg;
			y2_next <= y2_reg;
			z2_next <= z2_reg;
			-- counter_next<=i;
			state_next <= state_reg;

			CASE state_reg IS
				WHEN idle => 
					IF (start = '1') THEN
						--initialize
						x2_next <= unsigned(x);
						y2_next <= unsigned(y);
						z2_next <= unsigned(z);
						y_temp <= (others=>'0');
						x_temp <= (others=>'0');
						state_next <= op1;
					END IF;
 
				WHEN op1 => 
					sigma <= z2_reg(N+2);
 
					IF (i > (N+1)) THEN
						y_temp <= (OTHERS => '0');
						x_temp <= (OTHERS => '0');
						
                    else
--                        y_temp(N+1-i downto 0) <= '0' & y2_reg(N+1 downto i+1);
                      y_temp(N+1-i downto 0) <= y2_reg(N+1 downto i);
                      y_temp(N+1 downto N+2-i) <= (others=>'0');
                      
--                      x_temp(N+1-i downto 0) <= '0' & x2_reg(N+1 downto i+1);
                      x_temp(N+1-i downto 0) <= x2_reg(N+1 downto i);
                      x_temp(N+1 downto N+2-i) <= (others=>'0');
					END IF;
					--y_temp <= a(4 Downto 0) & mag_y1(N+1 Downto 4);
					--x_temp <= a(to_integer(counter_reg) Downto 0) & mag_x1(N+1 Downto to_integer(counter_reg)-1);
					z_temp <= look_up_table(i);
					state_next <= op2;
 
				WHEN op2 => 
					IF sigma = '0' THEN -- sigma > 0

						----------------- x2 <= x1 - y1*2^-i -----------------
						--  x1>0  ,    y1>0 --
						IF (x2_reg(N+2) = '0' AND y2_reg(N+2) = '0') THEN
							IF (x2_reg(N+1 DOWNTO 0) > y_temp) THEN
								mag_x3 <= x2_reg(N+1 DOWNTO 0) - y_temp;
								x_out(N+2) <= x2_reg(N+2);
							ELSE
								mag_x3 <= y_temp - x2_reg(N+1 DOWNTO 0);
								x_out(N+2) <= y2_reg(N+2);
							END IF;

                        --  x1<0  ,    y1<0 --
						ELSIF (x2_reg(N+2) = '1' AND y2_reg(N+2) = '1') THEN
							IF (x2_reg(N+1 DOWNTO 0) > y_temp) THEN
								mag_x3 <= x2_reg(N+1 DOWNTO 0) - y_temp;
								x_out(N+2) <= x2_reg(N+2);
							ELSE
								mag_x3 <= y_temp - x2_reg(N+1 DOWNTO 0);
								x_out(N+2) <= y2_reg(N+2);
							END IF;
							
						--  x1<0  ,    y1>0 --
						ELSIF (x2_reg(N+2) = '1' AND y2_reg(N+2) = '0') THEN
							mag_x3 <= x2_reg(N+1 DOWNTO 0) + y_temp;
							x_out(N+2) <= '1';
						
						--  x1>0  ,    y1<0 --
						ELSIF (x2_reg(N+2) = '0' AND y2_reg(N+2) = '1') THEN
							mag_x3 <= x2_reg(N+1 DOWNTO 0) + y_temp;
							x_out(N+2) <= '0';

						END IF;
						
						----------------- y2 <= y1 + x1*2^-i -----------------
						--  x1>0  ,    y1>0 --
						IF (y2_reg(N+2) = '0' AND x2_reg(N+2) = '0') THEN
							y_out(N+2) <= '0';
							mag_y3 <= y2_reg(N+1 DOWNTO 0) + x_temp;

                        --  x1<0  ,    y1<0 --
						ELSIF (y2_reg(N+2) = '1' AND x2_reg(N+2) = '1') THEN
							y_out(N+2) <= '1';
							mag_y3 <= y2_reg(N+1 DOWNTO 0) + x_temp;

                        --  x1>0  ,    y1<0 --
						ELSIF (y2_reg(N+2) = '0' AND x2_reg(N+2) = '1') THEN
							IF (y2_reg(N+1 DOWNTO 0) > x_temp) THEN
								mag_y3 <= y2_reg(N+1 DOWNTO 0) - x_temp;
								y_out(N+2) <= y2_reg(N+2);
							ELSE
								mag_y3 <= x_temp - y2_reg(N+1 DOWNTO 0);
								y_out(N+2) <= x2_reg(N+2);
							END IF;
							
						--  x1<0  ,    y1>0 --
						ELSIF (y2_reg(N+2) = '1' AND x2_reg(N+2) = '0') THEN
							IF (y2_reg(N+1 DOWNTO 0) > x_temp) THEN
								mag_y3 <= y2_reg(N+1 DOWNTO 0) - x_temp;
								y_out(N+2) <= y2_reg(N+2);
							ELSE
								mag_y3 <= x_temp - y2_reg(N+1 DOWNTO 0);
								y_out(N+2) <= x2_reg(N+2);
							END IF;
						END IF;
						
						----------------- z2 = z1 - arctan(2^-i) -----------------
						IF (z2_reg(N+2) = '0') THEN
							IF z2_reg(N+1 DOWNTO 0) > z_temp(18 DOWNTO (18-N-1)) THEN
								mag_z3 <= z2_reg(N+1 DOWNTO 0) - z_temp(18 DOWNTO (18-N-1));
								z_out(N+2) <= '0';
							ELSE
								mag_z3 <= z_temp(18 DOWNTO (18-N-1)) - z2_reg(N+1 DOWNTO 0);
								z_out(N+2) <= '1';
							END IF;
						ELSIF (z2_reg(N+2) = '1') THEN
							mag_z3 <= z2_reg(N+1 DOWNTO 0) + z_temp(18 DOWNTO (18-N-1));
							z_out(N+2) <= '1';
						END IF;

				----------------------------------------------------------------------------------
					ELSE -- sigma <0
					    ----------------- x2 <= x1 + y1*2^-i -----------------
						--  x1>0  ,    y1>0 --
						IF (x2_reg(N+2) = '0' AND y2_reg(N+2) = '1') THEN
							IF (x2_reg(N+1 DOWNTO 0) > y_temp) THEN
								mag_x3 <= x2_reg(N+1 DOWNTO 0) - y_temp;
								x_out(N+2) <= x2_reg(N+2);
							ELSE
								mag_x3 <= y_temp - x2_reg(N+1 DOWNTO 0);
								x_out(N+2) <= y2_reg(N+2);
							END IF;
							
						--  x1<0  ,    y1>0 --
						ELSIF (x2_reg(N+2) = '1' AND y2_reg(N+2) = '0') THEN
							IF (x2_reg(N+1 DOWNTO 0) > y_temp) THEN
								mag_x3 <= x2_reg(N+1 DOWNTO 0) + y_temp;
								x_out(N+2) <= x2_reg(N+2);
							ELSE
								mag_x3 <= y_temp - x2_reg(N+1 DOWNTO 0);
								x_out(N+2) <= y2_reg(N+2);
							END IF;
						
						--  x1>0  ,    y1>0 --
						ELSIF (x2_reg(N+2) = '0' AND y2_reg(N+2) = '0') THEN
							mag_x3 <= x2_reg(N+1 DOWNTO 0) + y_temp;
							x_out(N+2) <= '0';
						
						--  x1<0  ,    y1<0 --
						ELSIF (x2_reg(N+2) = '1' AND y2_reg(N+2) = '1') THEN
							mag_x3 <= x2_reg(N+1 DOWNTO 0) + y_temp;
							x_out(N+2) <= '1';
						END IF;
						
						----------------- y2 <= y1 - x1*2^-i -----------------
						--  y1>0  ,    x1<0 --
						IF (y2_reg(N+2) = '0' AND x2_reg(N+2) = '1') THEN
							y_out(N+2) <= '0';
							mag_y3 <= y2_reg(N+1 DOWNTO 0) + x_temp;

                        --  y1<0  ,    x1>0 --
						ELSIF (y2_reg(N+2) = '1' AND x2_reg(N+2) = '0') THEN
							y_out(N+2) <= '1';
							mag_y3 <= y2_reg(N+1 DOWNTO 0) + x_temp;
                        
                        --  y1>0  ,    x1>0 --
						ELSIF (y2_reg(N+2) = '0' AND x2_reg(N+2) = '0') THEN
							IF (y2_reg(N+1 DOWNTO 0) > x_temp) THEN
								mag_y3 <= y2_reg(N+1 DOWNTO 0) - x_temp;
								y_out(N+2) <= y2_reg(N+2);
							ELSE
								mag_y3 <= x_temp - y2_reg(N+1 DOWNTO 0);
								y_out(N+2) <= x2_reg(N+2);
							END IF;
							
						--  y1<0  ,    x1<0 --
						ELSIF (y2_reg(N+2) = '1' AND x2_reg(N+2) = '1') THEN
							IF (y2_reg(N+1 DOWNTO 0) > x_temp) THEN
								mag_y3 <= y2_reg(N+1 DOWNTO 0) - x_temp;
								y_out(N+2) <= y2_reg(N+2);
							ELSE
								mag_y3 <= x_temp - y2_reg(N+1 DOWNTO 0);
								y_out(N+2) <= x2_reg(N+2);
							END IF;
						END IF;

	                    ----------------- z2 = z1 + arctan(2^-i) -----------------
						IF (z2_reg(N+2) = '1') THEN
							IF z2_reg(N+1 DOWNTO 0) > z_temp(18 DOWNTO (18-N-1)) THEN
								mag_z3 <= z2_reg(N+1 DOWNTO 0) - z_temp(18 DOWNTO (18-N-1));
								z_out(N+2) <= '1';
							ELSE
								mag_z3 <= z_temp(18 DOWNTO (18-N-1)) - z2_reg(N+1 DOWNTO 0);
								z_out(N+2) <= '0';
							END IF;

						ELSIF (z2_reg(N+2) = '0') THEN
							mag_z3 <= z2_reg(N+1 DOWNTO 0) + z_temp(18 DOWNTO (18-N-1));
							z_out(N+2) <= '0';
						END IF;
					END IF;
					state_next <= done_s;

				WHEN done_s => 
					x_out(N+1 downto 0) <= std_logic_vector(mag_x3);
					y_out(N+1 downto 0) <= std_logic_vector(mag_y3);
					z_out(N+1 downto 0) <= std_logic_vector(mag_z3);
					done <= '1';
					state_next<=idle;

			END CASE;
			-- sin_out <=std_logic_vector(y2_reg(N+2) & sin(N+18 downto 20));
		END PROCESS;
 
END Behavioral;
