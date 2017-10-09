#!/usr/bin/env python
# -*- coding: utf-8 -*-

## @package TMS1mmX19Config
# Config TMS1mmX19 array on TE0741 carrier
#

from __future__ import print_function
import math,sys,time,os,shutil
import socket
from command import *

## Manage Topmetal-S 1mm chip's internal register map.
# Allow combining and disassembling individual registers
# to/from long integer for I/O
#
class TMS1mmReg(object):
    ## @var _defaultRegMap default register values
    _defaultRegMap = {
        'DAC'    : [0x75c3, 0x8444, 0x7bbb, 0x7375, 0x86d4, 0xe4b2], # from DAC1 to DAC6
        'PD'     : [1, 1, 1, 1], # from PD1 to PD4, 1 means powered down
        'K'      : [1, 0, 1, 0, 1, 0, 0, 0, 0, 0], # from K1 to K10, 1 means closed (conducting)
        'vref'   : 0x8,
        'vcasp'  : 0x8,
        'vcasn'  : 0x8,
        'vbiasp' : 0x8,
        'vbiasn' : 0x8
    }
    ## @var register map local to the class
    _regMap = {}

    def __init__(self):
        self._regMap = copy.deepcopy(self._defaultRegMap)

    def set_dac(self, i, val):
        self._regMap['DAC'][i] = 0xffff & val

    def set_power_down(self, i, onoff):
        self._regMap['PD'][i] = 0x1 & onoff

    def set_k(self, i, onoff):
        self._regMap['K'][i] = 0x1 & onoff

    def set_vref(self, val):
        self._regMap['vref'] = val & 0xf

    def set_vcasp(self, val):
        self._regMap['vcasp'] = val & 0xf

    def set_vcasn(self, val):
        self._regMap['vcasn'] = val & 0xf

    def set_vbiasp(self, val):
        self._regMap['vbiasp'] = val & 0xf

    def set_vbiasn(self, val):
        self._regMap['vbiasn'] = val & 0xf

    ## Get long-integer variable
    def get_config_vector(self):
        ret = ( self._regMap['vbiasn'] << 126 |
                self._regMap['vbiasp'] << 122 |
                self._regMap['vcasn']  << 118 |
                self._regMap['vcasp']  << 114 |
                self._regMap['vref']   << 110 )
        for i in xrange(len(self._regMap['K'])):
            ret |= self._regMap['K'][i] << (len(self._regMap['K']) - i) + 99
        for i in xrange(len(self._regMap['PD'])):
            ret |= self._regMap['PD'][i] << (len(self._regMap['PD']) - i) + 95
        for i in xrange(len(self._regMap['DAC'])):
            ret |= self._regMap['DAC'][i] << (len(self._regMap['DAC'])-1 - i)*16
        return ret

    dac_fit_a = 4.35861E-5
    dac_fit_b = 0.0349427
    def dac_volt2code(self, v):

        c = int((v - self.dac_fit_b) / self.dac_fit_a)
        if c < 0:     c = 0
        if c > 65535: c = 65535
        return c

    def dac_code2volt(self, c):
        v = c * self.dac_fit_a + self.dac_fit_b
        return v

## Command generator for controlling DAC8568
#
class DAC8568(object):
 
    def __init__(self, cmd, regAddr=0x01, pulseAddr=1):
        self.cmd = cmd
	self.regAddr = regAddr
	self.pulseAddr = pulseAddr
    def DACVolt(self, x):
        return int(x / 2.5 * 65536.0 / 2.0)    #calculation
    def write_spi(self, val):
        ret = ""          # 32 bits 
        ret += self.cmd.write_register(self.regAddr, (val >> 16) & 0xffff)
        ret += self.cmd.send_pulse(1<<self.pulseAddr)
        ret += self.cmd.write_register(self.regAddr, val & 0xffff)
        ret += self.cmd.send_pulse(1<<self.pulseAddr)
        return ret
    def turn_on_2V5_ref(self):
        return self.write_spi(0x08000001)
    def set_voltage(self, ch, v):
        return self.write_spi((0x03 << 24) | (ch << 20) | (self.DACVolt(v) << 4))

## TMS serial io r/w
# @param[in] colAddr TMS array column address.
# @param[in] dout 130bit register val
def tms_sio_rw(s, cmd, colAddr, dout, clkDiv=7, configRegId=5, dcfgBase=6, dstatBase=1, pulseRegId=3):
    # column address and clock div
    cmdStr = cmd.write_register(configRegId, clkDiv<<8 | colAddr)
    s.sendall(cmdStr)
    # drive dout
    cmdStr = ""
    for i in xrange(9):
        cmdStr += cmd.write_register(dcfgBase+i, (dout >> i*16) & 0xffff)
    cmdStr += cmd.send_pulse(1<<pulseRegId)
    s.sendall(cmdStr)
    # readback
    time.sleep(0.2)
    cmdStr = ""
    for i in xrange(9):
        cmdStr += cmd.read_status(8-i + dstatBase)
    s.sendall(cmdStr)
    retw = s.recv(4*9)
    ret = 0
    for i in xrange(9):
        ret = ret | ( int(ord(retw[i*4+2])) << ((8-i) * 16 + 8) |
                      int(ord(retw[i*4+3])) << ((8-i) * 16))
    ret = ret & 0x3ffffffffffffffffffffffffffffffff
    print("Return: 0x{:0x}".format(ret))
    return ret

if __name__ == "__main__":

    host = '192.168.2.3'
    port = 1025
    s = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
    s.connect((host,port))
#
    cmd = Cmd()

    dac8568 = DAC8568(cmd)
    s.sendall(dac8568.turn_on_2V5_ref())
    s.sendall(dac8568.set_voltage(0, 1.2))
    s.sendall(dac8568.set_voltage(1, 1.024))
    s.sendall(dac8568.set_voltage(2, 1.65))

    time.sleep(0.1)

    tms_pwr_on = 1
    tms_clk_src_sel = 0 # 0: FPGA, 1: external
    tms_clkff_div = 1 # /2**x, 0 disables clock
    adc_clk_src_sel = 1
    adc_clkff_div = 1
    adc_sdrn_ddr = 0 # 0: sdr, 1: ddr
    cmdStr  = cmd.write_register(0, adc_clkff_div   <<12 |
                                    tms_clkff_div   << 8 |
                                    adc_sdrn_ddr    << 3 |
                                    adc_clk_src_sel << 2 |
                                    tms_clk_src_sel << 1 |
                                    tms_pwr_on)
    cmdStr += cmd.write_register(2, 0x0001) # write 1-byte to I2C reg
    cmdStr += cmd.write_register(3, 0<<15 | 0x4c<<8 | 0x02)
    cmdStr += cmd.send_pulse(1<<2)
    s.sendall(cmdStr)
    time.sleep(0.001)
    cmdStr  = cmd.write_register(2, 0x0000) # read 1-byte from I2C
    cmdStr += cmd.write_register(3, 1<<15 | 0x4c<<8 | 0x01)
    cmdStr += cmd.send_pulse(1<<2)
    s.sendall(cmdStr)
    time.sleep(0.001)
    cmdStr  = cmd.read_status(0)
    s.sendall(cmdStr)
    ret = s.recv(4)
    print(":".join("{:02x}".format(ord(c)) for c in ret))
#
    tms_sio_rw(s, cmd, 4, 0xa)
#
    s.close()

