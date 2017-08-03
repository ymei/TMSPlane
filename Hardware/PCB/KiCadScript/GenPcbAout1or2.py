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

import math
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

##
# Move connectors and mounting holes.
#
def move_js_ss(board, center=(mil(5500),mil(4250)), joff=mil(1350), njs=4):
    kp = KiPcbOp(board)
    refCtrRot = [["J1", (center[0], center[1]+joff), 0*10],
                 ["J2", (center[0]+joff, center[1]), 90*10],
                 ["J3", (center[0], center[1]-joff), 180*10],
                 ["J4", (center[0]-joff, center[1]), 270*10]]
    for rcr in refCtrRot:
        kp.move_footprint(rcr[0], rcr[1], rcr[2])
    refCtrS = [["S1", (center[0]-joff, center[1]+joff)],
               ["S2", (center[0]+joff, center[1]+joff)],
               ["S3", (center[0]+joff, center[1]-joff)],
               ["S4", (center[0]-joff, center[1]-joff)]]
    for rc in refCtrS:
        kp.move_footprint(rc[0], rc[1])

##
# Move R's and add tracks
#
def add_rs_tracks(board, center=(mil(5500),mil(4250)), pitch=mm(8), colS=-2, colE=2,
                  fingerOffL=mil(80), fingerOffR=mil(80), fhU=mil(850), fhD=mil(850),
                  tipClear=mil(200),
                  rXoff=mil(-21), rYoff=mil(950), hU=mil(1020), hD=mil(1020), trackWidth=mil(4),
                  copperClear=mil(4), viaSize=mil(22), viaDrill=mil(8)):
    kp = KiPcbOp(board)
    pitchH = pitch/2.0*math.sqrt(3.0)
    # RESET and SDM_testIN
    for c in xrange(colS, colE+1):
        cx = center[0] + c * pitchH
        cy = center[1]
        kp.add_track([[cx-fingerOffL, cy-fhU], [cx-fingerOffL, cy+fhD-tipClear]],
                     trackWidth, kp.layer_name_to_id("In4.Cu"), "RESET")
        kp.add_track([[cx+fingerOffR, cy-fhU+tipClear], [cx+fingerOffR, cy+fhD]],
                     trackWidth, kp.layer_name_to_id("In4.Cu"), "SDM_testIN")
    kp.add_track([[center[0] + colS * pitchH - fingerOffL, cy-fhU],
                  [center[0] + colE * pitchH - fingerOffL, cy-fhU]],
                 trackWidth, kp.layer_name_to_id("In4.Cu"), "RESET")
    kp.add_track([[center[0] + colS * pitchH + fingerOffR, cy+fhD],
                  [center[0] + colE * pitchH + fingerOffR, cy+fhD]],
                 trackWidth, kp.layer_name_to_id("In4.Cu"), "SDM_testIN")
    # clocks
    tipOff = viaSize/2.0 + copperClear/2.0
    rNames = ["R_C-2", "R_C-1", "R_C0", "R_C1", "R_C2"]
    for rn in rNames:
        x = int(rn.split("C")[1])
        netNameP = "CLK_{:d}_P".format(x)
        netNameN = "CLK_{:d}_N".format(x)
        kp.move_footprint(rn, (center[0]+pitchH*x+rXoff, center[1]+rYoff), 0.0, None, True)
        # P
        kp.add_via([center[0]+pitchH*x+rXoff+tipOff, center[1]-hU-tipOff], netName=netNameP,
                   size=viaSize, drill=viaDrill)
        kp.add_track([[center[0]+pitchH*x+rXoff+tipOff, center[1]-hU-tipOff],
                      [center[0]+pitchH*x+rXoff, center[1]-hU],
                      [center[0]+pitchH*x+rXoff, center[1]+hD],
                      [center[0]+pitchH*x+rXoff-tipOff, center[1]+hD+tipOff]],
                     trackWidth, kp.layer_name_to_id("In10.Cu"), netNameP)
        kp.add_via([center[0]+pitchH*x+rXoff-tipOff, center[1]+hD+tipOff], netName=netNameP,
                   size=viaSize, drill=viaDrill)
        # N
        kp.add_via([center[0]+pitchH*x+rXoff-tipOff, center[1]-hU-tipOff], netName=netNameN,
                   size=viaSize, drill=viaDrill)
        kp.add_track([[center[0]+pitchH*x+rXoff-tipOff, center[1]-hU-tipOff],
                      [center[0]+pitchH*x+rXoff, center[1]-hU],
                      [center[0]+pitchH*x+rXoff, center[1]+hD],
                      [center[0]+pitchH*x+rXoff+tipOff, center[1]+hD+tipOff]],
                     trackWidth, kp.layer_name_to_id("In11.Cu"), netNameN)
        kp.add_via([center[0]+pitchH*x+rXoff+tipOff, center[1]+hD+tipOff], netName=netNameN,
                   size=viaSize, drill=viaDrill)
