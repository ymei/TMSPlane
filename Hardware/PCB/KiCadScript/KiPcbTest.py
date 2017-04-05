#!/usr/bin/env python

## This file may be invoked outside of the KiCad GUI.
#
# It loads the .kicad_pcb file supplied as the first commandline
# argument.

import sys
import pcbnew
from KiAuto import *

if __name__ == '__main__':
    pn = pcbnew.LoadBoard(sys.argv[1])
    pn.BuildListOfNets() 

    board = pn.GetBoard()
    kp = KiPcbOp(board)
    kp.compute_layer_table()

    print(kp.layerTable)
    kp.print_list_of_nets()

    print kp.get_board_boundary()
    print kp.get_fp_pad_pos_netname("D1")

    kp.place_footprint("/usr/share/kicad/modules/Capacitors_SMD.pretty", "C_0603", "C1", (130e6,100e6))
    kp.set_footprint_nets("C1")

    vp = (mm(122),mm(100))
    np = kp.get_fp_pad_pos_netname("C1")
    kp.add_track(posList=[np[1][0], vp], netName=np[1][1])
    kp.add_via(vp, netName=np[1][1])

    vp1 = (mm(140),mm(110))
    kp.add_track(posList=[np[2][0], (mm(135), mm(102)), vp1], netName=np[2][1])
    kp.add_via(vp1, netName=np[2][1])

    kp.add_zone([[mil(4551), mil(4450)], [mil(5950), mil(4450)], [mil(5950), mil(3050)],
                 [mil(5000), mil(3150)], [mil(4551), mil(3350)]])
    
    board.Save("test.kicad_pcb")
