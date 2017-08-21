#Topmetal-S charge plane control and readout
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
