# TE0741-2C1 xc7k160tffg676-2 configuration
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
# enable if there are unconstrained pins
set_property BITSTREAM.General.UnconstrainedPins {Allow} [current_design]
# SPIx4 interface bitstream
#set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]
set_property BITSTREAM.CONFIG.SPI_FALL_EDGE YES [current_design]
set_property BITSTREAM.CONFIG.SPI_32BIT_ADDR YES [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property BITSTREAM.CONFIG.M1PIN PULLNONE [current_design]
set_property BITSTREAM.CONFIG.M2PIN PULLNONE [current_design]
set_property BITSTREAM.CONFIG.M0PIN PULLNONE [current_design]
#set_property BITSTREAM.CONFIG.USR_ACCESS TIMESTAMP [current_design]

# 100MHz onboard diff clock
create_clock -name system_clock -period 10.0 [get_ports {SYS_CLK_P}]
# 125MHz
create_clock -name sgmii_clock  -period 8.0 [get_ports {SGMIICLK_Q0_P}]
# 156.25MHz
create_clock -name clk156p25_clock  -period 8.0 [get_ports {MGT_CLK3_P}]

# External 100Ohm termination present
# PadFunction: IO_L12P_T1_MRCC_14
set_property -dict {IOSTANDARD LVDS_25 PACKAGE_PIN F22} [get_ports {SYS_CLK_P}]
# PadFunction: IO_L12N_T1_MRCC_14
set_property -dict {IOSTANDARD LVDS_25 PACKAGE_PIN E23} [get_ports {SYS_CLK_N}]

# 125MHz clock, for GTP/GTH/GTX
set_property PACKAGE_PIN F6 [get_ports {SGMIICLK_Q0_P}]
set_property PACKAGE_PIN F5 [get_ports {SGMIICLK_Q0_N}]

# 156.25MHz clock, for GTX/10GbE
set_property PACKAGE_PIN K6 [get_ports {MGT_CLK3_P}]
set_property PACKAGE_PIN K5 [get_ports {MGT_CLK3_N}]

# clock domain interaction, must explictly specify all possible pairs.
# Command with only one `-group' parameter means the clock is asynchronous to all other, including generated from its own, clocks.
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks system_clock] -group [get_clocks -include_generated_clocks sgmii_clock]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks system_clock] -group [get_clocks -include_generated_clocks clk156p25_clock]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks sgmii_clock]  -group [get_clocks -include_generated_clocks clk156p25_clock]

# seems we ran out of bufg's
# set_property CLOCK_DEDICATED_ROUTE BACKBONE [get_nets global_clock_reset_inst/I]
# false path of resetter
set_false_path -from [get_pins -of_objects [get_cells -hierarchical -filter {NAME =~ *GLOBAL_RST_reg*}] -filter {NAME =~ *C}]

#<-- LEDs, buttons and switches --<

# LED:
# IO_L5P_T0_D06_14
set_property -dict {PACKAGE_PIN D26 IOSTANDARD LVCMOS33 SLEW SLOW DRIVE 12} [get_ports {LED8Bit[0]}]

# IO_L17N_T2_A13_D29_14
set_property -dict {PACKAGE_PIN E26 IOSTANDARD LVCMOS33 SLEW SLOW DRIVE 12} [get_ports {LED8Bit[1]}]

#>-- LEDs, buttons and switches -->

#<-- UART --<

#>-- UART -->

#<-- control interface --<

set_false_path -from [get_pins -of_objects [get_cells -hierarchical -filter {NAME =~ *control_interface_inst*sConfigReg_reg[*]}] -filter {NAME =~ *C}]
set_false_path -from [get_pins -of_objects [get_cells -hierarchical -filter {NAME =~ *control_interface_inst*sPulseReg_reg[*]}] -filter {NAME =~ *C}]
set_false_path -to [get_pins -of_objects [get_cells -hierarchical -filter {NAME =~ *control_interface_inst*sRegOut_reg[*]}] -filter {NAME =~ *D}]

#>-- control interface -->

#<-- MGT --<

set_property PACKAGE_PIN F2 [get_ports SMA_MGT_TX_P]
set_property PACKAGE_PIN F1 [get_ports SMA_MGT_TX_N]
set_property PACKAGE_PIN G4 [get_ports SMA_MGT_RX_P]
set_property PACKAGE_PIN G3 [get_ports SMA_MGT_RX_N]

#set_property LOC GTXE2_CHANNEL_X0Y8 [get_cells aurora_64b66b_inst/aurora_64b66b_0_support_inst/aurora_64b66b_0_i/inst/aurora_64b66b_0_wrapper_i/aurora_64b66b_0_multi_gt_i/aurora_64b66b_0_gtx_inst/gtxe2_i]
#set_property LOC GTXE2_COMMON_X0Y2 [get_cells aurora_64b66b_inst/aurora_64b66b_0_support_inst/gt_common_support/gtxe2_common_i]

