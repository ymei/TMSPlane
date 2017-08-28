----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 12/18/2013 11:21:31 PM
-- Design Name:
-- Module Name: ten_gig_eth - Behavioral
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


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
LIBRARY UNISIM;
USE UNISIM.VComponents.ALL;

ENTITY ten_gig_eth IS
  PORT (
    REFCLK_P             : IN  std_logic;  -- 156.25MHz for transceiver
    REFCLK_N             : IN  std_logic;
    RESET                : IN  std_logic;
    SFP_TX_P             : OUT std_logic;
    SFP_TX_N             : OUT std_logic;
    SFP_RX_P             : IN  std_logic;
    SFP_RX_N             : IN  std_logic;
    SFP_LOS              : IN  std_logic;  -- loss of receiver signal
    SFP_TX_DISABLE       : OUT std_logic;
    -- clk156.25 domain, clock generated by the core
    CLK156p25            : OUT std_logic;
    PCS_PMA_CORE_STATUS  : OUT std_logic_vector(7 DOWNTO 0);
    TX_STATISTICS_VECTOR : OUT std_logic_vector(25 DOWNTO 0);
    TX_STATISTICS_VALID  : OUT std_logic;
    RX_STATISTICS_VECTOR : OUT std_logic_vector(29 DOWNTO 0);
    RX_STATISTICS_VALID  : OUT std_logic;
    PAUSE_VAL            : IN  std_logic_vector(15 DOWNTO 0);
    PAUSE_REQ            : IN  std_logic;
    TX_IFG_DELAY         : IN  std_logic_vector(7 DOWNTO 0);
    -- emac control interface
    S_AXI_ACLK           : IN  std_logic;
    S_AXI_ARESETN        : IN  std_logic;
    S_AXI_AWADDR         : IN  std_logic_vector(10 DOWNTO 0);
    S_AXI_AWVALID        : IN  std_logic;
    S_AXI_AWREADY        : OUT std_logic;
    S_AXI_WDATA          : IN  std_logic_vector(31 DOWNTO 0);
    S_AXI_WVALID         : IN  std_logic;
    S_AXI_WREADY         : OUT std_logic;
    S_AXI_BRESP          : OUT std_logic_vector(1 DOWNTO 0);
    S_AXI_BVALID         : OUT std_logic;
    S_AXI_BREADY         : IN  std_logic;
    S_AXI_ARADDR         : IN  std_logic_vector(10 DOWNTO 0);
    S_AXI_ARVALID        : IN  std_logic;
    S_AXI_ARREADY        : OUT std_logic;
    S_AXI_RDATA          : OUT std_logic_vector(31 DOWNTO 0);
    S_AXI_RRESP          : OUT std_logic_vector(1 DOWNTO 0);
    S_AXI_RVALID         : OUT std_logic;
    S_AXI_RREADY         : IN  std_logic;
    -- tx_wr_clk domain
    TX_AXIS_FIFO_ARESETN : IN  std_logic;
    TX_AXIS_FIFO_ACLK    : IN  std_logic;
    TX_AXIS_FIFO_TDATA   : IN  std_logic_vector(63 DOWNTO 0);
    TX_AXIS_FIFO_TKEEP   : IN  std_logic_vector(7 DOWNTO 0);
    TX_AXIS_FIFO_TVALID  : IN  std_logic;
    TX_AXIS_FIFO_TLAST   : IN  std_logic;
    TX_AXIS_FIFO_TREADY  : OUT std_logic;
    -- rx_rd_clk domain
    RX_AXIS_FIFO_ARESETN : IN  std_logic;
    RX_AXIS_FIFO_ACLK    : IN  std_logic;
    RX_AXIS_FIFO_TDATA   : OUT std_logic_vector(63 DOWNTO 0);
    RX_AXIS_FIFO_TKEEP   : OUT std_logic_vector(7 DOWNTO 0);
    RX_AXIS_FIFO_TVALID  : OUT std_logic;
    RX_AXIS_FIFO_TLAST   : OUT std_logic;
    RX_AXIS_FIFO_TREADY  : IN  std_logic
  );
END ten_gig_eth;

