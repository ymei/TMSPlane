//% @file  data_sampler_fifo_tb.v
//% @brief test bench of data_sampler_fifo.v
//% @author Yuan Mei
//%
`timescale 1ns / 1ps

module data_sampler_fifo_tb
  #(
    parameter DIN_WIDTH = 512,
    parameter DOUT_WIDTH = 32
    )
   ();

   reg                   reset;
   reg                   clk;
   reg                   trig;
   reg [DIN_WIDTH-1:0]   din;
   reg                   din_valid, din_clk;
   wire [DOUT_WIDTH-1:0] dout;
   wire                  dout_empty;
   reg                   dout_rden;

   data_sampler_fifo
     #(
       .DIN_WIDTH(DIN_WIDTH),
       .DOUT_WIDTH(DOUT_WIDTH)
       )
   data_sampler_fifo_tb_inst
     (
      .RESET(reset),
      .CLK(clk),
      .TRIG(trig),
      .DIN(din),
      .DIN_VALID(din_valid),
      .DIN_CLK(din_clk),
      .DOUT(dout),
      .DOUT_EMPTY(dout_empty),
      .DOUT_RDEN(dout_rden)
    );

   //initial begin
   //$dumpfile("a.vcd");
   //$dumpvars(0, x);
   //end

   initial begin
      clk       = 0;
      din_clk   = 0;
      reset     = 0;
      #16 reset = 1;
      #36 reset = 0;
   end
   always #10    clk = ~clk;
   always #5 din_clk = ~din_clk;

   initial begin
      din_valid = 0;
      dout_rden = 0;
   end

   initial begin
      trig       = 0;
      #180 trig <= 1;
      #20  trig <= 0;
      #212 trig <= 1;
      #100 trig <= 0;
      #212 trig <= 1;
      #100 trig <= 0;
   end
endmodule