# SFP
#set_property PACKAGE_PIN Y20 [get_ports SFP_TX_DISABLE_N]
#set_property IOSTANDARD LVCMOS25 [get_ports SFP_TX_DISABLE_N]
#set_property PACKAGE_PIN H21 [get_ports SFP_LOS_LS]
## conflict with MIO0
#set_property IOSTANDARD LVCMOS33 [get_ports SFP_LOS_LS]
set_property PACKAGE_PIN A4 [get_ports SFP_TX_P]
set_property PACKAGE_PIN A3 [get_ports SFP_TX_N]
set_property PACKAGE_PIN B6 [get_ports SFP_RX_P]
set_property PACKAGE_PIN B5 [get_ports SFP_RX_N]

#>-- MGT -->

#<-- I2C --<

set_property -dict {PACKAGE_PIN A20 IOSTANDARD LVCMOS33} [get_ports I2C_SCL]
set_property -dict {PACKAGE_PIN B21 IOSTANDARD LVCMOS33} [get_ports I2C_SDA]

#>-- I2C -->

#<-- ADC, external, LTC2325-16 --<

# 100MHz SCK loopback
create_clock -name adc_clk_lpbk_clock -period 10.0 [get_ports {B16_L_P[12]}]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks adc_clk_lpbk_clock] -group [get_clocks -include_generated_clocks system_clock]
# adc_clk_lpbk no dedicated route between idelay and bufg
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets adc_cnv_sipo_inst/adc_diffiodelay_inst/CLK_LPBK]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets adc_cnv_sipo_inst/adc_clk_lpbk]
# adc_sdo data relation to lpbk clock
# Not supported in .xdc, rename constraints file to .tcl to use full TCL features
# foreach port {{B12_L_P[4]},{B12_L_P[1]},{B12_L_P[6]},{B15_L_P[23]},{B12_L_P[15]},{B15_L_P[21]},{B15_L_P[14]},{B15_L_P[12]},{B15_L_P[13]},{B15_L_P[11]},{B15_L_P[5]},{B15_L_P[20]},{B16_L_P[18]},{B15_L_P[7]},{B16_L_P[14]},{B16_L_P[23]},{B16_L_P[11]},{B16_L_P[21]},{B13_L_P[5]},{B13_L_P[1]}
# } {
#     set_property -clock adc_clk_lpbk_clock -min 4.0 [get_ports $port]
#     set_property -clock adc_clk_lpbk_clock -max 6.0 [get_ports $port]
# }
# hold time
set_input_delay -clock adc_clk_lpbk_clock -min   2.0 [get_ports {B12_L_P[4]}]
set_input_delay -clock adc_clk_lpbk_clock -min   2.0 [get_ports {B12_L_P[1]}]
set_input_delay -clock adc_clk_lpbk_clock -min   2.0 [get_ports {B12_L_P[6]}]
set_input_delay -clock adc_clk_lpbk_clock -min   2.0 [get_ports {B15_L_P[23]}]
set_input_delay -clock adc_clk_lpbk_clock -min   2.0 [get_ports {B12_L_P[15]}]
set_input_delay -clock adc_clk_lpbk_clock -min   2.0 [get_ports {B15_L_P[21]}]
set_input_delay -clock adc_clk_lpbk_clock -min   2.0 [get_ports {B15_L_P[14]}]
set_input_delay -clock adc_clk_lpbk_clock -min   2.0 [get_ports {B15_L_P[12]}]
set_input_delay -clock adc_clk_lpbk_clock -min   2.0 [get_ports {B15_L_P[13]}]
set_input_delay -clock adc_clk_lpbk_clock -min   2.0 [get_ports {B15_L_P[11]}]
set_input_delay -clock adc_clk_lpbk_clock -min   2.0 [get_ports {B15_L_P[5]}]
set_input_delay -clock adc_clk_lpbk_clock -min   2.0 [get_ports {B15_L_P[20]}]
set_input_delay -clock adc_clk_lpbk_clock -min   2.0 [get_ports {B16_L_P[18]}]
set_input_delay -clock adc_clk_lpbk_clock -min   2.0 [get_ports {B15_L_P[7]}]
set_input_delay -clock adc_clk_lpbk_clock -min   2.0 [get_ports {B16_L_P[14]}]
set_input_delay -clock adc_clk_lpbk_clock -min   2.0 [get_ports {B16_L_P[23]}]
set_input_delay -clock adc_clk_lpbk_clock -min   2.0 [get_ports {B16_L_P[11]}]
set_input_delay -clock adc_clk_lpbk_clock -min   2.0 [get_ports {B16_L_P[21]}]
set_input_delay -clock adc_clk_lpbk_clock -min   2.0 [get_ports {B13_L_P[5]}]
set_input_delay -clock adc_clk_lpbk_clock -min   2.0 [get_ports {B13_L_P[1]}]
# clock period - setup time
set_input_delay -clock adc_clk_lpbk_clock -max   8.0 [get_ports {B12_L_P[4]}]
set_input_delay -clock adc_clk_lpbk_clock -max   8.0 [get_ports {B12_L_P[1]}]
set_input_delay -clock adc_clk_lpbk_clock -max   8.0 [get_ports {B12_L_P[6]}]
set_input_delay -clock adc_clk_lpbk_clock -max   8.0 [get_ports {B15_L_P[23]}]
set_input_delay -clock adc_clk_lpbk_clock -max   8.0 [get_ports {B12_L_P[15]}]
set_input_delay -clock adc_clk_lpbk_clock -max   8.0 [get_ports {B15_L_P[21]}]
set_input_delay -clock adc_clk_lpbk_clock -max   8.0 [get_ports {B15_L_P[14]}]
set_input_delay -clock adc_clk_lpbk_clock -max   8.0 [get_ports {B15_L_P[12]}]
set_input_delay -clock adc_clk_lpbk_clock -max   8.0 [get_ports {B15_L_P[13]}]
set_input_delay -clock adc_clk_lpbk_clock -max   8.0 [get_ports {B15_L_P[11]}]
set_input_delay -clock adc_clk_lpbk_clock -max   8.0 [get_ports {B15_L_P[5]}]
set_input_delay -clock adc_clk_lpbk_clock -max   8.0 [get_ports {B15_L_P[20]}]
set_input_delay -clock adc_clk_lpbk_clock -max   8.0 [get_ports {B16_L_P[18]}]
set_input_delay -clock adc_clk_lpbk_clock -max   8.0 [get_ports {B15_L_P[7]}]
set_input_delay -clock adc_clk_lpbk_clock -max   8.0 [get_ports {B16_L_P[14]}]
set_input_delay -clock adc_clk_lpbk_clock -max   8.0 [get_ports {B16_L_P[23]}]
set_input_delay -clock adc_clk_lpbk_clock -max   8.0 [get_ports {B16_L_P[11]}]
set_input_delay -clock adc_clk_lpbk_clock -max   8.0 [get_ports {B16_L_P[21]}]
set_input_delay -clock adc_clk_lpbk_clock -max   8.0 [get_ports {B13_L_P[5]}]
set_input_delay -clock adc_clk_lpbk_clock -max   8.0 [get_ports {B13_L_P[1]}]
# adc_clkff
create_generated_clock -name adc_clkff_clock -multiply_by 1 -source [get_pins adc_cnv_sipo_inst/adc_clkff_forward_inst/C] [get_ports {B16_L_P[13]}]
#set_clock_sense -positive adc_cnv_sipo_inst/adc_clkff_div_inst/adc_clkff_forward_inst_i_4/O
# adc_cnv_n
# negative(-) of hold time
set_output_delay -clock adc_clkff_clock -min -2.0 [get_ports {B16_L_P[17]}]
# setup time
set_output_delay -clock adc_clkff_clock -max  2.0 [get_ports {B16_L_P[17]}]

