//% @file tms_sdm_recv.v
//% @brief TMS Sigma-Delta Modulator (SDM) data receiver
//% @author Yuan Mei
//%
//% @param[in] NCH total number of SDMs

`timescale 1ns / 1ps

module tms_sdm_recv
  #(
    parameter NCH = 19
    )
   (
    input                  RESET,
    input                  CLK, //% DELAY_* must be synchronous to this clock
    input                  REFCLK, //% REFCLK (200MHz) for IDELAYCTRL
    input [7:0]            DELAY_CHANNEL, //% input iodelay channel selection
    input [4:0]            DELAY_VALUE, //% input iodelay value
    input                  DELAY_UPDATE, //% a pulse to update the delay value
    input [3:0]            CLKFF_DIV,
    output                 CLKFF_P,
    output                 CLKFF_N,
    input                  CLK_LPBK_P,
    input                  CLK_LPBK_N,
    output                 CLK_LPBK,
    input [NCH-1:0]        SDM_OUT1_P,
    input [NCH-1:0]        SDM_OUT1_N,
    input [NCH-1:0]        SDM_OUT2_P,
    input [NCH-1:0]        SDM_OUT2_N,
    output reg [NCH*2-1:0] DOUT,
    output reg             DOUT_VALID
    );

   localparam iodelay_group_name = "tms_iodelay_grp";
   wire             tms_sdm_clkff_tmp, tms_sdm_clkff_tmp1, tms_sdm_clkff_tmp2;
   (* KEEP = "TRUE" *)
   wire             tms_sdm_clk_lpbk;
   wire [NCH*2-1:0] tms_sdm_out_v;
   (* ASYNC_REG = "TRUE" *)
   reg [NCH*2-1:0]  tms_sdm_out_v1;
   wire [NCH*2-1:0] tms_sdm_out_p, tms_sdm_out_n;

   (* IODELAY_GROUP = iodelay_group_name *) // Specifies group name for associated IDELAYs/ODELAYs and IDELAYCTRL
   IDELAYCTRL tms_sdm_idelayctrl_inst
     (
      .RDY(),          // 1-bit output: Ready output
      .REFCLK(REFCLK), // 1-bit input: Reference clock input
      .RST(RESET)      // 1-bit input: Active high reset input
      );
   diffiodelay
     #(
       .NINPUT(NCH*2+1),
       .NOUTPUT(1),
       .INPUT_DIFF_TERM("TRUE"),
       .IODELAY_GROUP_NAME(iodelay_group_name)
       )
   tms_sdm_diffiodelay_inst
      (
       .RESET(RESET),
       .CLK(CLK), //% DELAY_* must be synchronous to this clock
       .DELAY_CHANNEL(DELAY_CHANNEL),
       .DELAY_VALUE(DELAY_VALUE),
       .DELAY_UPDATE(DELAY_UPDATE), //% a pulse to update the delay value
       .INPUTS_OUT({tms_sdm_clk_lpbk, tms_sdm_out_v}),
       .INPUTS_P({CLK_LPBK_P, tms_sdm_out_p}),
       .INPUTS_N({CLK_LPBK_N, tms_sdm_out_n}),
       .OUTPUTS_IN(0),
       .OUTPUTS_P(),
       .OUTPUTS_N()
       );
   genvar i;
   generate
      for (i=0; i<NCH; i=i+1) begin
         assign tms_sdm_out_p[i*2]   = SDM_OUT1_P[i];
         assign tms_sdm_out_p[i*2+1] = SDM_OUT2_P[i];
         assign tms_sdm_out_n[i*2]   = SDM_OUT1_N[i];
         assign tms_sdm_out_n[i*2+1] = SDM_OUT2_N[i];
      end
   endgenerate

   // clkff
   clk_div
     #(
       .WIDTH(32),
       .PBITS(4)
       )
   tms_sdm_clkff_div_inst
     (
      .RESET(RESET),
      .CLK(CLK),
      .DIV(CLKFF_DIV),
      .CLK_DIV(tms_sdm_clkff_tmp)
    );
   assign tms_sdm_clkff_tmp1 = (CLKFF_DIV==0 ? 0 : tms_sdm_clkff_tmp);
   // clock forwarding
   ODDR
     #(
       .DDR_CLK_EDGE("OPPOSITE_EDGE"), // "OPPOSITE_EDGE" or "SAME_EDGE"
       .INIT(1'b0),    // Initial value of Q: 1'b0 or 1'b1
       .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC"
       )
   tms_sdm_clkff_forward_inst
     (
      .Q(tms_sdm_clkff_tmp2),   // 1-bit DDR output
      .C(tms_sdm_clkff_tmp1),   // 1-bit clock input
      .CE(1), // 1-bit clock enable input
      .D1(1), // 1-bit data input (positive edge)
      .D2(0), // 1-bit data input (negative edge)
      .R(0),  // 1-bit reset
      .S(0)   // 1-bit set
      );
   OBUFDS
     #(
       .IOSTANDARD("DEFAULT"), // Specify the output I/O standard
       .SLEW("SLOW")           // Specify the output slew rate
       )
   tms_sdm_clkff_obufds_inst
     (
      .O(CLKFF_P),       // Diff_p output (connect directly to top-level port)
      .OB(CLKFF_N),      // Diff_n output (connect directly to top-level port)
      .I(tms_sdm_clkff_tmp2) // Buffer input
      );
   // clk_lpbk
   assign CLK_LPBK = tms_sdm_clk_lpbk;
   // sample using loop-back clock
   always @ (posedge tms_sdm_clk_lpbk or posedge RESET) begin
      if (RESET) begin
         tms_sdm_out_v1 <= 0;
      end
      else begin
         tms_sdm_out_v1 <= tms_sdm_out_v;
      end
   end
   // sample in CLK domain
   (* ASYNC_REG = "TRUE" *)
   reg dout_valid_prev;
   always @ (posedge CLK or posedge RESET) begin
      if (RESET) begin
         dout_valid_prev <= 0;
         DOUT            <= 0;
         DOUT_VALID      <= 0;
      end
      else begin
         DOUT            <= tms_sdm_out_v1;
         dout_valid_prev <= tms_sdm_clk_lpbk;
         DOUT_VALID <= 0;
         if (!dout_valid_prev && tms_sdm_clk_lpbk) begin
            DOUT_VALID <= 1;
         end
      end
   end

endmodule // tms_sdm_recv
