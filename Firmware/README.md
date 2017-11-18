# Topmetal-S charge plane control and readout
## Generate the project after git clone --recurse-submodules
```
# Make sure there are following lines in config/project.tcl:
    # Create project
    create_project top ./ # possibly with -part xc7k325tffg900-2
# then
    mkdir top; cd top/
    vivado -mode tcl -source ../config/project.tcl
# open GUI
    start_gui
# start synthesis
    launch_runs synth_1 -jobs 8
# start implementation
    launch_runs -jobs 8 impl_1 -to_step write_bitstream
# or do everything in tcl terminal
    open_project /path/to/example.xpr
    launch_runs -jobs 8 impl_1 -to_step write_bitstream
    wait_on_run impl_1
    exit
# project.tcl is generated via File->Write Project Tcl with everything unchecked.
```
* VHDL files need ```set_property "file_type" "VHDL" $file_obj``` while Verilog files don't.
* ```set_property BITSTREAM.General.UnconstrainedPins {Allow} [current_design]``` in .xdc can be useful.

## GTX / aurora 64b/66b
### KC705
* SMA and SFP rx/tx in package XC7K325TFFG900 are in bank/quad 117.
* a 125MHz fixed clock is provided at MGTREFCLK0 (GTXE2_COMMON_X0Y2)
* Si5324 clock in bank/quad 116 can be used to provide a second refclk to bank/quad 117 (GTXE2_COMMON_X0Y1)
* SMA_MGT_TX/RX are in GTXE2_CHANNEL_X0Y8 (select in aurora coregen)
* SFP_TX/RX are in GTXE2_CHANNEL_X0Y10.  Useful for LOC constraint.
#### Aurora 64B66B coregen
* Line Rate 10.0 Gbps
* GT Refclk 125.0 MHz
* INIT clk 100.0 MHz
* GT DRP clk 100.0 MHz
* Dataflow Mode Duplex
* Interface Streaming
* Flow Control UFC
* Unckeck USER K and Little Endian
* No framing, no CRC
* DRP Mode Native
* Uncheck Lab tools and additional ports
* DO NOT touch anything in GT selections.  Will select in .xdc.
* Shared logic in example design
* Copy ```aurora_64b66b_0_ex/aurora_64b66b_0_ex.srcs/shared_logic/*``` to ```src/aurora64b66b/KC705/```
* ```qpll``` section may need to be commented out.  Other modifications are marked with "ymei".

In `top', the byte ordering is handled by declaring all signals as ```(n DOWNTO 0)``` and assign directly to the core.  The core considers ```i=0``` as the MSB for sizes etc.  In HDL the direct assignment doesn't change bit order but considers arrays of wire-pins physically plug together regardless of the labeling.

### TE0741

Files in ```src/aurora64b66b/TE0741/``` may be identical to ```src/aurora64b66b/KC705/```.

## ten_gig_eth
When pcs_pma core is updated, open its example design and compare to the source to update.  Updates in the source were marked with --ymei

## Generating a PROM file (MCS)
### KC705
```
In iMPACT, select BPI Flash Configure Single FPGA
Kintex7 128M, MCS, x16, no extra data
BPI PROM, 28F00AP30T, 16 bit, RS Pins to 25:24
Erase before programming

Mode switch: M2 M1 M0
0 0 1 Master SPI x1, x2, x4
0 1 0 Master BPI x8, x16
1 0 1 JTAG

In Vivado, use the Tcl command:
write_cfgmem -format MCS -size 128 -interface BPIx16 -loadbit "up 0x0 top.runs/impl_1/top.bit" -file "../target/TMS1mmX19KC705.mcs"
Then in Hardware Manager, choose Micron density 1024Mb 28f00ap30t-bpi-x16
Pull-none, RS Pins 25:24
```
### TE0741
* 32 MByte QSPI Flash memory, Cypress S25FL256SAGBHI20, 3.3V.
* Do not erase nonvolatile QE (Quad Enable) bit on the TE0741 serial flash!  FPGA boot is supported only in 4 bit mode with QE enabled.
```
write_cfgmem -format MCS -size 256 -interface SPIx4 -loadbit "up 0x0 top.runs/impl_1/top.bit" -file "../target/TE0741.mcs"
```

## Register map
### KC705
| ```config_reg``` | Value composition                                       | Comment |
| ----------------:| ------------------------------------------------------- | ------- |
| ```pulse_reg```  |                                                         |         |
| 2                | idata_data_fifo_reset                                   |         |

### TE0741
| ```config_reg``` | Value composition                                       | Comment |
| ----------------:| ------------------------------------------------------- | ------- |
| 0                | 15~12'adc_clkff_div, 11~8'tms_clkff_div, 3'adc_sdrn_ddr, 2'adc_clk_src_sel, 1'tms_clk_src_sel, 0'tms_pwr_on | |
| 1                | 15~0'external SPI DAC data                              |         |
| 2                | 7~4'tms_sio_clk_div, 1~0'I2C mode | I2C mode: 0= 1byte r/w, 1= 2byte r/w |
| 3                | 15'I2C r/w, 14~8'I2C slave addr, 7~0'I2C slave reg addr |         |
| 4                | 15~8'I2C first byte, 7~0'I2C second byte                |         |
| 5~13             | 13:15~8'tms_sio_a, 13:7~2'tms_sio_clkdiv, 13:1~5:0'tms_sio_dout_130bits |       |
| 14               | 15~8'iodelay_channel, 4~0'iodelay value                 | CH=20 for adc is clk_lpbk, CH=38 for tms_sdm is clk_lpbk |
| ```status_reg``` |                                                         |         |
| 0                | 15~8'I2C first byte, 7~0'I2C second byte                |         |
| 1~9              | 9:1~1:0'tms_sio_din_130bits, 9:2'tms_sio_busy           |         |
| ```pulse_reg```  |                                                         |         |
| 0                | tms_reset                                               |         |
| 1                | external SPI DAC write one word                         |         |
| 2                | I2C read/write start                                    |         |
| 3                | tms_sio read/write start                                |         |
| 4                | tms_sdm iodelay_update                                  |         |
| 5                | adc external iodelay_update                             |         |
| 15               | aurora reset                                            |         |

## TMS SDM

Channels in data, as well as for iodelay_channel mapping, are interleaved as ```... SDM1_OUT2, SDM1_OUT1, SDM0_OUT2, SDM0_OUT1```.

## LTC2325-16 ADC

In pseudo-differential mode, REF=2.048V, AIN- is held at 1.024V, AIN+ is allowed to swing between 0 and REF, which corresponds to output code in the range from -16384 to 16383.  One LSB is 62.5uV.  ```Vi=1.024 + LSB * code```.

## Notes

* ODELAYE2 exists only in HP banks.
* .xdc file does not support sophisticated TCL features.  Rename the file to .tcl will let Vivado support it as a full TCL script.
* ```report_cdc -details -file cdc_report.txt``` to check clock domain crossing.
* ```set_clock_groups``` command with only one `-group' parameter means the clock is asynchronous to all other, including generated from its own, clocks.  So, explictly specify all possible clock group pairs in .xdc!
* ```set_input_delay``` ```-min +HOLD_TIME``` ```-max (CLOCK_PERIOD-SETUP_TIME)```.
* ```set_output_delay``` ```-min -HOLD_TIME``` ```-max SETUP_TIME```.