#>-- ADC, external, LTC2325-16 -->

#<-- TMS SDM --<

# clkff
create_generated_clock -name tms_sdm_clkff_clock -multiply_by 1 -source [get_pins tms_sdm_recv_inst/tms_sdm_clkff_forward_inst/C] [get_ports {B12_L_P[16]}]
# clk loopback
create_clock -name tms_sdm_clk_lpbk_clock -period 40.0 [get_ports {B12_L_P[12]}]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks tms_sdm_clk_lpbk_clock] -group [get_clocks -include_generated_clocks system_clock]
# No dedicated route between idelay and bufg
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets tms_sdm_recv_inst/tms_sdm_clk_lpbk]
# hold time
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B12_L_P[18]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B12_L_P[9]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B12_L_P[20]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B13_L_P[23]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B13_L_P[21]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B13_L_P[12]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B12_L_P[5]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B12_L_P[7]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B12_L_P[21]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B12_L_P[24]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B13_L_P[6]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B13_L_P[9]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B13_L_P[16]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B13_L_P[22]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B13_L_P[10]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B13_L_P[8]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B13_L_P[4]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B12_L_P[11]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B12_L_P[13]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B12_L_N[18]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B12_L_N[9]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B12_L_N[20]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B13_L_N[23]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B13_L_N[21]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B13_L_N[12]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B12_L_N[5]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B12_L_N[7]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B12_L_N[21]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B12_L_N[24]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B13_L_N[6]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B13_L_N[9]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B13_L_N[16]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B13_L_N[22]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B13_L_N[10]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B13_L_N[8]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B13_L_N[4]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B12_L_N[11]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B12_L_N[13]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B12_L_P[17]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B12_L_P[8]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B12_L_P[22]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B13_L_P[13]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B13_L_P[11]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B13_L_P[15]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B12_L_P[3]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B12_L_P[10]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B12_L_P[23]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B12_L_P[19]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B13_L_P[17]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B13_L_P[18]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B13_L_P[14]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B13_L_P[24]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B13_L_P[7]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B13_L_P[20]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B13_L_P[2]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B12_L_P[2]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B12_L_P[14]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B12_L_N[17]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B12_L_N[8]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B12_L_N[22]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B13_L_N[13]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B13_L_N[11]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B13_L_N[15]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B12_L_N[3]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B12_L_N[10]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B12_L_N[23]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B12_L_N[19]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B13_L_N[17]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B13_L_N[18]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B13_L_N[14]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B13_L_N[24]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B13_L_N[7]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B13_L_N[20]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B13_L_N[2]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B12_L_N[2]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -min  -3.0 [get_ports {B12_L_N[14]}]
# clock period - setup time
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B12_L_P[18]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B12_L_P[9]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B12_L_P[20]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B13_L_P[23]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B13_L_P[21]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B13_L_P[12]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B12_L_P[5]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B12_L_P[7]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B12_L_P[21]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B12_L_P[24]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B13_L_P[6]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B13_L_P[9]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B13_L_P[16]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B13_L_P[22]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B13_L_P[10]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B13_L_P[8]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B13_L_P[4]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B12_L_P[11]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B12_L_P[13]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B12_L_N[18]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B12_L_N[9]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B12_L_N[20]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B13_L_N[23]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B13_L_N[21]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B13_L_N[12]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B12_L_N[5]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B12_L_N[7]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B12_L_N[21]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B12_L_N[24]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B13_L_N[6]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B13_L_N[9]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B13_L_N[16]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B13_L_N[22]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B13_L_N[10]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B13_L_N[8]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B13_L_N[4]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B12_L_N[11]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B12_L_N[13]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B12_L_P[17]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B12_L_P[8]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B12_L_P[22]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B13_L_P[13]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B13_L_P[11]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B13_L_P[15]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B12_L_P[3]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B12_L_P[10]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B12_L_P[23]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B12_L_P[19]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B13_L_P[17]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B13_L_P[18]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B13_L_P[14]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B13_L_P[24]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B13_L_P[7]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B13_L_P[20]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B13_L_P[2]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B12_L_P[2]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B12_L_P[14]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B12_L_N[17]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B12_L_N[8]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B12_L_N[22]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B13_L_N[13]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B13_L_N[11]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B13_L_N[15]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B12_L_N[3]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B12_L_N[10]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B12_L_N[23]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B12_L_N[19]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B13_L_N[17]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B13_L_N[18]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B13_L_N[14]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B13_L_N[24]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B13_L_N[7]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B13_L_N[20]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B13_L_N[2]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B12_L_N[2]}]
set_input_delay -clock tms_sdm_clk_lpbk_clock -max  27.0 [get_ports {B12_L_N[14]}]

