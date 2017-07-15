#!/usr/bin/env python

## \file
# This file should be invoked outside of the KiCad GUI.
# Generate layout of Topmetal-S array using 2 external DACs per sensor.
#
# usage: GenPcbAout1or2.py [-h] [-n NCHIPS] ifn ucfn ofn
#
# positional arguments:
#   ifn                   Input file with layers already setup and netlist
#                         loaded
#   ucfn                  Unit cell file with internal tracks laid out
#   ofn                   Output file
#
# optional arguments:
#   -h, --help            show this help message and exit
#   -n NCHIPS, --nchips NCHIPS
#                         Number of chips to place [127]
#   -p PITCH, --pitch PITCH
#                         Pitch between chips [8]mm
#   -v, --verbose
#

from __future__ import print_function

import sys
import argparse

import pcbnew
from KiAuto import *
from KiAuto.HexLib import *

def get_unitcell_caps(fname, ref="U0"):
    Cn = []

    pn = pcbnew.LoadBoard(fname)
    board = pn.GetBoard()
    kp = KiPcbOp(board)
    mod = board.FindModuleByReference(ref)
    if mod == None:
        return None
    center = mod.GetPosition()

    i = 0
    while True:
        ref = "C{:d}".format(i)
        i = i + 1
        mod = board.FindModuleByReference(ref)
        if mod == None:
            break
        loc = mod.GetPosition() - center
        rot = mod.GetOrientation()
        layerId = mod.GetLayer()
        flip = mod.IsFlipped()
        Cn.append([ref, loc, rot, layerId, flip])
    return Cn

def move_array_elements(board, center=(mil(5500),mil(4250)), pitch=mm(8), nchips=127, caps=None):
    hex = Hex()
    kp = KiPcbOp(board)
    for i in xrange(nchips):
        qr = hex.l2qr(i)
        xy = hex.qr2xy(pitch, qr)
        loc = (xy[0]+center[0], center[1]-xy[1])
        ref = "U{:d}".format(i)
        kp.move_footprint(ref, loc, rot=0.0)
        if caps:
            for ci in caps:
                j = int(ci[0][1:])
                ref = "C{:d}".format(i*10+j)
                cloc = (loc[0] + ci[1][0], loc[1] + ci[1][1])
                rot = ci[2]
                flip = ci[4]
                if(flip):
                    layerId = None
                else:
                    layerId = ci[3]
                kp.move_footprint(ref, cloc, rot, layerId, flip)

def get_unitcell_tracks(fname, ref="U0"):
    pn = pcbnew.LoadBoard(fname)
    pn.BuildListOfNets()
    board = pn.GetBoard()
    kp = KiPcbOp(board)
    np = kp.get_fp_pad_pos_netname(ref)
    mod = board.FindModuleByReference(ref)
    if mod == None:
        return None
    center = mod.GetPosition()
    nt = {}
    for k,v in np.items():
        netname = v[1]
        tracks = []
        for track in board.TracksInNet(board.GetNetcodeFromNetname(netname)):
            start = track.GetStart() - center
            end = track.GetEnd() - center
            width = track.GetWidth()
            layerId = track.GetLayer()
            tracks.append(([start,end],(width, layerId)))
        nt[k] = tracks
    return nt

def add_tracks_in_cell(pidTracks, board, ref="U0"):
    kp = KiPcbOp(board)
    np = kp.get_fp_pad_pos_netname(ref)
    mod = board.FindModuleByReference(ref)
    if mod == None:
        return None
    center = mod.GetPosition()
    for k,v in np.items():
        netname = v[1]
        for track in pidTracks[k]:
            posList = [track[0][0] + center, track[0][1] + center]
            width = track[1][0]
            layerId = track[1][1]
            kp.add_track(posList, width, layerId, netname)

if __name__ == '__main__':

    parser = argparse.ArgumentParser()
    parser.add_argument("-n", "--nchips", type=int, default=127,
                        help="Number of chips to place [127]")
    parser.add_argument("-p", "--pitch", type=float, default=8.0,
                        help="Pitch between chips [8]mm")
    parser.add_argument("-v", "--verbose", action="count")
    parser.add_argument("ifn", type=str,
                        help="Input file with layers already setup and netlist loaded")
    parser.add_argument("ucfn", type=str,
                        help="Unit cell file with internal tracks laid out")
    parser.add_argument("ofn", type=str, default="out.kicad_pcb",
                        help="Output file")

    args = parser.parse_args()

    pn = pcbnew.LoadBoard(args.ifn)
    pn.BuildListOfNets()

    board = pn.GetBoard()
    kp = KiPcbOp(board)
    kp.compute_layer_table()

    if args.verbose:
        print(kp.layerTable)
        print(kp.get_board_boundary())
        if args.verbose > 1:
            kp.print_list_of_nets()

    Cn = get_unitcell_caps(args.ucfn)
    move_array_elements(board, nchips=args.nchips, pitch=mm(args.pitch), caps=Cn)

    pidTracks = get_unitcell_tracks(args.ucfn)
    for i in xrange(args.nchips):
        add_tracks_in_cell(pidTracks, board, ref="U{:d}".format(i))

    board.DeleteZONEOutlines()
    corners=[[mil(2500), mil(1250)], [mil(8500), mil(1250)], [mil(8500), mil(7250)],
             [mil(2500), mil(7250)]]
    layerNet = [["In1.Cu", "AGND"], ["In2.Cu", "AVDD"], ["In3.Cu", "DGND"], ["In4.Cu", "DVDD"],
                ["In5.Cu", "Ref1"], ["In6.Cu", "Ref2"], ["In7.Cu", "Ref3"], ["In8.Cu", "DGND"],
                ["In9.Cu", "Gring"], ["In10.Cu", "DAC_BufferX2_VREF"],
                ["In11.Cu", "SDM_VDD_Shield"], ["In12.Cu", "LVDS_VREF"],
                ["In13.Cu", "GND_NMOSI"], ["In14.Cu", "GND_VREF"], ["In15.Cu", "RESET"],
                ["In16.Cu", "SDM_testIN"]]
    for ln in layerNet:
        kp.add_zone(corners, kp.layer_name_to_id(ln[0]), ln[1])

    pcbnew.SaveBoard(args.ofn, board)
