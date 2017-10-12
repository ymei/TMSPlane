//% @file adc_cnv_sipo
//% @brief Drive ADC (LTC2325-16) conversion and convert Serial dataIn to Parallel dataOut.
//% @author Yuan Mei
//%
//% @param[in] NCH total number of ADC channels

`timescale 1ns / 1ps

module adc_cnv_sipo
  #(
    parameter NCH = 20
    )
   (
    input                   RESET,
    input                   CLK, //% DELAY_* must be synchronous to this clock
    input                   REFCLK, //% REFCLK (200MHz) for IDELAYCTRL
    input [7:0]             DELAY_CHANNEL, //% ADC data input iodelay channel selection
    input [4:0]             DELAY_VALUE, //% ADC data input iodelay value
    input                   DELAY_UPDATE, //% a pulse to update the delay value
    input [3:0]             CLKFF_DIV,
    output                  CLKFF_P,
    output                  CLKFF_N,
    input                   CLK_LPBK_P,
    input                   CLK_LPBK_N,
    output                  CLK_LPBK,
    output                  CNV_N_P,
    output                  CNV_N_N,
    output                  CNV_N,
    input [NCH-1:0]         INPUTS_P,
    input [NCH-1:0]         INPUTS_N,
    output [NCH-1:0]        INPUTS_OUT,
    output reg [NCH*16-1:0] DOUT,
    output reg              DOUT_VALID
    );

   localparam iodelay_group_name  = "adc_iodelay_grp";
   reg                 adc_cnv_n;
   reg                 adc_sample_n;
   wire [NCH-1:0]      adc_sdin_v;
   wire                adc_clkff_tmp, adc_clkff_tmp1;
   wire                adc_clk_lpbk;
   reg                 adc_clkff_oe;
   reg [4:0]           cnt;
   reg [3:0]           idx;
   reg [15:0]          sdo_v[NCH-1:0];

   (* IODELAY_GROUP = iodelay_group_name *) // Specifies group name for associated IDELAYs/ODELAYs and IDELAYCTRL
   IDELAYCTRL adc_idelayctrl_inst
     (
      .RDY(),          // 1-bit output: Ready output
      .REFCLK(REFCLK), // 1-bit input: Reference clock input
      .RST(RESET)      // 1-bit input: Active high reset input
      );
   diffiodelay
     #(
       .NINPUT(NCH+1),
       .NOUTPUT(1),
       .INPUT_DIFF_TERM("TRUE"),
       .IODELAY_GROUP_NAME(iodelay_group_name)
       )
   adc_diffiodelay_inst
      (
       .RESET(RESET),
       .CLK(CLK), //% DELAY_* must be synchronous to this clock
       .DELAY_CHANNEL(DELAY_CHANNEL),
       .DELAY_VALUE(DELAY_VALUE),
       .DELAY_UPDATE(DELAY_UPDATE), //% a pulse to update the delay value
       .INPUTS_OUT({adc_clk_lpbk, adc_sdin_v}),
       .INPUTS_P({CLK_LPBK_P, INPUTS_P}),
       .INPUTS_N({CLK_LPBK_N, INPUTS_N}),
       .OUTPUTS_IN(0),
       .OUTPUTS_P(),
       .OUTPUTS_N()
       );
   assign INPUTS_OUT[NCH-1:0] = adc_sdin_v;

   // clkff
   clk_div
     #(
       .WIDTH(32),
       .PBITS(4)
       )
   adc_clkff_div_inst
     (
      .RESET(RESET),
      .CLK(CLK),
      .DIV(CLKFF_DIV),
      .CLK_DIV(adc_clkff_tmp)
    );
   // clock forwarding
   ODDR
     #(
       .DDR_CLK_EDGE("OPPOSITE_EDGE"), // "OPPOSITE_EDGE" or "SAME_EDGE"
       .INIT(1'b0),    // Initial value of Q: 1'b0 or 1'b1
       .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC"
       )
   adc_clkff_forward_inst
     (
      .Q(adc_clkff_tmp1),   // 1-bit DDR output
      .C(adc_clkff_tmp),    // 1-bit clock input
      .CE(1), // 1-bit clock enable input
      .D1(1), // 1-bit data input (positive edge)
      .D2(0), // 1-bit data input (negative edge)
      .R(~adc_clkff_oe), // 1-bit reset
      .S(0)              // 1-bit set
      );
   OBUFDS
     #(
       .IOSTANDARD("DEFAULT"), // Specify the output I/O standard
       .SLEW("SLOW")           // Specify the output slew rate
       )
   adc_clkff_obufds_inst
     (
      .O(CLKFF_P),       // Diff_p output (connect directly to top-level port)
      .OB(CLKFF_N),      // Diff_n output (connect directly to top-level port)
      .I(adc_clkff_tmp1) // Buffer input
      );
   // clk_lpbk
   assign CLK_LPBK = adc_clk_lpbk;
   // adc_cnv_n
   OBUFDS
     #(
       .IOSTANDARD("DEFAULT"), // Specify the output I/O standard
       .SLEW("SLOW")           // Specify the output slew rate
       )
   adc_cnv_n_obufds_inst
     (
      .O(CNV_N_P),    // Diff_p output (connect directly to top-level port)
      .OB(CNV_N_N),   // Diff_n output (connect directly to top-level port)
      .I(adc_cnv_n)   // Buffer input
      );
   assign CNV_N = adc_cnv_n;

   always @ (posedge adc_clkff_tmp or posedge RESET) begin
      if (RESET) begin
         cnt          <= 0;
         adc_cnv_n    <= 1;
         adc_sample_n <= 1;
         adc_clkff_oe <= 0;
      end
      else begin
         cnt <= cnt + 1;
         if (cnt>=19) begin
            cnt <= 0;
         end
         adc_cnv_n <= 0;
         if (0<=cnt && cnt<3) begin
            adc_cnv_n <= 1;
         end
         adc_sample_n <= 0;
         if (0<cnt && cnt<3) begin
            adc_sample_n <= 1;
         end
         adc_clkff_oe <= 1;
         if ((0<=cnt && cnt<2) || cnt>=2+16) begin
            adc_clkff_oe <= 0;
         end
      end
   end

   // sample in CLK domain
   reg adc_sample_n_prev;
   always @ (posedge CLK or posedge RESET) begin
      if (RESET) begin
         adc_sample_n_prev <= 0;
      end
      else begin
         adc_sample_n_prev <= adc_sample_n;
         DOUT_VALID        <= 0;
         if (adc_sample_n_prev == 0 && adc_sample_n == 1) begin // rising edge
            DOUT_VALID     <= 1;
         end
      end
   end

   genvar i;
   generate
      for (i=0; i<NCH; i=i+1) begin
         always @ (posedge adc_clk_lpbk or posedge adc_sample_n) begin
            if (adc_sample_n) begin
               idx <= 15;
            end
            else begin
               sdo_v[i][idx] <= adc_sdin_v[i];
               idx           <= idx - 1;
            end
         end
         always @ (posedge CLK or posedge RESET) begin
            if (RESET) begin
            end
            else begin
               if (adc_sample_n_prev == 0 && adc_sample_n == 1) begin // rising edge
                  DOUT[16*i+15:16*i] <= sdo_v[i];
               end
            end
         end
      end
   endgenerate

endmodule // adc_cnv_sipo
