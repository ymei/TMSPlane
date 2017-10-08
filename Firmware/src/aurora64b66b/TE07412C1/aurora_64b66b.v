//% @file aurora_64b66b.v
//% @brief Aurora 64B66B interface
//% @author Yuan Mei
//%
//% Wrap around coregen to provide a clean interface.
`timescale 1ns / 1ps

module aurora_64b66b
  #(
    )
   (
    input         RESET, //% module reset
    input         SYS_CLK,
    input         MGT_REFCLK_P,
    input         MGT_REFCLK_N,
    // Data interfaces are synchronous to USER_CLK
    output        USER_CLK,
    output        MGT_REFCLK_BUFG_OUT,
    // TX AXI4 interface
    input [0:63]  S_AXI_TX_TDATA,
    input         S_AXI_TX_TVALID,
    output        S_AXI_TX_TREADY,
    // RX AXI4 interface
    output [0:63] M_AXI_RX_TDATA,
    output        M_AXI_RX_TVALID,
    // User flow control (UFC) TX
    input         UFC_TX_REQ,
    input [0:63]  S_AXI_UFC_TX_TDATA,
    input [0:7]   UFC_TX_MS,
    input         S_AXI_UFC_TX_TVALID,
    output        S_AXI_UFC_TX_TREADY,
    // UFC RX
    output [0:63] M_AXI_UFC_RX_TDATA,
    output [0:7]  M_AXI_UFC_RX_TKEEP,
    output        M_AXI_UFC_RX_TLAST,
    output        M_AXI_UFC_RX_TVALID,
    output        UFC_IN_PROGRESSn,
    // GTX pins
    input         RXP,
    input         RXN,
    output        TXP,
    output        TXN,
    // Status
    output [15:0] STATUS
    );

   wire                        init_clk_out_i;
   wire                        user_clk_out_i;
   wire                        sync_clk_out_i;
   wire                        power_down_i;
   wire [2:0]                  loopback_i;
   wire                        pma_init_i;
   wire                        gt_pll_lock_i;
   wire                        channel_up_i;
   wire                        lane_up_i;
   //
   wire                        drp_clk_i;
   wire [8:0]                  drpaddr_in_i;
   wire [15:0]                 drpdi_in_i;
   wire [15:0]                 drpdo_out_i;
   wire                        drprdy_out_i;
   wire                        drpen_in_i;
   wire                        drpwe_in_i;
   wire [7:0]                  qpll_drpaddr_in_i;
   wire [15:0]                 qpll_drpdi_in_i;
   wire                        qpll_drpen_in_i;
   wire                        qpll_drpwe_in_i;
   wire [15:0]                 qpll_drpdo_out_i;
   wire                        qpll_drprdy_out_i;
   wire                        init_clk_i;
   wire                        link_reset_out_i;
   wire                        pll_not_locked_i;
   wire                        sys_reset_out_i;

   // Clocks
   assign USER_CLK             = user_clk_out_i;
   assign init_clk_i           = SYS_CLK;
   assign drp_clk_i            = SYS_CLK;
   // System Interface
   assign loopback_i           = 3'b000;
   assign power_down_i         = 1'b0;
   assign gt_rxcdrovrden_i     = 1'b0;
   assign pma_init_i           = 1'b0;
   // GT Native DRP Interface
   assign drpaddr_in_i         = 9'h0;
   assign drpdi_in_i           = 16'h0;
   assign drpwe_in_i           = 1'b0;
   assign drpen_in_i           = 1'b0;
   // GTXE2 COMMON DRP
   assign qpll_drpaddr_in_i    = 8'h0;
   assign qpll_drpdi_in_i      = 16'h0;
   assign qpll_drpen_in_i      = 1'b0;
   assign qpll_drpwe_in_i      = 1'b0;
   // Status
   assign STATUS[2:0]          = {gt_pll_lock_i, lane_up_i, channel_up_i};

   aurora_64b66b_0_support aurora_64b66b_0_support_inst
     (
      // TX AXI4-S Interface
      .s_axi_tx_tdata      (S_AXI_TX_TDATA),
      .s_axi_tx_tvalid     (S_AXI_TX_TVALID),
      .s_axi_tx_tready     (S_AXI_TX_TREADY),
      // RX AXI4-S Interface
      .m_axi_rx_tdata      (M_AXI_RX_TDATA),
      .m_axi_rx_tvalid     (M_AXI_RX_TVALID),
      // UFC Interface
      .ufc_tx_req          (UFC_TX_REQ),
      .ufc_tx_ms           (UFC_TX_MS),
      .s_axi_ufc_tx_tdata  (S_AXI_UFC_TX_TDATA),
      .s_axi_ufc_tx_tvalid (S_AXI_UFC_TX_TVALID),
      .s_axi_ufc_tx_tready (S_AXI_UFC_TX_TREADY),
      // RX User Flow Control Interface
      .m_axi_ufc_rx_tdata  (M_AXI_UFC_RX_TDATA),
      .m_axi_ufc_rx_tkeep  (M_AXI_UFC_RX_TKEEP),
      .m_axi_ufc_rx_tlast  (M_AXI_UFC_RX_TLAST),
      .m_axi_ufc_rx_tvalid (M_AXI_UFC_RX_TVALID),
      .ufc_in_progress     (UFC_IN_PROGRESSn),
      // GT Serial I/O
      .rxp                 (RXP),
      .rxn                 (RXN),
      .txp                 (TXP),
      .txn                 (TXN),
      //GT Reference Clock Interface
      .gt_refclk1_p        (MGT_REFCLK_P),
      .gt_refclk1_n        (MGT_REFCLK_N),
      .gt_refclk1_out      (MGT_REFCLK_BUFG_OUT),
      // Error Detection Interface
      .hard_err            (hard_err_i),
      .soft_err            (soft_err_i),
      // Status
      .channel_up          (channel_up_i),
      .lane_up             (lane_up_i),
      // System Interface
      .init_clk_out        (init_clk_out_i),
      .user_clk_out        (user_clk_out_i),
      .sync_clk_out        (sync_clk_out_i),
      .reset_pb            (RESET),
      .gt_rxcdrovrden_in   (gt_rxcdrovrden_i),
      .power_down          (power_down_i),
      .loopback            (loopback_i),
      .pma_init            (pma_init_i),
      .gt_pll_lock         (gt_pll_lock_i),
      //---------------------- GT DRP Ports ----------------------
      .drp_clk_in          (drp_clk_i),
      .drpaddr_in          (drpaddr_in_i),
      .drpdi_in            (drpdi_in_i),
      .drpdo_out           (drpdo_out_i),
      .drprdy_out          (drprdy_out_i),
      .drpen_in            (drpen_in_i),
      .drpwe_in            (drpwe_in_i),
      //---------------------- GTXE2 COMMON DRP Ports ----------------------
      /* ymei: uncomment if qpll is used, e.g. @ 10Gpbs rate
      .qpll_drpaddr_in     (qpll_drpaddr_in_i),
      .qpll_drpdi_in       (qpll_drpdi_in_i),
      .qpll_drpdo_out      (qpll_drpdo_out_i),
      .qpll_drprdy_out     (qpll_drprdy_out_i),
      .qpll_drpen_in       (qpll_drpen_in_i),
      .qpll_drpwe_in       (qpll_drpwe_in_i),
       */
      //
      .init_clk            (init_clk_i),
      .link_reset_out      (link_reset_out_i),
      .mmcm_not_locked_out (pll_not_locked_i),
      .sys_reset_out       (sys_reset_out_i),
      .tx_out_clk          (tx_out_clk_i)
      );
endmodule
