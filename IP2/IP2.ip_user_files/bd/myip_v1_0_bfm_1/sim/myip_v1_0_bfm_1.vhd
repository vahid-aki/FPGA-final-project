--Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
--Date        : Mon Jan 27 23:42:44 2020
--Host        : DESKTOP-K4MGF7S running 64-bit major release  (build 9200)
--Command     : generate_target myip_v1_0_bfm_1.bd
--Design      : myip_v1_0_bfm_1
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity myip_v1_0_bfm_1 is
  port (
    ACLK : in STD_LOGIC;
    ARESETN : in STD_LOGIC
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of myip_v1_0_bfm_1 : entity is "myip_v1_0_bfm_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=myip_v1_0_bfm_1,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=2,numReposBlks=2,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of myip_v1_0_bfm_1 : entity is "myip_v1_0_bfm_1.hwdef";
end myip_v1_0_bfm_1;

architecture STRUCTURE of myip_v1_0_bfm_1 is
  component myip_v1_0_bfm_1_myip_0_0 is
  port (
    s00_axi_awaddr : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s00_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s00_axi_awvalid : in STD_LOGIC;
    s00_axi_awready : out STD_LOGIC;
    s00_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s00_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s00_axi_wvalid : in STD_LOGIC;
    s00_axi_wready : out STD_LOGIC;
    s00_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s00_axi_bvalid : out STD_LOGIC;
    s00_axi_bready : in STD_LOGIC;
    s00_axi_araddr : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s00_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s00_axi_arvalid : in STD_LOGIC;
    s00_axi_arready : out STD_LOGIC;
    s00_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s00_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s00_axi_rvalid : out STD_LOGIC;
    s00_axi_rready : in STD_LOGIC;
    s00_axi_aclk : in STD_LOGIC;
    s00_axi_aresetn : in STD_LOGIC
  );
  end component myip_v1_0_bfm_1_myip_0_0;
  component myip_v1_0_bfm_1_master_0_0 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    m_axi_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awvalid : out STD_LOGIC;
    m_axi_awready : in STD_LOGIC;
    m_axi_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_wvalid : out STD_LOGIC;
    m_axi_wready : in STD_LOGIC;
    m_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_bvalid : in STD_LOGIC;
    m_axi_bready : out STD_LOGIC;
    m_axi_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arvalid : out STD_LOGIC;
    m_axi_arready : in STD_LOGIC;
    m_axi_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rvalid : in STD_LOGIC;
    m_axi_rready : out STD_LOGIC
  );
  end component myip_v1_0_bfm_1_master_0_0;
  signal aclk_net : STD_LOGIC;
  signal aresetn_net : STD_LOGIC;
  signal master_0_M_AXI_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal master_0_M_AXI_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal master_0_M_AXI_ARREADY : STD_LOGIC;
  signal master_0_M_AXI_ARVALID : STD_LOGIC;
  signal master_0_M_AXI_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal master_0_M_AXI_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal master_0_M_AXI_AWREADY : STD_LOGIC;
  signal master_0_M_AXI_AWVALID : STD_LOGIC;
  signal master_0_M_AXI_BREADY : STD_LOGIC;
  signal master_0_M_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal master_0_M_AXI_BVALID : STD_LOGIC;
  signal master_0_M_AXI_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal master_0_M_AXI_RREADY : STD_LOGIC;
  signal master_0_M_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal master_0_M_AXI_RVALID : STD_LOGIC;
  signal master_0_M_AXI_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal master_0_M_AXI_WREADY : STD_LOGIC;
  signal master_0_M_AXI_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal master_0_M_AXI_WVALID : STD_LOGIC;
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of ACLK : signal is "xilinx.com:signal:clock:1.0 CLK.ACLK CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of ACLK : signal is "XIL_INTERFACENAME CLK.ACLK, ASSOCIATED_RESET ARESETN, CLK_DOMAIN myip_v1_0_bfm_1_ACLK, FREQ_HZ 100000000, INSERT_VIP 0, PHASE 0.000";
  attribute X_INTERFACE_INFO of ARESETN : signal is "xilinx.com:signal:reset:1.0 RST.ARESETN RST";
  attribute X_INTERFACE_PARAMETER of ARESETN : signal is "XIL_INTERFACENAME RST.ARESETN, INSERT_VIP 0, POLARITY ACTIVE_LOW";
