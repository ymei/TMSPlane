//% @file  data_sampler_fifo.v
//% @brief Take a snippet of data into fifo and interface to fifo readout.
//% @author Yuan Mei
//%

`timescale 1ns / 1ps

module data_sampler_fifo
  #(
    parameter DIN_WIDTH = 512,
    parameter DOUT_WIDTH = 32
    )
   (
    input                   RESET,
    input                   CLK,
    input                   TRIG,
    input [DIN_WIDTH-1:0]   DIN,
    input                   DIN_VALID,
    input                   DIN_CLK,
    output [DOUT_WIDTH-1:0] DOUT,
    output                  DOUT_EMPTY,
    input                   DOUT_RDEN
    );

   localparam FIFO_REDUCTION_RATIO  = DIN_WIDTH / DOUT_WIDTH;

   reg                      trig_prev, trig_prev1, trig_prev2, trig_synced, busy;
   reg [3:0]                cnt, cnt1;
   reg [27:0]               cnt2;
   always @ (posedge CLK or posedge RESET) begin
      if (RESET) begin
         trig_prev   <= 1;
         trig_prev1  <= 1;
         trig_prev2  <= 1;
         trig_synced <= 0;
         busy        <= 0;
         cnt         <= 0;
         cnt1        <= 0;
         cnt2        <= 0;
      end
      else begin
         cnt2        <= cnt2 + 1; // a timer for self-trigger if external TRIG doesn't arrive.
         trig_prev   <= TRIG | cnt2[27];
         trig_prev1  <= trig_prev;
         trig_prev2  <= trig_prev1;
         trig_synced <= 0;
         if ((trig_prev2 == 0) && (trig_prev1 == 1)) begin // catch rising edge of TRIG
            cnt1 <= 3;
         end
         if (cnt1 > 0) begin // make sure trig_synced is 3-CLK wide
            trig_synced <= 1;
            cnt1        <= cnt1 - 1;
         end
         if (!busy) begin
            if (cnt < 15) begin // make sure reset and trig are separate
               cnt         <= cnt + 1;
               trig_synced <= 0;
            end
         end
         else begin
            trig_synced <= 0;
         end
         if (trig_synced && cnt1 == 0) begin
            busy <= 1; // hold busy when triggered, reset clears.
         end
      end
   end

   // write into fifo
   wire [DIN_WIDTH-1:0]   fifo_dout;
   wire                   fifo_rden;
   wire                   fifo_empty, fifo_full;
   fifo512x fifo512x_inst // FWFT fifo
     (
      .rst(trig_synced | RESET),
      .wr_clk(DIN_CLK),
      .rd_clk(CLK),
      .din(DIN),
      .wr_en(DIN_VALID),
      .rd_en(fifo_rden),
      .dout(fifo_dout),
      .full(fifo_full),
      .empty(fifo_empty)
      );
   fifo_rdwidth_reducer
     #(
       .RDWIDTH(32),
       .RDRATIO(FIFO_REDUCTION_RATIO),
       .SHIFTORDER(1) // 1: MSB first, 0: LSB first
       )
   fifo_rdwidth_reducer_inst
     (
      .RESET(~busy | RESET),
      .CLK(CLK),
      // input data interface
      .DIN(fifo_dout),
      .VALID(~fifo_empty),
      .RDREQ(fifo_rden),
      // output
      .DOUT(DOUT),
      .EMPTY(DOUT_EMPTY),
      .RD_EN(DOUT_RDEN)
      );

endmodule // data_sampler_fifo