ARCHITECTURE Behavioral OF ten_gig_eth IS
  -- PCS/PMA
  COMPONENT ten_gig_eth_pcs_pma_wrapper
    PORT (
      refclk_p               : IN  std_logic;
      refclk_n               : IN  std_logic;
      coreclk_out            : OUT std_logic;
      reset                  : IN  std_logic;
      qpll_locked            : OUT std_logic;
      sim_speedup_control    : IN  std_logic := '0';
      xgmii_txd              : IN  std_logic_vector(63 DOWNTO 0);
      xgmii_txc              : IN  std_logic_vector(7 DOWNTO 0);
      xgmii_rxd              : OUT std_logic_vector(63 DOWNTO 0);
      xgmii_rxc              : OUT std_logic_vector(7 DOWNTO 0);
      xgmii_rx_clk           : out std_logic;
      txp                    : OUT std_logic;
      txn                    : OUT std_logic;
      rxp                    : IN  std_logic;
      rxn                    : IN  std_logic;
      mdc                    : IN  std_logic;
      mdio_in                : IN  std_logic;
      mdio_out               : OUT std_logic;
      mdio_tri               : OUT std_logic;
      prtad                  : IN  std_logic_vector(4 DOWNTO 0);
      core_status            : OUT std_logic_vector(7 DOWNTO 0);
      resetdone              : OUT std_logic;
      signal_detect          : IN  std_logic;
      tx_fault               : IN  std_logic;
      tx_disable             : OUT std_logic
    );
  END COMPONENT;

  -- EMAC
  COMPONENT ten_gig_eth_mac_0
    PORT (
      tx_clk0              : IN  std_logic;
      reset                : IN  std_logic;
      tx_axis_aresetn      : IN  std_logic;
      tx_axis_tdata        : IN  std_logic_vector(63 DOWNTO 0);
      tx_axis_tvalid       : IN  std_logic;
      tx_axis_tlast        : IN  std_logic;
      tx_axis_tuser        : IN  std_logic_vector(0 DOWNTO 0);
      tx_ifg_delay         : IN  std_logic_vector(7 DOWNTO 0);
      tx_axis_tkeep        : IN  std_logic_vector(7 DOWNTO 0);
      tx_axis_tready       : OUT std_logic;
      tx_statistics_vector : OUT std_logic_vector(25 DOWNTO 0);
      tx_statistics_valid  : OUT std_logic;
      rx_axis_aresetn      : IN  std_logic;
      rx_axis_tdata        : OUT std_logic_vector(63 DOWNTO 0);
      rx_axis_tvalid       : OUT std_logic;
      rx_axis_tuser        : OUT std_logic;
      rx_axis_tlast        : OUT std_logic;
      rx_axis_tkeep        : OUT std_logic_vector(7 DOWNTO 0);
      rx_statistics_vector : OUT std_logic_vector(29 DOWNTO 0);
      rx_statistics_valid  : OUT std_logic;
      pause_val            : IN  std_logic_vector(15 DOWNTO 0);
      pause_req            : IN  std_logic;
      s_axi_aclk           : IN  std_logic;
      s_axi_aresetn        : IN  std_logic;
      s_axi_awaddr         : IN  std_logic_vector(10 DOWNTO 0);
      s_axi_awvalid        : IN  std_logic;
      s_axi_awready        : OUT std_logic;
      s_axi_wdata          : IN  std_logic_vector(31 DOWNTO 0);
      s_axi_wvalid         : IN  std_logic;
      s_axi_wready         : OUT std_logic;
      s_axi_bresp          : OUT std_logic_vector(1 DOWNTO 0);
      s_axi_bvalid         : OUT std_logic;
      s_axi_bready         : IN  std_logic;
      s_axi_araddr         : IN  std_logic_vector(10 DOWNTO 0);
      s_axi_arvalid        : IN  std_logic;
      s_axi_arready        : OUT std_logic;
      s_axi_rdata          : OUT std_logic_vector(31 DOWNTO 0);
      s_axi_rresp          : OUT std_logic_vector(1 DOWNTO 0);
      s_axi_rvalid         : OUT std_logic;
      s_axi_rready         : IN  std_logic;
      xgmacint             : OUT std_logic;
      tx_dcm_locked        : IN  std_logic;
      xgmii_txd            : OUT std_logic_vector(63 DOWNTO 0);
      xgmii_txc            : OUT std_logic_vector(7 DOWNTO 0);
      rx_clk0              : IN  std_logic;
      rx_dcm_locked        : IN  std_logic;
      xgmii_rxd            : IN  std_logic_vector(63 DOWNTO 0);
      xgmii_rxc            : IN  std_logic_vector(7 DOWNTO 0);
      mdc                  : OUT std_logic;
      mdio_in              : IN  std_logic;
      mdio_out             : OUT std_logic;
      mdio_tri             : OUT std_logic
    );
  END COMPONENT;
  --ATTRIBUTE SYN_BLACK_BOX                          : boolean;
  --ATTRIBUTE SYN_BLACK_BOX OF ten_gig_eth_mac_0     : COMPONENT IS true;
  --ATTRIBUTE BLACK_BOX_PAD_PIN                      : string;
  --ATTRIBUTE BLACK_BOX_PAD_PIN OF ten_gig_eth_mac_0 : COMPONENT IS "tx_clk0,reset,tx_axis_aresetn,tx_axis_tdata[63:0],tx_axis_tvalid,tx_axis_tlast,tx_axis_tuser[0:0],tx_ifg_delay[7:0],tx_axis_tkeep[7:0],tx_axis_tready,tx_statistics_vector[25:0],tx_statistics_valid,rx_axis_aresetn,rx_axis_tdata[63:0],rx_axis_tvalid,rx_axis_tuser,rx_axis_tlast,rx_axis_tkeep[7:0],rx_statistics_vector[29:0],rx_statistics_valid,pause_val[15:0],pause_req,s_axi_aclk,s_axi_aresetn,s_axi_awaddr[10:0],s_axi_awvalid,s_axi_awready,s_axi_wdata[31:0],s_axi_wvalid,s_axi_wready,s_axi_bresp[1:0],s_axi_bvalid,s_axi_bready,s_axi_araddr[10:0],s_axi_arvalid,s_axi_arready,s_axi_rdata[31:0],s_axi_rresp[1:0],s_axi_rvalid,s_axi_rready,xgmacint,tx_dcm_locked,xgmii_txd[63:0],xgmii_txc[7:0],rx_clk0,rx_dcm_locked,xgmii_rxd[63:0],xgmii_rxc[7:0],mdc,mdio_in,mdio_out,mdio_tri";

  -- FIFO
  COMPONENT ten_gig_eth_mac_0_xgmac_fifo
    GENERIC (
      TX_FIFO_SIZE : integer := 512;
      RX_FIFO_SIZE : integer := 512
    );
    PORT (
      ----------------------------------------------------------------
      -- client interface                                           --
      ----------------------------------------------------------------
      -- tx_wr_clk domain
      tx_axis_fifo_aresetn : IN  std_logic;
      tx_axis_fifo_aclk    : IN  std_logic;
      tx_axis_fifo_tdata   : IN  std_logic_vector(63 DOWNTO 0);
      tx_axis_fifo_tkeep   : IN  std_logic_vector(7 DOWNTO 0);
      tx_axis_fifo_tvalid  : IN  std_logic;
      tx_axis_fifo_tlast   : IN  std_logic;
      tx_axis_fifo_tready  : OUT std_logic;
      tx_fifo_full         : OUT std_logic;
      tx_fifo_status       : OUT std_logic_vector(3 DOWNTO 0);
      --rx_rd_clk domain
      rx_axis_fifo_aresetn : IN  std_logic;
      rx_axis_fifo_aclk    : IN  std_logic;
      rx_axis_fifo_tdata   : OUT std_logic_vector(63 DOWNTO 0);
      rx_axis_fifo_tkeep   : OUT std_logic_vector(7 DOWNTO 0);
      rx_axis_fifo_tvalid  : OUT std_logic;
      rx_axis_fifo_tlast   : OUT std_logic;
      rx_axis_fifo_tready  : IN  std_logic;
      rx_fifo_status       : OUT std_logic_vector(3 DOWNTO 0);
      ---------------------------------------------------------------------------
      -- mac transmitter interface                                             --
      ---------------------------------------------------------------------------
      tx_axis_mac_aresetn  : IN  std_logic;
      tx_axis_mac_aclk     : IN  std_logic;
      tx_axis_mac_tdata    : OUT std_logic_vector(63 DOWNTO 0);
      tx_axis_mac_tkeep    : OUT std_logic_vector(7 DOWNTO 0);
      tx_axis_mac_tvalid   : OUT std_logic;
      tx_axis_mac_tlast    : OUT std_logic;
      tx_axis_mac_tready   : IN  std_logic;
      ---------------------------------------------------------------------------
      -- mac receiver interface                                                --
      ---------------------------------------------------------------------------
      rx_axis_mac_aresetn  : IN  std_logic;
      rx_axis_mac_aclk     : IN  std_logic;
      rx_axis_mac_tdata    : IN  std_logic_vector(63 DOWNTO 0);
      rx_axis_mac_tkeep    : IN  std_logic_vector(7 DOWNTO 0);
      rx_axis_mac_tvalid   : IN  std_logic;
      rx_axis_mac_tlast    : IN  std_logic;
      rx_axis_mac_tuser    : IN  std_logic;
      rx_fifo_full         : OUT std_logic
    );
  END COMPONENT;

  SIGNAL clk156p25_i    : std_logic;
  SIGNAL qpll_locked : std_logic;

  SIGNAL xgmii_txd : std_logic_vector(63 DOWNTO 0);
  SIGNAL xgmii_txc : std_logic_vector(7 DOWNTO 0);
  SIGNAL xgmii_rxd : std_logic_vector(63 DOWNTO 0);
  SIGNAL xgmii_rxc : std_logic_vector(7 DOWNTO 0);

  SIGNAL mdc             : std_logic;
  SIGNAL tgemac_mdio_out : std_logic;
  SIGNAL pcspma_mdio_out : std_logic;
  SIGNAL signal_detect   : std_logic;

  SIGNAL drp_req     : std_logic;
  SIGNAL drp_den_o   : std_logic;
  SIGNAL drp_dwe_o   : std_logic;
  SIGNAL drp_daddr_o : std_logic_vector(15 DOWNTO 0);
  SIGNAL drp_di_o    : std_logic_vector(15 DOWNTO 0);
  SIGNAL drp_drdy_o  : std_logic;
  SIGNAL drp_drpdo_o : std_logic_vector(15 DOWNTO 0);

  SIGNAL tx_axis_mac_tdata      : std_logic_vector(63 DOWNTO 0);
  SIGNAL tx_axis_mac_tkeep      : std_logic_vector(7 DOWNTO 0);
  SIGNAL tx_axis_mac_tvalid     : std_logic;
  SIGNAL tx_axis_mac_tlast      : std_logic;
  SIGNAL tx_axis_mac_tready     : std_logic;
  SIGNAL tx_axis_mac_aresetn_i  : std_logic;
  SIGNAL tx_axis_fifo_aresetn_i : std_logic;
  SIGNAL rx_axis_mac_tdata      : std_logic_vector(63 DOWNTO 0);
  SIGNAL rx_axis_mac_tkeep      : std_logic_vector(7 DOWNTO 0);
  SIGNAL rx_axis_mac_tvalid     : std_logic;
  SIGNAL rx_axis_mac_tuser      : std_logic;
  SIGNAL rx_axis_mac_tlast      : std_logic;
  SIGNAL rx_axis_mac_aresetn_i  : std_logic;
  SIGNAL rx_axis_fifo_aresetn_i : std_logic;

  ATTRIBUTE keep                       : string;
  ATTRIBUTE keep OF tx_axis_mac_tdata  : SIGNAL IS "true";
  ATTRIBUTE keep OF tx_axis_mac_tkeep  : SIGNAL IS "true";
  ATTRIBUTE keep OF tx_axis_mac_tvalid : SIGNAL IS "true";
  ATTRIBUTE keep OF tx_axis_mac_tlast  : SIGNAL IS "true";
  ATTRIBUTE keep OF tx_axis_mac_tready : SIGNAL IS "true";
  ATTRIBUTE keep OF rx_axis_mac_tdata  : SIGNAL IS "true";
  ATTRIBUTE keep OF rx_axis_mac_tkeep  : SIGNAL IS "true";
  ATTRIBUTE keep OF rx_axis_mac_tvalid : SIGNAL IS "true";
  ATTRIBUTE keep OF rx_axis_mac_tuser  : SIGNAL IS "true";
  ATTRIBUTE keep OF rx_axis_mac_tlast  : SIGNAL IS "true";

