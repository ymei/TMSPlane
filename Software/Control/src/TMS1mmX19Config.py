#!/usr/bin/env python
# -*- coding: utf-8 -*-

## @package TMS1mmX19Config
# Config TMS1mmX19 array on TE0741 carrier
#

from __future__ import print_function
import math,sys,time,os,shutil
import copy
import socket
import argparse
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
        'K'      : [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], # from K1 to K10, 1 means closed (conducting)
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

## Command generator for controlling LTC2990 via I2C
#
class LTC2990(object):

    def __init__(self, cmd, slaveAddr, modeRegAddr=0x02, addrRegAddr=0x03,
                 wrDataRegAddr=0x04, rdDataRegAddr=0x0, pulseAddr=2, rwDelay=0.1):
        self.cmd = cmd
        self.slaveAddr = slaveAddr
        self.modeRegAddr = modeRegAddr
        self.addrRegAddr = addrRegAddr
        self.wrDataRegAddr = wrDataRegAddr
        self.rdDataRegAddr = rdDataRegAddr
        self.pulseAddr = pulseAddr
        self.rwDelay = rwDelay

    ## Write data via i2c
    # @param[in] data first and second byte to write as a list
    def i2c_write_data(self, s, slaveAddr, regAddr, data=[]):
        nbytes = len(data)
        d0 = 0
        d1 = 0
        if nbytes > 0:
            d0 = data[0]
        if nbytes > 1:
            d1 = data[1]
        mode = nbytes
        cmdStr  = ""
        cmdStr += cmd.write_register(self.modeRegAddr, mode)
        cmdStr += cmd.write_register(self.addrRegAddr, 0x7fff & ((slaveAddr << 8) | regAddr))
        cmdStr += cmd.write_register(self.wrDataRegAddr, d0 << 8 | d1)
        cmdStr += cmd.send_pulse(1<<self.pulseAddr)
        s.sendall(cmdStr)
        time.sleep(self.rwDelay)
        return cmdStr

    ## Read data from i2c
    # One shall write the regAddr (to be read) with no data before calling read.
    def i2c_read_data(self, s, slaveAddr, nbytes=1):
        mode = 0
        if nbytes > 0:
            mode = nbytes - 1
        cmdStr  = ""
        cmdStr += cmd.write_register(self.modeRegAddr, mode)
        cmdStr += cmd.write_register(self.addrRegAddr, 0x8000 | (slaveAddr << 8))
        cmdStr += cmd.send_pulse(1<<self.pulseAddr)
        s.sendall(cmdStr)
        time.sleep(self.rwDelay)
        cmdStr = cmd.read_status(self.rdDataRegAddr)
        s.sendall(cmdStr)
        ret = s.recv(4, socket.MSG_WAITALL)
        return [ord(c) for c in ret[2:]]

    def read_all_registers(self, s):
        ret = []
        for regAddr in xrange(16):
            self.i2c_write_data(s, self.slaveAddr, regAddr, [])
            val = self.i2c_read_data(s, self.slaveAddr)[0]
            ret.append([regAddr, val])
        return ret

    ## Set to measure TR1 and TR2
    def set_temperature_measurement(self, s):
        self.i2c_write_data(s, self.slaveAddr, 1, [0x3<<3 | 0x5])

    ## Set to measure V1-V2 and V3-V4
    def set_vdiff_measurement(self, s):
        self.i2c_write_data(s, self.slaveAddr, 1, [0x3<<3 | 0x6])

    ## Return in deg Celsius
    # @param[in] src source, 4: internal, 6: TR1, 10: TR2
    def get_temperature(self, s, src=4):
        self.i2c_write_data(s, self.slaveAddr, src, [])
        val = self.i2c_read_data(s, self.slaveAddr, 2)
        return ((val[0] & 0x7f) << 8 | val[1]) * 0.0625

    ## @return differential volts
    def get_vdiffs(self, s):
        vs = []
        for src in [6, 10]:
            self.i2c_write_data(s, self.slaveAddr, src, [])
            vs.append(self.i2c_read_data(s, self.slaveAddr, 2))
        vd = []
        for val in vs:
            sign = (val[0] >> 6) & 0x1
            if sign==0:
                sign = 1
            else:
                sign = -1
            v = ((val[0] & 0x3f) << 8 | val[1]) * 19.42e-6 * sign
            vd.append(v)
        return vd

    ## @return Vcc in volts
    def get_vcc(self, s):
        self.i2c_write_data(s, self.slaveAddr, 0x0e, [])
        val = self.i2c_read_data(s, self.slaveAddr, 2)
        return ((val[0] & 0x3f) << 8 | val[1]) * 305.18e-6 + 2.5