#>-- TMS SDM -->

#<-- TE0741 B2B --<

# single-ended
set_property -dict {PACKAGE_PIN Y20 IOSTANDARD LVCMOS25} [get_ports "B12_L_P[25]"]
set_property -dict {PACKAGE_PIN AF22 IOSTANDARD LVDS_25} [get_ports "B12_L_N[24]"]
set_property -dict {PACKAGE_PIN AE22 IOSTANDARD LVDS_25} [get_ports "B12_L_P[24]"]
set_property -dict {PACKAGE_PIN AE25 IOSTANDARD LVDS_25} [get_ports "B12_L_N[23]"]
set_property -dict {PACKAGE_PIN AD25 IOSTANDARD LVDS_25} [get_ports "B12_L_P[23]"]
set_property -dict {PACKAGE_PIN AF23 IOSTANDARD LVDS_25} [get_ports "B12_L_N[22]"]
set_property -dict {PACKAGE_PIN AE23 IOSTANDARD LVDS_25} [get_ports "B12_L_P[22]"]
set_property -dict {PACKAGE_PIN AE26 IOSTANDARD LVDS_25} [get_ports "B12_L_N[21]"]
set_property -dict {PACKAGE_PIN AD26 IOSTANDARD LVDS_25} [get_ports "B12_L_P[21]"]
set_property -dict {PACKAGE_PIN AF25 IOSTANDARD LVDS_25} [get_ports "B12_L_N[20]"]
set_property -dict {PACKAGE_PIN AF24 IOSTANDARD LVDS_25} [get_ports "B12_L_P[20]"]
set_property -dict {PACKAGE_PIN AE21 IOSTANDARD LVDS_25} [get_ports "B12_L_N[19]"]
set_property -dict {PACKAGE_PIN AD21 IOSTANDARD LVDS_25} [get_ports "B12_L_P[19]"]
set_property -dict {PACKAGE_PIN AC21 IOSTANDARD LVDS_25} [get_ports "B12_L_N[18]"]
set_property -dict {PACKAGE_PIN AB21 IOSTANDARD LVDS_25} [get_ports "B12_L_P[18]"]
set_property -dict {PACKAGE_PIN AC22 IOSTANDARD LVDS_25} [get_ports "B12_L_N[17]"]
set_property -dict {PACKAGE_PIN AB22 IOSTANDARD LVDS_25} [get_ports "B12_L_P[17]"]
set_property -dict {PACKAGE_PIN AD24 IOSTANDARD LVDS_25} [get_ports "B12_L_N[16]"]
set_property -dict {PACKAGE_PIN AD23 IOSTANDARD LVDS_25} [get_ports "B12_L_P[16]"]
set_property -dict {PACKAGE_PIN Y21  IOSTANDARD LVDS_25} [get_ports "B12_L_N[15]"]
set_property -dict {PACKAGE_PIN W20  IOSTANDARD LVDS_25} [get_ports "B12_L_P[15]"]
set_property -dict {PACKAGE_PIN AC24 IOSTANDARD LVDS_25} [get_ports "B12_L_N[14]"]
set_property -dict {PACKAGE_PIN AC23 IOSTANDARD LVDS_25} [get_ports "B12_L_P[14]"]
set_property -dict {PACKAGE_PIN AA22 IOSTANDARD LVDS_25} [get_ports "B12_L_N[13]"]
set_property -dict {PACKAGE_PIN Y22  IOSTANDARD LVDS_25} [get_ports "B12_L_P[13]"]
set_property -dict {PACKAGE_PIN AA24 IOSTANDARD LVDS_25} [get_ports "B12_L_N[12]"]
set_property -dict {PACKAGE_PIN Y23  IOSTANDARD LVDS_25} [get_ports "B12_L_P[12]"]
set_property -dict {PACKAGE_PIN AB24 IOSTANDARD LVDS_25} [get_ports "B12_L_N[11]"]
set_property -dict {PACKAGE_PIN AA23 IOSTANDARD LVDS_25} [get_ports "B12_L_P[11]"]
set_property -dict {PACKAGE_PIN Y26  IOSTANDARD LVDS_25} [get_ports "B12_L_N[10]"]
set_property -dict {PACKAGE_PIN Y25  IOSTANDARD LVDS_25} [get_ports "B12_L_P[10]"]
set_property -dict {PACKAGE_PIN AC26 IOSTANDARD LVDS_25} [get_ports "B12_L_N[9]"]
set_property -dict {PACKAGE_PIN AB26 IOSTANDARD LVDS_25} [get_ports "B12_L_P[9]"]
set_property -dict {PACKAGE_PIN W24  IOSTANDARD LVDS_25} [get_ports "B12_L_N[8]"]
set_property -dict {PACKAGE_PIN W23  IOSTANDARD LVDS_25} [get_ports "B12_L_P[8]"]
set_property -dict {PACKAGE_PIN AB25 IOSTANDARD LVDS_25} [get_ports "B12_L_N[7]"]
set_property -dict {PACKAGE_PIN AA25 IOSTANDARD LVDS_25} [get_ports "B12_L_P[7]"]
set_property -dict {PACKAGE_PIN W21  IOSTANDARD LVDS_25} [get_ports "B12_L_N[6]"]
set_property -dict {PACKAGE_PIN V21  IOSTANDARD LVDS_25} [get_ports "B12_L_P[6]"]
set_property -dict {PACKAGE_PIN W26  IOSTANDARD LVDS_25} [get_ports "B12_L_N[5]"]
set_property -dict {PACKAGE_PIN W25  IOSTANDARD LVDS_25} [get_ports "B12_L_P[5]"]
set_property -dict {PACKAGE_PIN V26  IOSTANDARD LVDS_25} [get_ports "B12_L_N[4]"]
set_property -dict {PACKAGE_PIN U26  IOSTANDARD LVDS_25} [get_ports "B12_L_P[4]"]
set_property -dict {PACKAGE_PIN V24  IOSTANDARD LVDS_25} [get_ports "B12_L_N[3]"]
set_property -dict {PACKAGE_PIN V23  IOSTANDARD LVDS_25} [get_ports "B12_L_P[3]"]
set_property -dict {PACKAGE_PIN U25  IOSTANDARD LVDS_25} [get_ports "B12_L_N[2]"]
set_property -dict {PACKAGE_PIN U24  IOSTANDARD LVDS_25} [get_ports "B12_L_P[2]"]
set_property -dict {PACKAGE_PIN V22  IOSTANDARD LVDS_25} [get_ports "B12_L_N[1]"]
set_property -dict {PACKAGE_PIN U22  IOSTANDARD LVDS_25} [get_ports "B12_L_P[1]"]
# single-ended
set_property -dict {PACKAGE_PIN U21 IOSTANDARD LVCMOS25} [get_ports "B12_L_P[0]"]

