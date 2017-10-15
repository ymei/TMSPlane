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
    input [DIN_WIDTH-1:0]   DIN,
    input                   DIN_VALID,
    input                   DIN_CLK,
    output [DOUT_WIDTH-1:0] DOUT,
    output                  DOUT_EMPTY,
    input                   DOUT_RDEN
    );

   localparam FIFO_REDUCTION_RATIO  = DIN_WIDTH / DOUT_WIDTH;

   // write into fifo
   wire [DIN_WIDTH-1:0]   fifo_dout;
   wire                   fifo_rden;
   wire                   fifo_empty, fifo_full;
   fifo512x fifo512x_inst // FWFT fifo
     (
      .rst(RESET),
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
      .RESET(RESET),
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