##
# Add interleaved fingers of copper zones to fill a plane with 2 signals
#
def add_finger_plane2(board, layerId, signals=("", ""), colS=-2, colE=2,
                      center=(mil(5500),mil(4250)), pitch=mm(8),
                      copperClear=mil(6), fingerOffL=mil(60), fingerOffR=mil(60),
                      hU=mil(1000), hD=mil(1000),
                      busBarL=mil(1550), busBarR=mil(1550), busBarH=mil(170)):
    pitchH = pitch/2.0*math.sqrt(3.0)
    fingerWidthL = pitchH/2.0 - copperClear/2.0 - fingerOffL
    fingerWidthR = pitchH/2.0 - copperClear/2.0 - fingerOffR

    kp = KiPcbOp(board)
    # bus bar at the top for left-column signal
    kp.add_zone([[center[0]-busBarL, center[1]-hU], [center[0]+busBarR, center[1]-hU],
                 [center[0]+busBarR, center[1]-hU+busBarH],
                 [center[0]-busBarL, center[1]-hU+busBarH]],
                layerId, signals[0])
    # bus bar at the bottom for right-column signal
    kp.add_zone([[center[0]-busBarL, center[1]+hD], [center[0]+busBarR, center[1]+hD],
                 [center[0]+busBarR, center[1]+hD-busBarH],
                 [center[0]-busBarL, center[1]+hD-busBarH]],
                layerId, signals[1])
    for c in xrange(colS, colE+1):
        cx = center[0] + c * pitchH
        cy = center[1]
        # left-column
        kp.add_zone([[cx-fingerOffL-fingerWidthL, cy-hU+busBarH-copperClear],
                     [cx-fingerOffL,              cy-hU+busBarH-copperClear],
                     [cx-fingerOffL,              cy+hD-busBarH-copperClear],
                     [cx-fingerOffL-fingerWidthL, cy+hD-busBarH-copperClear]],
                    layerId, signals[0])
        # right-column
        kp.add_zone([[cx+fingerOffR,              cy-hU+busBarH+copperClear],
                     [cx+fingerOffR+fingerWidthR, cy-hU+busBarH+copperClear],
                     [cx+fingerOffR+fingerWidthR, cy+hD-busBarH+copperClear],
                     [cx+fingerOffR,              cy+hD-busBarH+copperClear]],
                    layerId, signals[1])

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
    move_js_ss(board)
    add_rs_tracks(board)

    pidTracks = get_unitcell_tracks(args.ucfn)
    for i in xrange(args.nchips):
        add_tracks_in_cell(pidTracks, board, ref="U{:d}".format(i))

    board.DeleteZONEOutlines()
    corners0=[[mil(3950), mil(2700)], [mil(7050), mil(2700)], [mil(7050), mil(5800)],
              [mil(3950), mil(5800)]]
    corners1=[[mil(3950), mil(3250)], [mil(7050), mil(3250)], [mil(7050), mil(5250)],
              [mil(3950), mil(5250)]]
    layerNet = [["In1.Cu", "AGND", corners1],
                ["In4.Cu", "Ref2", corners1],
                ["In7.Cu", "AVDD", corners1],
                ["In8.Cu", "AGND", corners1],
                ["In9.Cu", "DGND", corners0],
                ["In11.Cu", "DGND", corners0],
                ["In14.Cu", "DVDD", corners0]]
    for ln in layerNet:
        kp.add_zone(ln[2], kp.layer_name_to_id(ln[0]), ln[1])

    add_finger_plane2(board, kp.layer_name_to_id("In2.Cu"),
                      signals=("GND_NMOSI", "DAC_BufferX2_VREF"))
    add_finger_plane2(board, kp.layer_name_to_id("In3.Cu"),
                      signals=("Gring", "Ref3"))
    add_finger_plane2(board, kp.layer_name_to_id("In5.Cu"),
                      signals=("SDM_VDD_Shield", "GND_VREF"))
    add_finger_plane2(board, kp.layer_name_to_id("In6.Cu"),
                      signals=("LVDS_VREF", "Ref1"))

    pcbnew.SaveBoard(args.ofn, board)