set_property -dict {PACKAGE_PIN P18 IOSTANDARD LVDS_25} [get_ports "B13_L_N[24]"]
set_property -dict {PACKAGE_PIN R18 IOSTANDARD LVDS_25} [get_ports "B13_L_P[24]"]
set_property -dict {PACKAGE_PIN T17 IOSTANDARD LVDS_25} [get_ports "B13_L_N[23]"]
set_property -dict {PACKAGE_PIN U17 IOSTANDARD LVDS_25} [get_ports "B13_L_P[23]"]
set_property -dict {PACKAGE_PIN M19 IOSTANDARD LVDS_25} [get_ports "B13_L_N[22]"]
set_property -dict {PACKAGE_PIN N18 IOSTANDARD LVDS_25} [get_ports "B13_L_P[22]"]
set_property -dict {PACKAGE_PIN R17 IOSTANDARD LVDS_25} [get_ports "B13_L_N[21]"]
set_property -dict {PACKAGE_PIN R16 IOSTANDARD LVDS_25} [get_ports "B13_L_P[21]"]
set_property -dict {PACKAGE_PIN N17 IOSTANDARD LVDS_25} [get_ports "B13_L_N[20]"]
set_property -dict {PACKAGE_PIN P16 IOSTANDARD LVDS_25} [get_ports "B13_L_P[20]"]
set_property -dict {PACKAGE_PIN T19 IOSTANDARD LVDS_25} [get_ports "B13_L_N[19]"]
set_property -dict {PACKAGE_PIN T18 IOSTANDARD LVDS_25} [get_ports "B13_L_P[19]"]
set_property -dict {PACKAGE_PIN U20 IOSTANDARD LVDS_25} [get_ports "B13_L_N[18]"]
set_property -dict {PACKAGE_PIN U19 IOSTANDARD LVDS_25} [get_ports "B13_L_P[18]"]
set_property -dict {PACKAGE_PIN T23 IOSTANDARD LVDS_25} [get_ports "B13_L_N[17]"]
set_property -dict {PACKAGE_PIN T22 IOSTANDARD LVDS_25} [get_ports "B13_L_P[17]"]
set_property -dict {PACKAGE_PIN R20 IOSTANDARD LVDS_25} [get_ports "B13_L_N[16]"]
set_property -dict {PACKAGE_PIN T20 IOSTANDARD LVDS_25} [get_ports "B13_L_P[16]"]
set_property -dict {PACKAGE_PIN T25 IOSTANDARD LVDS_25} [get_ports "B13_L_N[15]"]
set_property -dict {PACKAGE_PIN T24 IOSTANDARD LVDS_25} [get_ports "B13_L_P[15]"]
set_property -dict {PACKAGE_PIN R23 IOSTANDARD LVDS_25} [get_ports "B13_L_N[14]"]
set_property -dict {PACKAGE_PIN R22 IOSTANDARD LVDS_25} [get_ports "B13_L_P[14]"]
set_property -dict {PACKAGE_PIN P21 IOSTANDARD LVDS_25} [get_ports "B13_L_N[13]"]
set_property -dict {PACKAGE_PIN R21 IOSTANDARD LVDS_25} [get_ports "B13_L_P[13]"]
set_property -dict {PACKAGE_PIN N22 IOSTANDARD LVDS_25} [get_ports "B13_L_N[12]"]
set_property -dict {PACKAGE_PIN N21 IOSTANDARD LVDS_25} [get_ports "B13_L_P[12]"]
set_property -dict {PACKAGE_PIN N23 IOSTANDARD LVDS_25} [get_ports "B13_L_N[11]"]
set_property -dict {PACKAGE_PIN P23 IOSTANDARD LVDS_25} [get_ports "B13_L_P[11]"]
set_property -dict {PACKAGE_PIN M22 IOSTANDARD LVDS_25} [get_ports "B13_L_N[10]"]
set_property -dict {PACKAGE_PIN M21 IOSTANDARD LVDS_25} [get_ports "B13_L_P[10]"]
set_property -dict {PACKAGE_PIN P20 IOSTANDARD LVDS_25} [get_ports "B13_L_N[9]"]
set_property -dict {PACKAGE_PIN P19 IOSTANDARD LVDS_25} [get_ports "B13_L_P[9]"]
set_property -dict {PACKAGE_PIN L24 IOSTANDARD LVDS_25} [get_ports "B13_L_N[8]"]
set_property -dict {PACKAGE_PIN M24 IOSTANDARD LVDS_25} [get_ports "B13_L_P[8]"]
set_property -dict {PACKAGE_PIN M20 IOSTANDARD LVDS_25} [get_ports "B13_L_N[7]"]
set_property -dict {PACKAGE_PIN N19 IOSTANDARD LVDS_25} [get_ports "B13_L_P[7]"]
set_property -dict {PACKAGE_PIN P25 IOSTANDARD LVDS_25} [get_ports "B13_L_N[6]"]
set_property -dict {PACKAGE_PIN R25 IOSTANDARD LVDS_25} [get_ports "B13_L_P[6]"]
set_property -dict {PACKAGE_PIN M26 IOSTANDARD LVDS_25} [get_ports "B13_L_N[5]"]
set_property -dict {PACKAGE_PIN N26 IOSTANDARD LVDS_25} [get_ports "B13_L_P[5]"]
set_property -dict {PACKAGE_PIN N24 IOSTANDARD LVDS_25} [get_ports "B13_L_N[4]"]
set_property -dict {PACKAGE_PIN P24 IOSTANDARD LVDS_25} [get_ports "B13_L_P[4]"]
set_property -dict {PACKAGE_PIN L25 IOSTANDARD LVDS_25} [get_ports "B13_L_N[3]"]
set_property -dict {PACKAGE_PIN M25 IOSTANDARD LVDS_25} [get_ports "B13_L_P[3]"]
set_property -dict {PACKAGE_PIN P26 IOSTANDARD LVDS_25} [get_ports "B13_L_N[2]"]
set_property -dict {PACKAGE_PIN R26 IOSTANDARD LVDS_25} [get_ports "B13_L_P[2]"]
set_property -dict {PACKAGE_PIN K26 IOSTANDARD LVDS_25} [get_ports "B13_L_N[1]"]
set_property -dict {PACKAGE_PIN K25 IOSTANDARD LVDS_25} [get_ports "B13_L_P[1]"]

