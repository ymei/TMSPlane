#!/usr/bin/env python

## \file
# Generate schematic of Topmetal-S array
#
from __future__ import print_function

import sys
from KiAuto import *
from KiAuto.HexLib import *

TMS1mmNetTemplate = {
    1 : "Gring",
    2 : "AVDD",
    3 : "AGND",
    4 : "GND_NMOSI",
    5 : "CSA_VREF_{}", # DAC6
    6 : "CSA_VREF_{}",
    7 : "CSA_VDIS_{}", # DAC5
    8 : "CSA_VDIS_{}",
    9 : "VCASN_{}",    # DAC3
    10 : "VCASN_{}",
    11 : "VCASP_{}",   # DAC4
    12 : "VCASP_{}",
    13 : "DVDD",
    14 : "DGND",
    15 : "LVDS_VREF",
    16 : "RESET",
    17 : "SDM_OUT2_{}_P",
    18 : "SDM_OUT2_{}_N",
    19 : "SDM_OUT1_{}_N",
    20 : "SDM_OUT1_{}_P",
    21 : "CLK_N",
    22 : "CLK_P",
    23 : "SCK_{}",
    24 : "SDO_{}", # this sensor's SDI fed by another chip's SDO
    25 : "SDO_{}",
    26 : "SDM_VDD_Shield",
    27 : "AVDD",
    28 : "AGND",
    29 : "SDM_BIAS_{}", # IN
    30 : "SDM_BIAS_{}", # OUT
    31 : "GND_VREF",
    32 : "Ref3",
    33 : "Ref1",
    34 : "Ref2",
    35 : "SDM_testIN",
    36 : "", # AOUT3N_CSA
    37 : "", # AOUT3P_CSA
    38 : "", # AOUT_BufferX2
    39 : "", # BufferX2_testIN
    40 : "DAC_BufferX2_VREF",
    41 : "CSA_VBIASN_{}",
    42 : "CSA_VBIASN_{}", # DAC1
    43 : "CSA_VBIASP_{}",
    44 : "CSA_VBIASP_{}", # DAC 2
    45 : "", # AOUT2_CSA
    46 : "", # AOUT1_CSA
    47 : "AGND",
    48 : "AVDD",
    49 : "AGND",
    50 : "AVDD"
}

if __name__ == "__main__":
    print(TMS1mmNetTemplate[5].format(5))

    sch = KiSch()
    sch.set_descr(title="Topmetal-S array")
    sch.add_to_libs("LIBS:TMSch\n")

    labels = [v for v in TMS1mmNetTemplate.values()]
    U1 = KiSchCompTMS1mm("U1", loc=(8500,5500), val="TMS1mm", fp="Topmetal:TMS1mm", labels=labels)
    sch.set_content(str(U1))

    with open(sys.argv[1], "w") as ofile:
        ofile.write(str(sch))
