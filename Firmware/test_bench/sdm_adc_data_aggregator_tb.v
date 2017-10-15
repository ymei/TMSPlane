//% @file sdm_adc_data_aggregator_tb.v
//% @brief test bench of sdm_adc_data_aggregator.
//% @author Yuan Mei
//%
`timescale 1ns / 1ps

module sdm_adc_data_aggregator_tb
  #(
    parameter NCH_ADC = 20,
    parameter ADC_CYC = 20,
    parameter NCH_SDM = 19,
    parameter SDM_CYC = 4
    )
   ();

   reg                  reset;
   reg                  clk;
   reg [NCH_ADC*16-1:0] adc_q;
   reg                  adc_q_valid;
   reg [NCH_SDM*2-1:0]  sdm_q;
   reg                  sdm_q_valid;
   wire [511:0]         dout;
   wire                 dout_valid;
   reg                  user_clk;
   wire [63:0]          axi_tx_tdata;
   reg                  axi_tx_tready;
   wire                 axi_tx_tvalid;
   wire                 fifo_full;

   sdm_adc_data_aggregator
     #(
       .NCH_ADC(NCH_ADC),
       .ADC_CYC(ADC_CYC),
       .NCH_SDM(NCH_SDM),
       .SDM_CYC(SDM_CYC)
       )
   sdm_adc_data_aggregator_inst
     (
      .RESET(reset),
      .CLK(clk),
      .ADC_Q(adc_q),
      .ADC_Q_VALID(adc_q_valid),
      .SDM_Q(sdm_q),
      .SDM_Q_VALID(sdm_q_valid),
      .DOUT(dout),
      .DOUT_VALID(dout_valid),
      .USER_CLK(user_clk),
      .S_AXI_TX_TDATA(axi_tx_tdata),
      .S_AXI_TX_TVALID(axi_tx_tvalid),
      .S_AXI_TX_TREADY(axi_tx_tready),
      .FIFO_FULL(fifo_full)
    );

   //initial begin
   //$dumpfile("fifo_over_ufc.vcd");
   //$dumpvars(0, fifo_over_ufc);
   //end

   initial begin
      clk         = 0;
      reset       = 0;
      #16 reset   = 1;
      #36 reset   = 0;
   end
   always #5 clk = ~clk;

   initial begin
      adc_q_valid    = 0;
      sdm_q_valid    = 0;
      user_clk       = 0;
      axi_tx_tready  = 1;
   end
   always #2.5 user_clk = ~user_clk;

   // emulate *_q_valid
   reg   [4:0] cnt, cnt1;
   always @ (posedge clk or posedge reset) begin
      if (reset) begin
         cnt   <= 4;
         adc_q <= 'h0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef;
         cnt1  <= 3;
         sdm_q <= 'h987654321;
      end
      else begin
         cnt         <= cnt + 1;
         adc_q_valid <= 0;
         if (cnt == 19) begin
            cnt         <= 0;
            adc_q_valid <= 1;
            adc_q       <= adc_q + 1;
         end
         cnt1        <= cnt1 + 1;
         sdm_q_valid <= 0;
         if (cnt1 == 3) begin
            cnt1        <= 0;
            sdm_q_valid <= 1;
            sdm_q       <= sdm_q + 1;
         end
      end
   end

endmodule
