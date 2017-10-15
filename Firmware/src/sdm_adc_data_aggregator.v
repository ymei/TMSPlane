//% @file sdm_adc_data_aggregator.v
//% @brief Aggregate external ADC and TMS_SDM data to send through aurora.
//% @author Yuan Mei
//%
//% The rate of ADC and TMS_SDM data words must be of fixed ratio relation.
//% @param[in] NCH_ADC total number of external ADC channels
//% @param[in] ADC_CYC # of CLK cycles per ADC data.  Make sure this is an integer multiple of SDM_CYC.
//% @param[in] NCH_SDM total number of SDMs channels (each channel has 2 OUTs)
//% @param[in] SDM_CYC # of CLK cycles per SDM data

`timescale 1ns / 1ps

module sdm_adc_data_aggregator
  #(
    parameter NCH_ADC = 20,
    parameter ADC_CYC = 20,
    parameter NCH_SDM = 19,
    parameter SDM_CYC = 4
    )
   (
    input                  RESET,
    input                  CLK,
    input [NCH_ADC*16-1:0] ADC_Q,
    input                  ADC_Q_VALID,
    input [NCH_SDM*2-1:0]  SDM_Q,
    input                  SDM_Q_VALID,
    output [511:0]         DOUT,
    output                 DOUT_VALID,
    input                  USER_CLK,
    output [63:0]          S_AXI_TX_TDATA,
    output                 S_AXI_TX_TVALID,
    input                  S_AXI_TX_TREADY,
    output reg             FIFO_FULL
    );

   localparam ADC_SDM_CYC_RATIO  = ADC_CYC / SDM_CYC;
   localparam FIFO_DIN64_CYC     = 9;
   reg [ADC_SDM_CYC_RATIO*NCH_SDM*2-1:0]                  sdm_q_v;
   reg [ADC_SDM_CYC_RATIO*NCH_SDM*2 + NCH_ADC*16 - 1 : 0] sdm_adc_v;
   reg                                                    sdm_adc_v_valid, sdm_adc_v_valid1;

   // aggregate data into sdm_adc_v
   reg [3:0]                                              cnt, cnt3;
   always @ (posedge CLK or posedge RESET) begin
      if (RESET) begin
         sdm_q_v          <= 0;
         sdm_adc_v        <= 0;
         sdm_adc_v_valid  <= 0;
         sdm_adc_v_valid1 <= 0;
         cnt              <= 0;
         cnt3             <= 0;
      end
      else begin
         cnt3 <= cnt3 + 1;
         if (cnt3 >= SDM_CYC-1) begin
            cnt3 <= 0;
         end
         sdm_adc_v_valid <= 0;
         if (ADC_Q_VALID) begin
            cnt <= 0;
         end
         if (/* SDM_Q_VALID */ cnt3 == 0) begin // This will work even if SDM is not running.
            sdm_q_v[cnt * NCH_SDM*2 +: NCH_SDM*2] <= SDM_Q;
            cnt                                   <= cnt + 1;
            if (cnt == ADC_SDM_CYC_RATIO-1) begin
               cnt             <= 0;
               sdm_adc_v_valid <= 1;
            end
         end
         sdm_adc_v_valid1 <= 0;
         if (sdm_adc_v_valid) begin
            sdm_adc_v_valid1                                     <= 1;
            sdm_adc_v[NCH_ADC*16-1:0]                            <= ADC_Q;
            sdm_adc_v[NCH_ADC*16 +: ADC_SDM_CYC_RATIO*NCH_SDM*2] <= sdm_q_v;
         end
      end
   end
   assign DOUT[0 +: ADC_SDM_CYC_RATIO*NCH_SDM*2 + NCH_ADC*16] = sdm_adc_v;
   assign DOUT[511 -: 2]                                      = 2'b00;
   assign DOUT_VALID                                          = sdm_adc_v_valid1;

   // write into fifo
   reg   [63:0] fifo_din;
   reg          fifo_wr_en;
   wire         fifo_rd_en;
   wire         fifo_empty, fifo_full;
   fifo64x fifo64x_inst // FWFT fifo
     (
      .rst(RESET),
      .wr_clk(CLK),
      .rd_clk(USER_CLK),
      .din(fifo_din),
      .wr_en(fifo_wr_en),
      .rd_en(fifo_rd_en),
      .dout(S_AXI_TX_TDATA),
      .full(fifo_full),
      .empty(fifo_empty)
      );
   assign fifo_rd_en       = S_AXI_TX_TREADY & (~fifo_empty);
   assign S_AXI_TX_TVALID  = fifo_rd_en;

   reg [3:0]    cnt1, cnt2;
   reg          first_data;
   always @ (posedge CLK or posedge RESET) begin
      if (RESET) begin
         cnt1       <= 0;
         first_data <= 0;
         fifo_din   <= 0;
         fifo_wr_en <= 0;
         cnt2       <= 0;
         FIFO_FULL  <= 0;
      end
      else begin
         // latch on fifo_full condition
         if (cnt2<15) begin
            cnt2 <= cnt2 + 1;
         end else begin
            if (fifo_full) begin
               FIFO_FULL <= 1;
            end
            if (sdm_adc_v_valid1 && (!first_data)) begin
               cnt1       <= 0;
               first_data <= 1;
            end
            if (first_data) begin
               cnt1       <= cnt1 + 1;
               fifo_wr_en <= 1;
            end
            if (cnt1 >= FIFO_DIN64_CYC) begin
               cnt1       <= 0;
               first_data <= 0;
               fifo_wr_en <= 0;
            end
            if (cnt1 < FIFO_DIN64_CYC) begin
               fifo_din    <= {1'b0, sdm_adc_v[63*cnt1 +: 63]};
               if (cnt1 == FIFO_DIN64_CYC-1) begin
                  fifo_din <= {1'b1, 57'hb72ea61d950c840, sdm_adc_v[63*cnt1 +: 6]};
               end
            end
         end
      end
   end

endmodule // sdm_adc_data_aggregator