# PG_MGT_1V
set_property -dict {PACKAGE_PIN K23 IOSTANDARD LVCMOS33} [get_ports "B14_L_P[24]"]
# MIO13
set_property -dict {PACKAGE_PIN K22 IOSTANDARD LVCMOS33} [get_ports "B14_L_N[23]"]
# MIO10
set_property -dict {PACKAGE_PIN L22 IOSTANDARD LVCMOS33} [get_ports "B14_L_P[23]"]
# EN_MGT
set_property -dict {PACKAGE_PIN H22 IOSTANDARD LVCMOS33} [get_ports "B14_L_N[21]"]
# MIO14
set_property -dict {PACKAGE_PIN J21 IOSTANDARD LVCMOS33} [get_ports "B14_L_P[21]"]
# MIO12
set_property -dict {PACKAGE_PIN H23 IOSTANDARD LVCMOS33} [get_ports "B14_L_P[20]"]
# MIO9
set_property -dict {PACKAGE_PIN G21 IOSTANDARD LVCMOS33} [get_ports "B14_L_N[19]"]
# MIO0
set_property -dict {PACKAGE_PIN H21 IOSTANDARD LVCMOS33} [get_ports "B14_L_P[19]"]
# XIO
set_property -dict {PACKAGE_PIN H26 IOSTANDARD LVCMOS33} [get_ports "B14_L_N[18]"]
# PG_MGT_1V2
set_property -dict {PACKAGE_PIN G25 IOSTANDARD LVCMOS33} [get_ports "B14_L_P[16]"]
# MIO15
set_property -dict {PACKAGE_PIN G24 IOSTANDARD LVCMOS33} [get_ports "B14_L_P[14]"]
set_property -dict {PACKAGE_PIN F23 IOSTANDARD LVCMOS33} [get_ports "B14_L_N[13]"]
set_property -dict {PACKAGE_PIN G22 IOSTANDARD LVCMOS33} [get_ports "B14_L_P[13]"]
# PLL_SDA
#set_property -dict {PACKAGE_PIN B21 IOSTANDARD LVCMOS33} [get_ports "B14_L_N[10]"]
# PLL_SCL
#set_property -dict {PACKAGE_PIN A20 IOSTANDARD LVCMOS33} [get_ports "B14_L_N[8]"]
# PLL_IN4
set_property -dict {PACKAGE_PIN B20 IOSTANDARD LVCMOS33} [get_ports "B14_L_P[8]"]
# CLK_EN
set_property -dict {PACKAGE_PIN C26 IOSTANDARD LVCMOS33} [get_ports "B14_L_N[5]"]
set_property -dict {PACKAGE_PIN A24 IOSTANDARD LVCMOS33} [get_ports "B14_L_N[4]"]
set_property -dict {PACKAGE_PIN A23 IOSTANDARD LVCMOS33} [get_ports "B14_L_P[4]"]
# MIO11
set_property -dict {PACKAGE_PIN K21 IOSTANDARD LVCMOS33} [get_ports "B14_L_P[0]"]