## TMS serial io r/w
# @param[in] colAddr TMS array column address.
# @param[in] dout 130bit register val
def tms_sio_rw(s, cmd, colAddr, dout, clkDiv=7, dcfgBase=5, dstatBase=1, pulseRegId=3):
    # column address and clock div
    colAddrClkDivVal = colAddr << 8 | clkDiv << 2
    cmdStr = cmd.write_register(dcfgBase+8, colAddrClkDivVal)
    s.sendall(cmdStr)
    # drive dout
    cmdStr = ""
    for i in xrange(8):
        cmdStr += cmd.write_register(dcfgBase+i, (dout >> i*16) & 0xffff)
    i = 8
    cmdStr += cmd.write_register(dcfgBase+i, (dout >> i*16) & 0xffff | colAddrClkDivVal)
    cmdStr += cmd.send_pulse(1<<pulseRegId)
    s.sendall(cmdStr)
#    print(":".join("{:02x}".format(ord(c)) for c in cmdStr))
    # readback
    time.sleep(0.1)
    cmdStr = ""
    for i in xrange(9):
        cmdStr += cmd.read_status(8-i + dstatBase)
    s.sendall(cmdStr)
    retw = s.recv(4*9, socket.MSG_WAITALL)
    ret = 0
    for i in xrange(9):
        ret = ret | ( int(ord(retw[i*4+2])) << ((8-i) * 16 + 8) |
                      int(ord(retw[i*4+3])) << ((8-i) * 16))
    ret = ret & 0x3ffffffffffffffffffffffffffffffff
    return ret

