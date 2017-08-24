#!/usr/bin/env python
# -*- coding: utf-8 -*-

## @package aurora
# test aurora_64b66b interface on KC705 and TE0741
#

from __future__ import print_function
import math,sys,time,os,shutil
import socket
from command import *

if __name__ == "__main__":

    host = '192.168.2.3'
    port = 1024
    s = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
    s.connect((host,port))
#
    cmd = Cmd()
#
    s.sendall(cmd.send_pulse(1<<1));
    time.sleep(0.1)

    cmdStr  = cmd.write_register(29, 8-1)
    cmdStr += cmd.write_register(30, 0x5555)
    cmdStr += cmd.send_pulse(1<<8)
    s.sendall(cmdStr)
#
    s.close()
