--Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
--Date        : Mon Jan 27 23:42:40 2020
--Host        : DESKTOP-K4MGF7S running 64-bit major release  (build 9200)
--Command     : generate_target myip_v1_0_bfm_1_wrapper.bd
--Design      : myip_v1_0_bfm_1_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity myip_v1_0_bfm_1_wrapper is
  port (
    ACLK : in STD_LOGIC;
    ARESETN : in STD_LOGIC
  );
end myip_v1_0_bfm_1_wrapper;

architecture STRUCTURE of myip_v1_0_bfm_1_wrapper is
  component myip_v1_0_bfm_1 is
  port (
    ACLK : in STD_LOGIC;
    ARESETN : in STD_LOGIC
  );
  end component myip_v1_0_bfm_1;
begin
myip_v1_0_bfm_1_i: component myip_v1_0_bfm_1
     port map (
      ACLK => ACLK,
      ARESETN => ARESETN
    );
end STRUCTURE;