set_property -dict {PACKAGE_PIN L18 IOSTANDARD LVDS_25} [get_ports "B15_L_N[23]"]
set_property -dict {PACKAGE_PIN M17 IOSTANDARD LVDS_25} [get_ports "B15_L_P[23]"]
set_property -dict {PACKAGE_PIN L20 IOSTANDARD LVDS_25} [get_ports "B15_L_N[21]"]
set_property -dict {PACKAGE_PIN L19 IOSTANDARD LVDS_25} [get_ports "B15_L_P[21]"]
set_property -dict {PACKAGE_PIN J19 IOSTANDARD LVDS_25} [get_ports "B15_L_N[20]"]
set_property -dict {PACKAGE_PIN J18 IOSTANDARD LVDS_25} [get_ports "B15_L_P[20]"]
set_property -dict {PACKAGE_PIN H18 IOSTANDARD LVDS_25} [get_ports "B15_L_N[14]"]
set_property -dict {PACKAGE_PIN H17 IOSTANDARD LVDS_25} [get_ports "B15_L_P[14]"]
set_property -dict {PACKAGE_PIN D18 IOSTANDARD LVDS_25} [get_ports "B15_L_N[13]"]
set_property -dict {PACKAGE_PIN E18 IOSTANDARD LVDS_25} [get_ports "B15_L_P[13]"]
set_property -dict {PACKAGE_PIN E17 IOSTANDARD LVDS_25} [get_ports "B15_L_N[12]"]
set_property -dict {PACKAGE_PIN F17 IOSTANDARD LVDS_25} [get_ports "B15_L_P[12]"]
set_property -dict {PACKAGE_PIN F18 IOSTANDARD LVDS_25} [get_ports "B15_L_N[11]"]
set_property -dict {PACKAGE_PIN G17 IOSTANDARD LVDS_25} [get_ports "B15_L_P[11]"]
set_property -dict {PACKAGE_PIN G16 IOSTANDARD LVDS_25} [get_ports "B15_L_N[7]"]
set_property -dict {PACKAGE_PIN H16 IOSTANDARD LVDS_25} [get_ports "B15_L_P[7]"]
set_property -dict {PACKAGE_PIN C18 IOSTANDARD LVDS_25} [get_ports "B15_L_N[5]"]
set_property -dict {PACKAGE_PIN C17 IOSTANDARD LVDS_25} [get_ports "B15_L_P[5]"]

