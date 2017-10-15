//% @file sdm_adc_data_aurora_recv.v
//% @brief Receive external ADC and TMS_SDM data sent through aurora.
//% @author Yuan Mei
//%
//% The rate of ADC and TMS_SDM data words must be of fixed ratio relation.
//% @param[in] NCH_ADC total number of external ADC channels
//% @param[in] ADC_CYC # of CLK cycles per ADC data.  Make sure this is an integer multiple of SDM_CYC.
//% @param[in] NCH_SDM total number of SDMs channels (each channel has 2 OUTs)
//% @param[in] SDM_CYC # of CLK cycles per SDM data

`timescale 1ns / 1ps

module sdm_adc_data_aurora_recv
  #(
    parameter NCH_ADC = 20,
    parameter ADC_CYC = 20,
    parameter NCH_SDM = 19,
    parameter SDM_CYC = 4
    )
   (
    input          RESET,
    input          CLK,
    input          USER_CLK,
    input [63:0]   M_AXI_RX_TDATA,
    input          M_AXI_RX_TVALID,
    output [511:0] DOUT,
    output         DOUT_VALID,
    output reg     FIFO_FULL
    );

   localparam ADC_SDM_CYC_RATIO  = ADC_CYC / SDM_CYC;
   localparam FIFO_DIN64_CYC     = 9;
   reg [ADC_SDM_CYC_RATIO*NCH_SDM*2 + NCH_ADC*16 - 1 : 0] sdm_adc_v;
   reg                                                    sdm_adc_v_valid;

   // aggregate data into sdm_adc_v
   reg [3:0]                                              cnt;
   always @ (posedge USER_CLK or posedge RESET) begin
      if (RESET) begin
         sdm_adc_v        <= 0;
         sdm_adc_v_valid  <= 0;
         cnt              <= 0;
      end
      else begin
         sdm_adc_v_valid <= 0;
         if (M_AXI_RX_TVALID) begin
            cnt <= cnt + 1;
            if (cnt >= FIFO_DIN64_CYC-1) begin
               cnt <= 0;
            end
            sdm_adc_v[63*cnt +: 63] <= M_AXI_RX_TDATA[62:0];
            if (M_AXI_RX_TDATA[63] == 1'b1) begin
               cnt                    <= 0;
               sdm_adc_v[63*cnt +: 6] <= M_AXI_RX_TDATA[5:0];
               sdm_adc_v_valid        <= 1;
            end
         end
      end
   end

   assign DOUT[0 +: ADC_SDM_CYC_RATIO*NCH_SDM*2 + NCH_ADC*16] = sdm_adc_v;
   assign DOUT[511 -: 2]                                      = 2'b00;
   assign DOUT_VALID                                          = sdm_adc_v_valid;

endmodule // sdm_adc_data_aurora_recv
