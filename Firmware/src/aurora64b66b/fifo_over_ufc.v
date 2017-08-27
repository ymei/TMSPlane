//% @file fifo_over_ufc.v
//% @brief Connect FIFO I/O via Aurora 64B66B UFC interface
//% @author Yuan Mei
//%
//% Default mode is 1 UFC request every 32-bit of data.
//% Aurora channel utilization efficiency is only 1/12 in this case.
`timescale 1ns / 1ps

module fifo_over_ufc
  #(
    parameter FIFO_DATA_WIDTH   = 32,
    parameter AURORA_DATA_WIDTH = 64
    )
   (
    input                          RESET,
    input                          AURORA_USER_CLK,
    output reg                     AURORA_TX_REQ,
    output [7:0]                   AURORA_TX_MS,
    input                          AURORA_TX_TREADY,
    output [AURORA_DATA_WIDTH-1:0] AURORA_TX_TDATA,
    output reg                     AURORA_TX_TVALID,
    input [AURORA_DATA_WIDTH-1:0]  AURORA_RX_TDATA,
    input                          AURORA_RX_TVALID,
    output                         FIFO_CLK,
    output [FIFO_DATA_WIDTH-1:0]   TX_FIFO_Q,
    output                         TX_FIFO_WREN,
    input                          TX_FIFO_FULL,
    input [FIFO_DATA_WIDTH-1:0]    RX_FIFO_Q,
    output reg                     RX_FIFO_RDEN,
    input                          RX_FIFO_EMPTY,
    output reg                     ERR
    );

   assign FIFO_CLK     = AURORA_USER_CLK;
   // receiving from aurora
   assign TX_FIFO_Q    = AURORA_RX_TDATA[FIFO_DATA_WIDTH-1:0];
   assign TX_FIFO_WREN = AURORA_RX_TVALID;

   // sending through aurora
   reg [1:0]                       state;
   localparam S0 = 2'h0;
   localparam S1 = 2'h1;
   localparam S2 = 2'h2;
   localparam S3 = 2'h3;

   assign AURORA_TX_MS    = 8'd7; // n+1 bytes will be sent through UFC
   assign AURORA_TX_TDATA = RX_FIFO_Q;
   always @ (posedge AURORA_USER_CLK or posedge RESET) begin
      if (RESET) begin
         state            <= S0;
         AURORA_TX_REQ    <= 0;
         AURORA_TX_TVALID <= 0;
         RX_FIFO_RDEN     <= 0;
      end
      else begin
         AURORA_TX_REQ    <= 0;
         AURORA_TX_TVALID <= 0;
         RX_FIFO_RDEN     <= 0;
         case (state)
           S0: begin
              state <= S0;
              if (RX_FIFO_EMPTY == 0) begin
                 AURORA_TX_REQ <= 1;
                 state         <= S1;
              end
           end
           S1: begin
              AURORA_TX_TVALID <= 1;
              state            <= S2;
           end
           S2: begin
              state            <= S2;
              AURORA_TX_TVALID <= 1;
              if (AURORA_TX_TREADY == 1) begin
                 state            <= S3;
                 AURORA_TX_TVALID <= 0;
                 RX_FIFO_RDEN     <= 1;
              end
           end
           S3: begin
              state <= S0;
           end
           default: begin
              state <= S0;
           end
         endcase
      end
   end

   // latch on TX_FIFO_FULL = 1 as error condition
   always @ (posedge AURORA_USER_CLK or posedge RESET) begin
      if (RESET) begin
         ERR <= 0;
      end
      else begin
         if (TX_FIFO_FULL == 1) begin
            ERR <= 1;
         end
      end
   end
endmodule
