//% @file fifo_over_ufc_tb.v
//% @brief test bench of FIFO I/O via Aurora 64B66B UFC interface
//% @author Yuan Mei
//%
`timescale 1ns / 1ps

module fifo_over_ufc_tb
  #(
    parameter FIFO_DATA_WIDTH   = 32,
    parameter AURORA_DATA_WIDTH = 64
    )
   ();

   reg                          clk;
   reg                          reset;
   wire                         a_tx_req;
   wire [7:0]                   a_tx_ms;
   reg                          a_tx_tready;
   wire [AURORA_DATA_WIDTH-1:0] a_tx_tdata;
   wire                         a_tx_tvalid;
   wire [AURORA_DATA_WIDTH-1:0] a_rx_tdata;
   reg                          a_rx_tvalid;
   wire                         fifo_clk;
   wire [FIFO_DATA_WIDTH-1:0]   tx_fifo_q;
   wire                         tx_fifo_wren;
   reg                          tx_fifo_full;
   reg [FIFO_DATA_WIDTH-1:0]    rx_fifo_q;
   wire                         rx_fifo_rden;
   reg                          rx_fifo_empty;
   wire                         err;

   fifo_over_ufc #(.FIFO_DATA_WIDTH(FIFO_DATA_WIDTH), .AURORA_DATA_WIDTH(AURORA_DATA_WIDTH))
   uut
     (
      .RESET(reset),
      .AURORA_USER_CLK(clk),
      .AURORA_TX_REQ(a_tx_req),
      .AURORA_TX_MS(a_tx_ms),
      .AURORA_TX_TREADY(a_tx_tready),
      .AURORA_TX_TDATA(a_tx_tdata),
      .AURORA_TX_TVALID(a_tx_tvalid),
      .AURORA_RX_TDATA(a_rx_tdata),
      .AURORA_RX_TVALID(a_rx_tvalid),
      .FIFO_CLK(fifo_clk),
      .TX_FIFO_Q(tx_fifo_q),
      .TX_FIFO_WREN(tx_fifo_wren),
      .TX_FIFO_FULL(tx_fifo_full),
      .RX_FIFO_Q(rx_fifo_q),
      .RX_FIFO_RDEN(rx_fifo_rden),
      .RX_FIFO_EMPTY(rx_fifo_empty),
      .ERR(err)
      );

   //initial begin
   //$dumpfile("fifo_over_ufc.vcd");
   //$dumpvars(0, fifo_over_ufc);
   //end

   initial begin
      clk         = 0;
      reset       = 0;
      #16 reset   = 1;
      #26 reset   = 0;
      #200 reset  = 1;
      #10 reset   = 0;
   end
   always #5 clk = ~clk;

   initial begin
      rx_fifo_empty       = 1;
      a_rx_tvalid         = 0;
      tx_fifo_full        = 0;
      #46  rx_fifo_empty  = 0;
      #120 rx_fifo_empty  = 1;
      #40  a_rx_tvalid    = 1;
      #10  a_rx_tvalid    = 0; tx_fifo_full = 1;
   end

   // emulate Aurora UFC interface
   reg [1:0]  state;
   localparam S0 = 2'h0;
   localparam S1 = 2'h1;
   localparam S2 = 2'h2;
   localparam S3 = 2'h3;

   always @ (posedge clk or posedge reset) begin
      if (reset) begin
         state       <= S0;
         a_tx_tready <= 1;
      end
      else begin
         a_tx_tready <= 1;
         case (state)
           S0: begin
              state <= S0;
              if (a_tx_req == 1) begin
                 state       <= S1;
                 a_tx_tready <= 0;
              end
           end
           S1: begin
              state       <= S2;
              a_tx_tready <= 0;
           end
           S2: begin
              state       <= S3;
              a_tx_tready <= 1;
           end
           S3: begin
              state       <= S3;
              a_tx_tready <= 1;
              if (a_tx_tvalid == 1) begin
                 state <= S0;
              end
           end
           default: begin
              state <= S0;
           end
         endcase
      end
   end

endmodule
