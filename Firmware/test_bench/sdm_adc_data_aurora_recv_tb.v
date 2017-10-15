//% @file sdm_adc_data_aurora_recv_tb.v
//% @brief test bench of sdm_adc_data_aurora_recv_tb.
//% @author Yuan Mei
//%
`timescale 1ns / 1ps

module sdm_adc_data_aurora_recv_tb
  #(
    parameter NCH_ADC = 20,
    parameter ADC_CYC = 20,
    parameter NCH_SDM = 19,
    parameter SDM_CYC = 4
    )
   ();

   reg                  reset;
   reg                  clk;
   wire [511:0]         dout;
   wire                 dout_valid;
   reg                  user_clk;
   reg [63:0]           axi_rx_tdata;
   reg                  axi_rx_tvalid;
   wire                 fifo_full;

   sdm_adc_data_aurora_recv
     #(
       .NCH_ADC(NCH_ADC),
       .ADC_CYC(ADC_CYC),
       .NCH_SDM(NCH_SDM),
       .SDM_CYC(SDM_CYC)
       )
   sdm_adc_data_aurora_recv_tb_inst
     (
      .RESET(reset),
      .CLK(clk),
      .USER_CLK(user_clk),
      .M_AXI_RX_TDATA(axi_rx_tdata),
      .M_AXI_RX_TVALID(axi_rx_tvalid),
      .DOUT(dout),
      .DOUT_VALID(dout_valid),
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
      user_clk  = 0;
   end
   always #2.5 user_clk = ~user_clk;

   reg   [4:0] cnt, cnt1;
   always @ (posedge user_clk or posedge reset) begin
      if (reset) begin
         cnt           <= 4;
         cnt1          <= 0;
         axi_rx_tdata  <= 64'h0123456789abcdef;
         axi_rx_tvalid <= 0;
      end
      else begin
         cnt1 <= cnt1 + 1;
         if (axi_rx_tvalid) begin
            cnt              <= cnt + 1;
            axi_rx_tdata     <= axi_rx_tdata + 1;
            axi_rx_tdata[63] <= 1'b0;
            if (cnt == 8) begin
               axi_rx_tdata[63] <= 1'b1;
               cnt              <= 0;
            end
         end
         axi_rx_tvalid <= 1;
         if (cnt1 == 0) begin
            axi_rx_tvalid <= 0;
         end
      end
   end

endmodule
