----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/24/2020 04:30:58 PM
-- Design Name: 
-- Module Name: sin_cos - Behavioral
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
use ieee.numeric_std.All;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity sin_cos is
     Generic (
        N: integer := 17;   --tedade bit zavie voroodi
        iteration_num: integer := 16 
     );
     
     Port (
        start: In STD_LOGIC;
        beta: In STD_LOGIC_VECTOR (N-1 downto 0);
--        sss: out STD_LOGIC_VECTOR (N+2 downto 0);
        result_ready: Out STD_LOGIC;
        clk, reset: In STD_LOGIC;
        sin_out: Out std_logic_vector(N-1 downto 0);
        cos_out: Out std_logic_vector(N-1 downto 0)
     );
end sin_cos;

architecture Behavioral of sin_cos is
  
 constant K: unsigned (17 downto 0 ):= "100110110111000100"; -- K = 0.6072
-- signal sin_calc :unsigned(N+19 Downto 0);

-- signal i:std_logic_vector;
    TYPE ram_type IS ARRAY (0 TO iteration_num) OF
        std_logic_vector(N+2 DOWNTO 0);
    signal x_ram: ram_type;
    signal y_ram: ram_type;
    signal z_ram: ram_type;
    signal done_reg: std_logic_vector(iteration_num downto 0);
    signal z0: std_logic_vector(N+2 downto 0) ; 
    signal x0: std_logic_vector(N+2 downto 0):= (N=>'1', others=>'0');
    signal y0: std_logic_vector(N+2 downto 0):= (others=>'0');
    signal sin_temp: unsigned(N+20 downto 0);
    signal cos_temp: unsigned(N+20 downto 0);
    signal y_temp: unsigned(N+2 downto 0);
    signal x_temp: unsigned(N+2 downto 0);
    
begin
    
    z0 <= beta & "000"                 when (unsigned(beta(N-2 downto 0)) > "0" AND 
                                             unsigned(beta(N-2 downto 0)) <= "0110010010000111")          else
          (beta(N-1) & std_logic_vector(unsigned(beta(N-2 downto 0)) - "0110010010000111") & "000") 
                                       when (unsigned(beta(N-2 downto 0)) > "0110010010000111" AND 
                                             unsigned(beta(N-2 downto 0)) <= "1100100100001111");
    
    c0:entity work.cordic(behavioral)
        generic map(N => N)
        port map (x=>x0 ,y=>y0 ,z=>z0 ,x_out=>x_ram(0)  ,y_out=>y_ram(0), z_out=>z_ram(0),
                    i=>0, done=>done_reg(0), start=>start, reset=>reset, clk=>clk);
                    
    x:for j in 1 to iteration_num  generate 
        c: entity work.cordic(behavioral) 
            generic map(N => N)
            port map (x=>x_ram(j-1), y=>y_ram(j-1), z=>z_ram(j-1), x_out=>x_ram(j), y_out=>y_ram(j), z_out=>z_ram(j),
                        i=>j, done=>done_reg(j), start=>done_reg(j-1), reset=>reset, clk=>clk);
      end generate;

    result_ready <= done_reg(iteration_num);
    y_temp <= unsigned(y_ram(iteration_num));
    x_temp <= unsigned(x_ram(iteration_num));
--    sin_temp <= y_temp(N+2) & (K * y_temp(N+1 downto 0));
--    cos_temp <= x_temp(N+2) & (K * x_temp(N+1 downto 0));
--    sin_out <= std_logic_vector(sin_temp(N+20 downto 21));
--    cos_out <= std_logic_vector(cos_temp(N+20 downto 21));
    sin_temp <= '0' & (K * y_temp(N+1 downto 0));
    cos_temp <= '0' & (K * x_temp(N+1 downto 0));
    sin_out <= y_temp(N+2) & std_logic_vector(sin_temp(N+19 downto 21));
    cos_out <= x_temp(N+2) & std_logic_vector(cos_temp(N+19 downto 21));
--    sin_out <= std_logic_vector((y_temp(N+2) & (K * y_temp(N+1 downto 0)))(N+20 downto 21));
    
end Behavioral;