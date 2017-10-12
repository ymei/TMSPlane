//% @file diffiodelay.v
//% @brief Convert between single-ended and differential and connect i/o through iodelay.
//% @author Yuan Mei
//%
//% @param[in] NINPUT number of inputs.
//% @param[in] NOUTPUT number of outputs.
//% @param[in] DELAY_CHANNEL address 0~(NINPUT-1) selects inputs, NINPUT~(NINPUT+NOUTPUT-1) selects outputs to control.

`timescale 1ns / 1ps

module diffiodelay
  #(
    parameter NINPUT  = 20,
    parameter NOUTPUT = 1,
    parameter INPUT_DIFF_TERM = "TRUE",
    parameter IODELAY_GROUP_NAME = "iodelay_grp"
    )
   (
    input                RESET,
    input                CLK, //% DELAY_* must be synchronous to this clock
    input [7:0]          DELAY_CHANNEL,
    input [4:0]          DELAY_VALUE,
    input                DELAY_UPDATE, //% a pulse to update the delay value
    output [NINPUT-1:0]  INPUTS_OUT,
    input [NINPUT-1:0]   INPUTS_P,
    input [NINPUT-1:0]   INPUTS_N,
    input [NOUTPUT-1:0]  OUTPUTS_IN,
    output [NOUTPUT-1:0] OUTPUTS_P,
    output [NOUTPUT-1:0] OUTPUTS_N
    );

   reg [(NINPUT+NOUTPUT)-1:0] delay_update_v;
   wire                       du;
   reg                        du_prev, du_prev1;
   wire [NINPUT-1:0]          inputs_out_i;
   wire [NOUTPUT-1:0]         outputs_in_i;

   // select which channel to write the delay_value to
   always @ (DELAY_CHANNEL) begin
      delay_update_v                <= 0;
      delay_update_v[DELAY_CHANNEL] <= du;
   end
   // capture the rising edge
   always @ (posedge CLK or posedge RESET) begin
      if (RESET) begin
         du_prev  <= 0;
         du_prev1 <= 0;
      end
      else begin
         du_prev  <= DELAY_UPDATE;
         du_prev1 <= du_prev;
      end
   end
   assign du = (~du_prev1)&(du_prev);

   genvar i;
   generate
      for (i=0; i<NINPUT; i=i+1) begin
         IBUFDS
             #(
               .DIFF_TERM(INPUT_DIFF_TERM), // Differential Termination
               .IBUF_LOW_PWR("TRUE"),       // Low power="TRUE", Highest performance="FALSE"
               .IOSTANDARD("DEFAULT")       // Specify the input I/O standard
               )
         ibufds_inst
             (
              .O(inputs_out_i[i]), // Buffer output
              .I(INPUTS_P[i]),     // Diff_p buffer input (connect directly to top-level port)
              .IB(INPUTS_N[i])     // Diff_n buffer input (connect directly to top-level port)
              );
         (* IODELAY_GROUP = IODELAY_GROUP_NAME *) // Specifies group name for associated IDELAYs/ODELAYs and IDELAYCTRL
         IDELAYE2
           #(
             .CINVCTRL_SEL("FALSE"),          // Enable dynamic clock inversion (FALSE, TRUE)
             .DELAY_SRC("IDATAIN"),           // Delay input (IDATAIN, DATAIN)
             .HIGH_PERFORMANCE_MODE("FALSE"), // Reduced jitter ("TRUE"), Reduced power ("FALSE")
             .IDELAY_TYPE("VAR_LOAD"),        // FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
             .IDELAY_VALUE(0),                // Input delay tap setting (0-31)
             .PIPE_SEL("FALSE"),              // Select pipelined mode, FALSE, TRUE
             .REFCLK_FREQUENCY(200.0),        // IDELAYCTRL clock input frequency in MHz (190.0-210.0, 290.0-310.0).
             .SIGNAL_PATTERN("DATA")          // DATA, CLOCK input signal
             )
         idelaye2_inst
           (
            .CNTVALUEOUT(),            // 5-bit output: Counter value output
            .DATAOUT(INPUTS_OUT[i]),   // 1-bit output: Delayed data output
            .C(CLK),                   // 1-bit input: Clock input
            .CE(0),                    // 1-bit input: Active high enable increment/decrement input
            .CINVCTRL(0),              // 1-bit input: Dynamic clock inversion input
            .CNTVALUEIN(DELAY_VALUE),  // 5-bit input: Counter value input
            .DATAIN(0),                // 1-bit input: Internal delay data input
            .IDATAIN(inputs_out_i[i]), // 1-bit input: Data input from the I/O
            .INC(0),                   // 1-bit input: Increment / Decrement tap delay input
            .LD(delay_update_v[i]),    // 1-bit input: Load IDELAY_VALUE input
            .LDPIPEEN(0),              // 1-bit input: Enable PIPELINE register to load data input
            .REGRST(0)                 // 1-bit input: Active-high reset tap-delay input
            );
      end
      for (i=0; i<NOUTPUT; i=i+1) begin
         // ODELAYE2 only exists in HP banks!
         (* IODELAY_GROUP = IODELAY_GROUP_NAME *) // Specifies group name for associated IDELAYs/ODELAYs and IDELAYCTRL
         ODELAYE2
             #(
               .CINVCTRL_SEL("FALSE"),          // Enable dynamic clock inversion (FALSE, TRUE)
               .DELAY_SRC("ODATAIN"),           // Delay input (ODATAIN, CLKIN)
               .HIGH_PERFORMANCE_MODE("FALSE"), // Reduced jitter ("TRUE"), Reduced power ("FALSE")
               .ODELAY_TYPE("VAR_LOAD"),        // FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
               .ODELAY_VALUE(0),                // Output delay tap setting (0-31)
               .PIPE_SEL("FALSE"),              // Select pipelined mode, FALSE, TRUE
               .REFCLK_FREQUENCY(200.0),        // IDELAYCTRL clock input frequency in MHz (190.0-210.0, 290.0-310.0).
               .SIGNAL_PATTERN("DATA")          // DATA, CLOCK input signal
               )
         odelaye2_inst
             (
              .CNTVALUEOUT(),            // 5-bit output: Counter value output
              .DATAOUT(outputs_in_i[i]), // 1-bit output: Delayed data/clock output
              .C(CLK),                   // 1-bit input: Clock input
              .CE(0),                    // 1-bit input: Active high enable increment/decrement input
              .CINVCTRL(0),              // 1-bit input: Dynamic clock inversion input
              .CLKIN(0),                 // 1-bit input: Clock delay input
              .CNTVALUEIN(DELAY_VALUE),  // 5-bit input: Counter value input
              .INC(0),                   // 1-bit input: Increment / Decrement tap delay input
              .LD(delay_update_v[i+NINPUT]),  // 1-bit input: Loads ODELAY_VALUE tap delay in VARIABLE mode,
                                              // in VAR_LOAD or VAR_LOAD_PIPE mode, loads the value of CNTVALUEIN
              .LDPIPEEN(0),              // 1-bit input: Enables the pipeline register to load data
              .ODATAIN(OUTPUTS_IN[i]),   // 1-bit input: Output delay data input
              .REGRST(0)                 // 1-bit input: Active-high reset tap-delay input
              );
         OBUFDS
           #(
             .IOSTANDARD("DEFAULT"), // Specify the output I/O standard
             .SLEW("SLOW")           // Specify the output slew rate
             )
         obufds_inst
           (
            .O(OUTPUTS_P[i]),     // Diff_p output (connect directly to top-level port)
            .OB(OUTPUTS_N[i]),    // Diff_n output (connect directly to top-level port)
            .I(outputs_in_i[i])   // Buffer input
            );
      end
   endgenerate

endmodule // diffiodelay