set_property -dict {PACKAGE_PIN A15 IOSTANDARD LVDS_25} [get_ports "B16_L_N[23]"]
set_property -dict {PACKAGE_PIN B15 IOSTANDARD LVDS_25} [get_ports "B16_L_P[23]"]
set_property -dict {PACKAGE_PIN A14 IOSTANDARD LVDS_25} [get_ports "B16_L_N[21]"]
set_property -dict {PACKAGE_PIN B14 IOSTANDARD LVDS_25} [get_ports "B16_L_P[21]"]
# single-ended
set_property -dict {PACKAGE_PIN C13 IOSTANDARD LVCMOS25} [get_ports "B16_L_N[19]"]
set_property -dict {PACKAGE_PIN E12 IOSTANDARD LVDS_25} [get_ports "B16_L_N[18]"]
set_property -dict {PACKAGE_PIN E13 IOSTANDARD LVDS_25} [get_ports "B16_L_P[18]"]
set_property -dict {PACKAGE_PIN D13 IOSTANDARD LVDS_25} [get_ports "B16_L_N[17]"]
set_property -dict {PACKAGE_PIN D14 IOSTANDARD LVDS_25} [get_ports "B16_L_P[17]"]
set_property -dict {PACKAGE_PIN D11 IOSTANDARD LVDS_25} [get_ports "B16_L_N[14]"]
set_property -dict {PACKAGE_PIN E11 IOSTANDARD LVDS_25} [get_ports "B16_L_P[14]"]
set_property -dict {PACKAGE_PIN C11 IOSTANDARD LVDS_25} [get_ports "B16_L_N[13]"]
set_property -dict {PACKAGE_PIN C12 IOSTANDARD LVDS_25} [get_ports "B16_L_P[13]"]
set_property -dict {PACKAGE_PIN D10 IOSTANDARD LVDS_25} [get_ports "B16_L_N[12]"]
set_property -dict {PACKAGE_PIN E10 IOSTANDARD LVDS_25} [get_ports "B16_L_P[12]"]
set_property -dict {PACKAGE_PIN F10 IOSTANDARD LVDS_25} [get_ports "B16_L_N[11]"]
set_property -dict {PACKAGE_PIN G11 IOSTANDARD LVDS_25} [get_ports "B16_L_P[11]"]
# single-ended
set_property -dict {PACKAGE_PIN H11 IOSTANDARD LVCMOS25} [get_ports "B16_L_N[6]"]

# Local Variables:
# mode: tcl
# End:
