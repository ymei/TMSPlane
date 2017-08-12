# TMS1mmX19 Carrier board (with TE0741 FPGA module)
## Features
1. TMS array power is logic (firmware/software) controlled through two TPS27081A switches.  Due to power-rail sharing, the relevant bias voltages and serial IO are also controlled by the switches.
2. Serial IO, SDI, SDO, SCK, are multiplexed to drive one column (chain) at a time.  SDI and SCK have `high' as their idle states.

## Power requirement

### LTC2325-16 ADC
1. DVDD2V5 for OVdd: 31.5mA max
2. AVDD3V3 for Vdd : 44.5mA max

5 ADCs total, DVDD2V5: 157.5mA, AVDD3V3: 222.5mA

### LMK00105 for distributing CNVn to ADCs
1. DVDD2V5: 48mA

### 100MHz clock + CDCLVD1208 Clock distribution to ADCs
1. DVDD2V5: 25 + 75mA = 100mA

### 25MHz clock + CDCLVD1208 Clock distribution to SDMs
1. DVDD2V5: 90 + 75mA = 165mA

### ADR3412 + OPA350 for LVDS_VREF
1. DVDD2V5: 1 + 8.5mA = 10mA

DVDD2V5 requires total 545.5mA

# TMS1mmX19 19-chip array bonding board
## Signals and layers
### 16-layer stack-up, for 19-chip array TMS1mmX19.  Thickness 75.6mil, 1oz copper
1  F.Cu    Top copper layer
2  In1.Cu  AGND
3  In2.Cu  GND_NMOSI, DAC_BufferX2_VREF
4  In3.Cu  Gring, Ref3
5  In4.Cu  Ref2
6  In5.Cu  SDM_VDD_Shield, GND_VREF
7  In6.Cu  LVDS_VREF, Ref1
8  In7.Cu  AVDD
9  In8.Cu  AGND fill + RESET (as traces), SDM_testIN (as traces)
10 In9.Cu  DGND fill + slow digital signals: SDI, SDO, SCK
11 In10.Cu SDM_OUT1
12 In11.Cu DGND
13 In12.Cu CLK_P
14 In13.Cu CLK_N, SDM_OUT2
15 In14.Cu DVDD
16 B.Cu    Bottom copper layer

## FABRICATION NOTES
**All notes are applicable unless otherwise specified**

1. Materials: Green clad FR-4/Epoxy glass or equivalent.  Dielectric constant 4.2+/-0.2.  See cross-section drawing for board thickness, copper weight and layer structures.  RoHS compliant.
2. Components on top (front) and bottom (back) layers.
3. Minimum signal trace width/spacing: 4/4 mils.
4. Drilling.
  1. Minimum drill size is 8mil.
  2. All plated holes are to be plated through and with minimum copper thickness of 1mil.
  3. Drill sizes specified are actual drill sizes.  Finished hole sizes are expected to be 3~4mil smaller than the drill size.
  4. All PTH are to be within +/-3mil from true positions, NPTH to be within +/-2mil.
  5. See hole size table in the supplied NC drill file.
5. Layer-to-layer (pattern-to-pattern) registration (alignment) shall be within +/-5mil.
6. Soldermask: both sides of board, Liquid Photo Imageable, soldermask over bare copper (SMOBC), green.
7. Warpage and twist to meet IPC class II.  Shall not exceed 7mil per inch measured at any location or direction on the board.
8. Silkscreen shall use white non-conductive epoxy or equivalent.  Ink is NOT allowed on exposed plated area.
9. Finish.
  1. Edges to be free of loose silver and rough edge.
  2. Finished board shall not have nicks, scratches, voids, exposed copper, poor plating or mis-drilled holes.
  3. Trace width tolerance = +/-1mil of specified trace width.
  4. ENIG (Electroless nickel immersion gold) finish over copper.
10. Delivered boards shall be free of dirt, oil, finger prints and other contaminants.
11. Remove non-functional pad on all inner layers.
12. Manufacture's UL marking, flammability rating, logo and data code to be placed in silkscreen on bottom side of the board.
13. Impedance control
  1. All 19mil-wide traces on outer layers shall be 50Ohm single-ended +/-10%
  2. All 6mil/6mil width/spacing traces, including 4mil/4mil on outer layers and 4mil/7mil on inner layers shall be 100Ohm differential +/-10%
