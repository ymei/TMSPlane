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

In `top', the byte ordering is handled by declaring all signals as ```(n DOWNTO 0)``` and assign directly to the core.  The core considers ```i=0``` as the MSB for sizes etc.  In HDL the direct assignment doesn't change bit order but considers arrays of wire-pins physically plug together regardless of the labeling.

## ten_gig_eth
When pcs_pma core is updated, open its example design and compare to the source to update.  Updates in the source were marked with --ymei

## Generating a PROM file (MCS)
### KC705
```
In iMPACT, select BPI Flash Configure Single FPGA
Kintex7 128M, MCS, x16, no extra data
BPI PROM, 28F00AP30, 16 bit, RS Pins to 25:24
Erase before programming

Mode switch: M2 M1 M0
0 0 1 Master SPI x1, x2, x4
0 1 0 Master BPI x8, x16
1 0 1 JTAG

In Vivado, use the Tcl command:
write_cfgmem -format MCS -size 128 -interface BPIx16 -loadbit "up 0x0 top/top.runs/impl_1/top.bit" target/FMC112IPv4Sel.mcs
Then in Hardware Manager, choose Micron density 1024Mb 28f00ap30t-bpi-x16
Pull-none, RS Pins 25:24
```