begin
  aclk_net <= ACLK;
  aresetn_net <= ARESETN;
master_0: component myip_v1_0_bfm_1_master_0_0
     port map (
      aclk => aclk_net,
      aresetn => aresetn_net,
      m_axi_araddr(31 downto 0) => master_0_M_AXI_ARADDR(31 downto 0),
      m_axi_arprot(2 downto 0) => master_0_M_AXI_ARPROT(2 downto 0),
      m_axi_arready => master_0_M_AXI_ARREADY,
      m_axi_arvalid => master_0_M_AXI_ARVALID,
      m_axi_awaddr(31 downto 0) => master_0_M_AXI_AWADDR(31 downto 0),
      m_axi_awprot(2 downto 0) => master_0_M_AXI_AWPROT(2 downto 0),
      m_axi_awready => master_0_M_AXI_AWREADY,
      m_axi_awvalid => master_0_M_AXI_AWVALID,
      m_axi_bready => master_0_M_AXI_BREADY,
      m_axi_bresp(1 downto 0) => master_0_M_AXI_BRESP(1 downto 0),
      m_axi_bvalid => master_0_M_AXI_BVALID,
      m_axi_rdata(31 downto 0) => master_0_M_AXI_RDATA(31 downto 0),
      m_axi_rready => master_0_M_AXI_RREADY,
      m_axi_rresp(1 downto 0) => master_0_M_AXI_RRESP(1 downto 0),
      m_axi_rvalid => master_0_M_AXI_RVALID,
      m_axi_wdata(31 downto 0) => master_0_M_AXI_WDATA(31 downto 0),
      m_axi_wready => master_0_M_AXI_WREADY,
      m_axi_wstrb(3 downto 0) => master_0_M_AXI_WSTRB(3 downto 0),
      m_axi_wvalid => master_0_M_AXI_WVALID
    );
myip_0: component myip_v1_0_bfm_1_myip_0_0
     port map (
      s00_axi_aclk => aclk_net,
      s00_axi_araddr(3 downto 0) => master_0_M_AXI_ARADDR(3 downto 0),
      s00_axi_aresetn => aresetn_net,
      s00_axi_arprot(2 downto 0) => master_0_M_AXI_ARPROT(2 downto 0),
      s00_axi_arready => master_0_M_AXI_ARREADY,
      s00_axi_arvalid => master_0_M_AXI_ARVALID,
      s00_axi_awaddr(3 downto 0) => master_0_M_AXI_AWADDR(3 downto 0),
      s00_axi_awprot(2 downto 0) => master_0_M_AXI_AWPROT(2 downto 0),
      s00_axi_awready => master_0_M_AXI_AWREADY,
      s00_axi_awvalid => master_0_M_AXI_AWVALID,
      s00_axi_bready => master_0_M_AXI_BREADY,
      s00_axi_bresp(1 downto 0) => master_0_M_AXI_BRESP(1 downto 0),
      s00_axi_bvalid => master_0_M_AXI_BVALID,
      s00_axi_rdata(31 downto 0) => master_0_M_AXI_RDATA(31 downto 0),
      s00_axi_rready => master_0_M_AXI_RREADY,
      s00_axi_rresp(1 downto 0) => master_0_M_AXI_RRESP(1 downto 0),
      s00_axi_rvalid => master_0_M_AXI_RVALID,
      s00_axi_wdata(31 downto 0) => master_0_M_AXI_WDATA(31 downto 0),
      s00_axi_wready => master_0_M_AXI_WREADY,
      s00_axi_wstrb(3 downto 0) => master_0_M_AXI_WSTRB(3 downto 0),
      s00_axi_wvalid => master_0_M_AXI_WVALID
    );
end STRUCTURE;
