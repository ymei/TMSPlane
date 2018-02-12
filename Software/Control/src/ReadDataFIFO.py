#!/usr/bin/env python
# -*- coding: utf-8 -*-

## @package ReadDataFIFO
# test reading datafifo
#

from __future__ import print_function
from __future__ import division
import math,sys,time,os,shutil
import socket
import argparse
import pprint
from command import *

def demux_fifodata(fData, adcVoffset=1.024, adcLSB=62.5e-6):
    wWidth = 512
    bytesPerSample = wWidth // 8
    nADCs = 20
    if type(fData[0]) == str:
        fD = bytearray(fData)
    else:
        fD = fData
    if len(fD) % bytesPerSample != 0:
        return []
    nSamples = len(fD) // bytesPerSample
    ary = []
    for i in range(nSamples):
        adcVs = []
        for j in range(nADCs):
            idx0 = bytesPerSample - 1 - j*2
            v = ( fD[i * bytesPerSample + idx0 - 1] << 8
                | fD[i * bytesPerSample + idx0])
            # convert to signed int
            v = (v ^ 0x8000) - 0x8000
            # convert to actual volts
            adcVs.append(v * adcLSB + adcVoffset)
        ary.append(adcVs)
    return ary

if __name__ == "__main__":

    parser = argparse.ArgumentParser(formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument("-c", "--control-ip-port", type=str, default="192.168.2.3:1024", help="main control system ipaddr and port")
    args = parser.parse_args()

    ctrlipport = args.control_ip_port.split(':')
    s = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
    s.connect((ctrlipport[0],int(ctrlipport[1])))
#
    cmd = Cmd()
#
    # reset data fifo
    s.sendall(cmd.send_pulse(1<<2));
    time.sleep(0.5)

    # FPGA internal fifo : 512 bit width x 16384 depth
    nWords = (512 // 32) * 16384
    nBytes = nWords * 4
    buf = bytearray(nBytes)
    print("nBytes = {:d}".format(nBytes))
    ret = cmd.acquire_from_datafifo(s, nWords, buf)
    print("Returned {:d} bytes.".format(len(ret)))
    #print(":".join("{:02x}".format(ord(c)) for c in ret))
#
    pprint.pprint(demux_fifodata(ret), width=1000)
#
    s.close()
