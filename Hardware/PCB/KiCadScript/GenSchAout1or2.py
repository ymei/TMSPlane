#!/usr/bin/env python

## \file
# Generate schematic of Topmetal-S array using 2 external DACs per sensor.
#
# usage: GenSchAout1or2.py [-h] [-n NCHIPS] [-p PITCH] ofn
#
# positional arguments:
#   ofn                   Output file [.sch]
#
# optional arguments:
#   -h, --help            show this help message and exit
#   -n NCHIPS, --nchips NCHIPS
#                         Number of chips to place [127]
#   -p PITCH, --pitch PITCH
#                         Pitch between chip symbols [4000]
#

from __future__ import print_function

import sys
import argparse

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
    21 : "CLK_{}_N",
    22 : "CLK_{}_P",
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
    44 : "CSA_VBIASP_{}", # DAC2
    45 : "", # AOUT2_CSA
    46 : "AOUT1_CSA_{}",
    47 : "AGND",
    48 : "AVDD",
    49 : "AGND",
    50 : "AVDD"
}

def get_labels(id, template):
    hex = Hex()
    labels = []
    qr = hex.l2qr(id)
    l = hex.qr2l((qr[0], qr[1]-1))
    for i in xrange(len(template)):
        v = template[i+1]
        if 'SCK_{}' in v or 'CLK_{}' in v:
            labels.append(v.format(qr[0]))
        elif i+1 == 24:
            labels.append(v.format(l))
        elif '{}' in v:
            labels.append(v.format(id))
        else:
            labels.append(v)
    return labels

if __name__ == "__main__":

    parser = argparse.ArgumentParser()
    parser.add_argument("-n", "--nchips", type=int, default=127,
                        help="Number of chips to place [127]")
    parser.add_argument("-p", "--pitch", type=int, default=4000,
                        help="Pitch between chip symbols [4000]")
    parser.add_argument("-l", "--ltype", type=str, default="G", choices=["L", "H", "G"],
                        help="Label type, L (local), H, or G (global) [G]")
    parser.add_argument("ofn", type=str, default="out.sch",
                        help="Output file [.sch]")
    args = parser.parse_args()

    hex = Hex()
    # print(TMS1mmNetTemplate[5].format(5))

    sch = KiSch()
    sheetid = 1
    sheettot = 1
    if args.ltype != "L":
        sheetid = 2
        sheettot = 3
    sch.set_descr(paper="User 20000 22000", sheetid=sheetid, sheettot=sheettot,
                  title="Topmetal-S array")
    sch.add_to_libs("LIBS:TMSch\n")
    comps = ""
    schCenter = (10000, 11000)
    cnYoff = 1650
    cnXp = 500

    for i in xrange(args.nchips):
        qr = hex.l2qr(i)
        xy = hex.qr2xy(args.pitch, qr)

        loc = (int(xy[0])+schCenter[0], schCenter[1]-int(xy[1]))
        labels = get_labels(i, TMS1mmNetTemplate)
        Un = KiSchCompTMS1mm("U{}".format(i), loc, val="TMS1mm", fp="Topmetal:TMS1mmAout1or2",
                             labels=labels, ltype=args.ltype)
        comps += str(Un)
        Cn = []
        Ln = []
        for j in xrange(3):
            cloc = (loc[0]-cnXp+j*cnXp, loc[1]+cnYoff)
            Cn.append(KiSchCompC("C{}".format(i*10+j), cloc, val="1u", fp="Capacitors_SMD:C_0603"))
            if j == 0:
                Ln.append(KiSchLabel("DGND", (cloc[0], cloc[1]+150), ltype=args.ltype))
                Ln.append(KiSchLabel("DVDD", (cloc[0], cloc[1]-150), ltype=args.ltype))
            else:
                Ln.append(KiSchLabel("AGND", (cloc[0], cloc[1]+150), ltype=args.ltype))
                Ln.append(KiSchLabel("AVDD", (cloc[0], cloc[1]-150), ltype=args.ltype))
        for Ci in Cn:
            comps += str(Ci)
        for Li in Ln:
            comps += str(Li)

    sch.set_content(comps)
    with open(args.ofn, "w") as ofile:
        ofile.write(str(sch))