BEGIN
  -- PCS/PMA
  ten_gig_eth_pcs_pma_inst : ten_gig_eth_pcs_pma_wrapper
    PORT MAP (
      refclk_p               => REFCLK_P,
      refclk_n               => REFCLK_N,
      coreclk_out            => clk156p25_i,
      reset                  => RESET,
      qpll_locked            => qpll_locked,
      xgmii_txd              => xgmii_txd,
      xgmii_txc              => xgmii_txc,
      xgmii_rxd              => xgmii_rxd,
      xgmii_rxc              => xgmii_rxc,
      xgmii_rx_clk           => OPEN,
      txp                    => SFP_TX_P,
      txn                    => SFP_TX_N,
      rxp                    => SFP_RX_P,
      rxn                    => SFP_RX_N,
      mdc                    => mdc,
      mdio_in                => tgemac_mdio_out,
      mdio_out               => pcspma_mdio_out,
      mdio_tri               => OPEN,
      prtad                  => (OTHERS => '0'),
      core_status            => PCS_PMA_CORE_STATUS,
      resetdone              => OPEN,
      signal_detect          => signal_detect,
      tx_fault               => '0',
      tx_disable             => SFP_TX_DISABLE
    );
  signal_detect <= NOT SFP_LOS;
  CLK156p25     <= clk156p25_i;

  -- EMAC
  ten_gig_eth_mac_inst : ten_gig_eth_mac_0
    PORT MAP (
      tx_clk0 => clk156p25_i,
      reset   => RESET,

      tx_axis_aresetn      => tx_axis_mac_aresetn_i,
      tx_axis_tdata        => tx_axis_mac_tdata,
      tx_axis_tvalid       => tx_axis_mac_tvalid,
      tx_axis_tlast        => tx_axis_mac_tlast,
      tx_axis_tuser        => (OTHERS => '0'),
      tx_ifg_delay         => TX_IFG_DELAY,
      tx_axis_tkeep        => tx_axis_mac_tkeep,
      tx_axis_tready       => tx_axis_mac_tready,
      tx_statistics_vector => TX_STATISTICS_VECTOR,
      tx_statistics_valid  => TX_STATISTICS_VALID,

      rx_axis_aresetn      => rx_axis_mac_aresetn_i,
      rx_axis_tdata        => rx_axis_mac_tdata,
      rx_axis_tvalid       => rx_axis_mac_tvalid,
      rx_axis_tuser        => rx_axis_mac_tuser,
      rx_axis_tlast        => rx_axis_mac_tlast,
      rx_axis_tkeep        => rx_axis_mac_tkeep,
      rx_statistics_vector => RX_STATISTICS_VECTOR,
      rx_statistics_valid  => RX_STATISTICS_VALID,

      pause_val => PAUSE_VAL,
      pause_req => PAUSE_REQ,

      s_axi_aclk    => S_AXI_ACLK,
      s_axi_aresetn => S_AXI_ARESETN,
      s_axi_awaddr  => S_AXI_AWADDR,
      s_axi_awvalid => S_AXI_AWVALID,
      s_axi_awready => S_AXI_AWREADY,
      s_axi_wdata   => S_AXI_WDATA,
      s_axi_wvalid  => S_AXI_WVALID,
      s_axi_wready  => S_AXI_WREADY,
      s_axi_bresp   => S_AXI_BRESP,
      s_axi_bvalid  => S_AXI_BVALID,
      s_axi_bready  => S_AXI_BREADY,
      s_axi_araddr  => S_AXI_ARADDR,
      s_axi_arvalid => S_AXI_ARVALID,
      s_axi_arready => S_AXI_ARREADY,
      s_axi_rdata   => S_AXI_RDATA,
      s_axi_rresp   => S_AXI_RRESP,
      s_axi_rvalid  => S_AXI_RVALID,
      s_axi_rready  => S_AXI_RREADY,
      xgmacint      => OPEN,

      tx_dcm_locked => qpll_locked,
      xgmii_txd     => xgmii_txd,
      xgmii_txc     => xgmii_txc,
      rx_clk0       => clk156p25_i,
      rx_dcm_locked => qpll_locked,
      xgmii_rxd     => xgmii_rxd,
      xgmii_rxc     => xgmii_rxc,
      mdc           => mdc,
      mdio_in       => pcspma_mdio_out,
      mdio_out      => tgemac_mdio_out,
      mdio_tri      => OPEN
    );

  -- FIFO
  rx_axis_mac_aresetn_i  <= NOT RESET;
  tx_axis_mac_aresetn_i  <= NOT RESET;
  rx_axis_fifo_aresetn_i <= (NOT RESET) AND RX_AXIS_FIFO_ARESETN;
  tx_axis_fifo_aresetn_i <= (NOT RESET) AND TX_AXIS_FIFO_ARESETN;

  ten_gig_eth_mac_fifo_inst : ten_gig_eth_mac_0_xgmac_fifo
    GENERIC MAP (
      TX_FIFO_SIZE => 512,
      RX_FIFO_SIZE => 512
    )
    PORT MAP (
      tx_axis_fifo_aresetn => tx_axis_fifo_aresetn_i,
      tx_axis_fifo_aclk    => TX_AXIS_FIFO_ACLK,
      tx_axis_fifo_tdata   => TX_AXIS_FIFO_TDATA,
      tx_axis_fifo_tkeep   => TX_AXIS_FIFO_TKEEP,
      tx_axis_fifo_tvalid  => TX_AXIS_FIFO_TVALID,
      tx_axis_fifo_tlast   => TX_AXIS_FIFO_TLAST,
      tx_axis_fifo_tready  => TX_AXIS_FIFO_TREADY,
      tx_fifo_full         => OPEN,
      tx_fifo_status       => OPEN,
      rx_axis_fifo_aresetn => rx_axis_fifo_aresetn_i,
      rx_axis_fifo_aclk    => RX_AXIS_FIFO_ACLK,
      rx_axis_fifo_tdata   => RX_AXIS_FIFO_TDATA,
      rx_axis_fifo_tkeep   => RX_AXIS_FIFO_TKEEP,
      rx_axis_fifo_tvalid  => RX_AXIS_FIFO_TVALID,
      rx_axis_fifo_tlast   => RX_AXIS_FIFO_TLAST,
      rx_axis_fifo_tready  => RX_AXIS_FIFO_TREADY,
      rx_fifo_status       => OPEN,
      --MAC Tx Client Interface
      tx_axis_mac_aresetn  => tx_axis_mac_aresetn_i,
      tx_axis_mac_aclk     => clk156p25_i,
      tx_axis_mac_tdata    => tx_axis_mac_tdata,
      tx_axis_mac_tkeep    => tx_axis_mac_tkeep,
      tx_axis_mac_tvalid   => tx_axis_mac_tvalid,
      tx_axis_mac_tlast    => tx_axis_mac_tlast,
      tx_axis_mac_tready   => tx_axis_mac_tready,
      --MAC Rx Client Interface
      rx_axis_mac_aresetn  => rx_axis_mac_aresetn_i,
      rx_axis_mac_aclk     => clk156p25_i,
      rx_axis_mac_tdata    => rx_axis_mac_tdata,
      rx_axis_mac_tkeep    => rx_axis_mac_tkeep,
      rx_axis_mac_tvalid   => rx_axis_mac_tvalid,
      rx_axis_mac_tlast    => rx_axis_mac_tlast,
      rx_axis_mac_tuser    => rx_axis_mac_tuser,
      rx_fifo_full         => OPEN
    );

END Behavioral;