if __name__ == "__main__":

    parser = argparse.ArgumentParser(formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument("-c", "--control-ip-port", type=str, default="192.168.2.3:1025", help="main control system ipaddr and port")
    args = parser.parse_args()

    ctrlipport = args.control_ip_port.split(':')
    s = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
    s.connect((ctrlipport[0],int(ctrlipport[1])))
#
    cmd = Cmd()
#
    dac8568 = DAC8568(cmd)
    s.sendall(dac8568.turn_on_2V5_ref())
    s.sendall(dac8568.set_voltage(0, 1.207))
    s.sendall(dac8568.set_voltage(1, 1.024))
    s.sendall(dac8568.set_voltage(2, 1.65))
    time.sleep(0.001)
#
    ltc2990a = LTC2990(cmd, 0x4c) # current monitor
    ltc2990a.set_vdiff_measurement(s)
    # print(ltc2990a.read_all_registers(s))
    print("Temperature of   U26: {:6.3f}C".format(ltc2990a.get_temperature(s)))
    print("Vcc (FVIN3V3) on U26: {:6.3f}V".format(ltc2990a.get_vcc(s)))
    print("Voltage across 56mOhm shunt resistors: {:}".format(ltc2990a.get_vdiffs(s)))
#
    ltc2990b = LTC2990(cmd, 0x4d) # temperature monitor
    ltc2990b.set_temperature_measurement(s)
    # print(ltc2990b.read_all_registers(s))
    print("Temperature of U29: {:6.3f}C".format(ltc2990b.get_temperature(s)))
    print("Temperature of Q1 : {:6.3f}C".format(ltc2990b.get_temperature(s, 6)))
    print("Temperature on J6 : {:6.3f}C".format(ltc2990b.get_temperature(s, 10)))
#
    x2gain = 2
    bufferTest = False
    sdmTest = False

    tms1mmReg = TMS1mmReg()

    if bufferTest:
        tms1mmReg.set_k(0, 0) # 0 - K1 is open, disconnect CSA output
        tms1mmReg.set_k(1, 1) # 1 - K2 is closed, allow BufferX2_testIN to inject signal
        tms1mmReg.set_k(4, 0) # 0 - K5 is open, disconnect SDM loads
        tms1mmReg.set_k(6, 1) # 1 - K7 is closed, BufferX2 output to AOUT_BufferX2
    if x2gain == 2:
        tms1mmReg.set_k(2, 1) # 1 - K3 is closed, K4 is open, setting gain to X2
        tms1mmReg.set_k(3, 0)
    else:
        tms1mmReg.set_k(2, 0)
        tms1mmReg.set_k(3, 1)
    if sdmTest:
        tms1mmReg.set_k(4, 0)
        tms1mmReg.set_k(5, 1)
    else:
        tms1mmReg.set_k(5, 0)

    tms1mmReg.set_k(6, 0) # 1 - K7 BufferX2 output to AOUT_BufferX2
    tms1mmReg.set_k(7, 1) # 1 - K8 CSA out to AOUT1_CSA
    tms1mmReg.set_k(8, 0) # 1 - K9 CSA out to AOUT2_CSA that drives 50Ohm

    tms1mmReg.set_power_down(0, 0)
    tms1mmReg.set_power_down(1, 1) # AOUT2_CSA PD
    tms1mmReg.set_power_down(2, 1)
    tms1mmReg.set_power_down(3, 1)

    tms1mmReg.set_dac(0, tms1mmReg.dac_volt2code(1.379)) # VBIASN R45
    tms1mmReg.set_dac(1, tms1mmReg.dac_volt2code(1.546)) # VBIASP R47
    tms1mmReg.set_dac(2, tms1mmReg.dac_volt2code(1.626)) # VCASN  R29
    tms1mmReg.set_dac(3, tms1mmReg.dac_volt2code(1.169)) # VCASP  R27
    tms1mmReg.set_dac(4, tms1mmReg.dac_volt2code(1.357)) # VDIS   R16
    tms1mmReg.set_dac(5, tms1mmReg.dac_volt2code(2.458)) # VREF   R14

    tmsRegCode = tms1mmReg.get_config_vector()
    print("TMS1mm Serial Reg Code : 0x%0x" % (tmsRegCode))
#
    tms_pwr_on          = 1
    tms_sdm_clk_src_sel = 0 # 0: FPGA, 1: external
    tms_sdm_clkff_div   = 0 #2 # /2**x, 0 disables clock
    adc_clk_src_sel     = 0
    adc_clkff_div       = 0
    adc_sdrn_ddr        = 0 # 0: sdr, 1: ddr
    cmdStr  = cmd.write_register(0, adc_clkff_div       <<12 |
                                    tms_sdm_clkff_div   << 8 |
                                    adc_sdrn_ddr        << 3 |
                                    adc_clk_src_sel     << 2 |
                                    tms_sdm_clk_src_sel << 1 |
                                    tms_pwr_on)
    s.sendall(cmdStr)
    time.sleep(0.001)
# tms serial io
    tmsChainLengths = [3, 4, 5, 4, 3]
    for i in xrange(len(tmsChainLengths)):
        for j in xrange(tmsChainLengths[i]+1):
            tms_sio_rw(s, cmd, i, tmsRegCode)
# tms reset and load register
    cmdStr = cmd.send_pulse(1<<0)
    s.sendall(cmdStr)
# tms sdm idelay
    cmdStr  = cmd.write_register(14, 38<<8 | 1) # clk loopback
    cmdStr += cmd.send_pulse(1<<4)
    cmdStr += cmd.write_register(14, 0<<8 | 0)
    cmdStr += cmd.send_pulse(1<<4)
    s.sendall(cmdStr)
# adc idelay
    cmdStr  = cmd.write_register(14, 20<<8 | 1) # clk loopback
    cmdStr += cmd.send_pulse(1<<5)
    cmdStr += cmd.write_register(14, 19<<8 | 0)
    cmdStr += cmd.send_pulse(1<<5)
    s.sendall(cmdStr)
#
    s.close()
