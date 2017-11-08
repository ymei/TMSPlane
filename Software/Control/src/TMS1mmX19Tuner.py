#!/usr/bin/env python
# -*- coding: utf-8 -*-

## @package TMS1mmX19Tuner
# Human interface for tuning the Topmetal-S 1mm version chip x19 array
#

from __future__ import print_function
import math,sys,time,os,shutil
import copy
import socket
import argparse
from command import *
import TMS1mmX19Config

if sys.version_info[0] < 3:
    import Tkinter as tk
else:
    import tkinter as tk
import threading

import matplotlib
matplotlib.use('TkAgg')
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg, NavigationToolbar2TkAgg
from matplotlib.backend_bases import key_press_handler # for the default matplotlib key bindings
from matplotlib.figure import Figure
from matplotlib.ticker import FormatStrFormatter
from matplotlib import artist

class CommonData(object):

    def __init__(self, cmd, dataSocket=None, ctrlSocket=None, nSamples=16384, tms1mmReg=TMS1mmX19Config.TMS1mmReg()):

        self.cmd = cmd
        self.dataSocket = dataSocket
        self.ctrlSocket = ctrlSocket
        # number of chips
        self.nCh = 19
        self.nAdcCh = 20
        self.nSamples = nSamples
        self.nWords = 512/32 * self.nSamples
        # adc sampling interval in us
        self.adcDt = 0.2
        self.adcData = [[0 for i in xrange(self.nSamples)] for j in xrange(self.nAdcCh)]
        # size equals FPGA internal data fifo size
        self.sampleBuf = bytearray(4 * self.nWords)
        # number of voltages in a sensor to control
        self.nVolts = 6
        # update time interval (second)
        self.tI = 0.5
        #
        self.voltsNames = ['VBIASN', 'VBIASP', 'VCASN', 'VCASP', 'VDIS', 'VREF']
        self.cv = threading.Condition() # condition variable
        ########################################< cv protected <
        self.quit = False
        self.vUpdated = False
        #
        self.inputVs = [1.379, 1.546, 1.626, 1.169, 1.357, 2.458]
        self.inputVcodes = [tms1mmReg.dac_volt2code(v) for v in self.inputVs]
        # measured and returned values, not used but displayed
        self.voltsOutput = [0.0 for i in xrange(self.nVolts)]
        self.inputIs = [0.0 for i in xrange(self.nVolts)]
        #
        self.currentSensor = 0
        self.sensorVcodes = [[v for v in self.inputVcodes] for i in xrange(self.nCh)]
        ########################################> cv protected >
        self.tms1mmReg = tms1mmReg

class DataPanelGUI(object):

    ##
    # @param [in] dataFigSize (w, h) in inches for the data plots figure assuming dpi=72
    def __init__(self, master, cd, dataFigSize=(13, 12.5)):
        self.master = master
        self.cd = cd
        self.nCh = self.cd.nAdcCh

        self.master.wm_title("Topmetal-S 1mm version x19 array data")
        # appropriate quitting
        self.master.wm_protocol("WM_DELETE_WINDOW", self.quit)

        # frame for plotting
        self.dataPlotsFrame = tk.Frame(self.master)
        self.dataPlotsFrame.pack(side=tk.TOP, fill=tk.BOTH, expand=True)
        self.dataPlotsFrame.bind("<Configure>", self.on_resize)
        self.dataPlotsFigure = Figure(figsize=dataFigSize, dpi=72)
        self.dataPlotsFigure.subplots_adjust(left=0.1, right=0.98, top=0.98, bottom=0.05, hspace=0, wspace=0)
        # x-axis is shared
        dataPlotsSubplotN = self.dataPlotsFigure.add_subplot(self.nCh, 1, self.nCh, xlabel='t [us]', ylabel='[V]')
        self.dataPlotsSubplots = [self.dataPlotsFigure.add_subplot(self.nCh, 1, i+1, sharex=dataPlotsSubplotN)
                                  for i in xrange(self.nCh-1)]
        for a in self.dataPlotsSubplots:
            artist.setp(a.get_xticklabels(), visible=False)
        self.dataPlotsSubplots.append(dataPlotsSubplotN)
        self.dataPlotsCanvas = FigureCanvasTkAgg(self.dataPlotsFigure, master=self.dataPlotsFrame)
        self.dataPlotsCanvas.show()
        self.dataPlotsCanvas.get_tk_widget().pack(side=tk.TOP, fill=tk.BOTH, expand=True)
        self.dataPlotsToolbar = NavigationToolbar2TkAgg(self.dataPlotsCanvas, self.dataPlotsFrame)
        self.dataPlotsToolbar.update()
        self.dataPlotsCanvas._tkcanvas.pack(side=tk.TOP, fill=tk.BOTH, expand=True)
        self.dataPlotsCanvas.mpl_connect('key_press_event', self.on_key_event)
        #
        button = tk.Button(master=self.master, text='Re-sample', command=self.get_and_plot_data)
        button.pack(side=tk.BOTTOM, fill=tk.X)
        #
        self.plot_data()

    def on_key_event(self, event):
        print('You pressed {:s}'.format(event.key))
        key_press_handler(event, self.dataPlotsCanvas, self.dataPlotsToolbar)

    def on_resize(self, event):
        # print(event.width, event.height)
        return

    def quit(self):
        with self.cd.cv:
            self.cd.quit = True
            self.cd.cv.notify()
        self.master.quit()     # stops mainloop
        self.master.destroy()  # this is necessary on Windows to prevent
                               # Fatal Python Error: PyEval_RestoreThread: NULL tstate

    def get_and_plot_data(self):
        # reset data fifo
        self.cd.dataSocket.sendall(self.cd.cmd.send_pulse(1<<2));
        time.sleep(0.1)
        buf = self.cd.cmd.acquire_from_datafifo(self.cd.dataSocket, self.cd.nWords, self.cd.sampleBuf)
        self.demux_fifodata(buf, self.cd.adcData)
        self.plot_data()

    def plot_data(self):
        # self.dataPlotsFigure.clf(keep_observers=True)
        for a in self.dataPlotsSubplots:
            a.cla()
        for i in xrange(len(self.dataPlotsSubplots)-1):
            a = self.dataPlotsSubplots[i]
            artist.setp(a.get_xticklabels(), visible=False)
            a.set_ylabel("#{:d}".format(i), rotation=0)
        a = self.dataPlotsSubplots[-1]
        a.set_xlabel(u't [us]')
        a.set_ylabel('[V]')
        nSamples = len(self.cd.adcData[0])
        x = [self.cd.adcDt * i for i in xrange(nSamples)]
        for i in xrange(len(self.dataPlotsSubplots)):
            a = self.dataPlotsSubplots[i]
            a.locator_params(axis='y', tight=True, nbins=4)
            a.yaxis.set_major_formatter(FormatStrFormatter('%7.4f'))
            a.set_xlim([0.0, self.cd.adcDt * nSamples])
            a.step(x, self.cd.adcData[i], where='post')
        self.dataPlotsCanvas.show()
        self.dataPlotsToolbar.update()
        return

    def demux_fifodata(self, fData, ary=None, adcVoffset=1.024, adcLSB=62.5e-6):
        wWidth = 512
        bytesPerSample = wWidth / 8
        nADCs = self.nCh
        if type(fData[0]) == str:
            fD = bytearray(fData)
        else:
            fD = fData
        if len(fD) % bytesPerSample != 0:
            return []
        nSamples = len(fD) / bytesPerSample
        if ary == None:
            ary = [[0 for i in xrange(nSamples)] for j in xrange(nADCs)]
        for i in xrange(nSamples):
            for j in xrange(nADCs):
                idx0 = bytesPerSample - 1 - j*2
                v = ( fD[i * bytesPerSample + idx0 - 1] << 8
                    | fD[i * bytesPerSample + idx0])
                # convert to signed int
                v = (v ^ 0x8000) - 0x8000
                # convert to actual volts
                ary[j][i] = v * adcLSB + adcVoffset

        return ary

class ControlPanelGUI(object):

    def __init__(self, master, cd):
        self.master = master
        self.cd = cd
        self.nVolts = self.cd.nVolts
        self.nCh = self.cd.nCh

        # appropriate quitting
        master.wm_protocol("WM_DELETE_WINDOW", self.quit)

        # frame for selecting a sensor to operate on
        self.sensorsFrame = tk.Frame(master)
        self.sensorsFrame.pack(side=tk.TOP)
        # sensor location approximated on a grid (row, col)
        self.sensorLocOnGrid = {0 : [4,2], 1 : [2,2], 2 : [3,1], 3 : [5,1],  4 : [6,2],  5 : [5,3],
                                6 : [3,3], 7 : [0,2], 8 : [1,1], 9 : [2,0], 10 : [4,0], 11 : [6,0],
                                12 : [7,1], 13 : [8,2], 14: [7,3], 15 : [6,4], 16 : [4,4],
                                17 : [2,4], 18 : [1,3]}
        self.sensorSelVar = tk.IntVar()
        self.sensorSelRadioButtons = [tk.Radiobutton(self.sensorsFrame, text="{:d}".format(i),
                                                     variable=self.sensorSelVar, value=i,
                                                     command=self.select_current_sensor)
                                      for i in xrange(self.nCh)]
        for i in xrange(len(self.sensorSelRadioButtons)):
            b = self.sensorSelRadioButtons[i]
            b.grid(row=self.sensorLocOnGrid[i][0], column=self.sensorLocOnGrid[i][1])

        # frame for controls
        self.voltagesFrame = tk.Frame(master)
        self.voltagesFrame.pack(side=tk.BOTTOM)

        # GUI widgets
        self.voltsNameLabels =  [tk.Label(self.voltagesFrame, text=self.cd.voltsNames[i])
                             for i in xrange(self.nVolts)]
        self.voltsILabels = [tk.Label(self.voltagesFrame, font="Courier 10", text="0.0 A")
                             for i in xrange(self.nVolts)]

        self.voltsOutputLabels = [tk.Label(self.voltagesFrame, font="Courier 10", text="0.0 V")
                                  for i in xrange(self.nVolts)]

        self.voltsSetVars = [tk.DoubleVar() for i in xrange(self.nVolts)]
        for i in xrange(self.nVolts):
            self.voltsSetVars[i].set(self.cd.inputVs[i])
        self.voltsSetEntries = [tk.Spinbox(self.voltagesFrame, width=8, justify=tk.RIGHT,
                                           textvariable=self.voltsSetVars[i],
                                           from_=0.0, to=3.3, increment=0.001,
                                           format_="%6.4f",
                                           command=self.set_voltage_update)
                                for i in xrange(self.nVolts)]
        for v in self.voltsSetEntries:
            v.bind('<Return>', self.set_voltage_update)

        self.voltsSetCodeVars = [tk.IntVar() for i in xrange(self.nVolts)]
        for i in xrange(self.nVolts):
            self.voltsSetCodeVars[i].set(self.cd.inputVcodes[i])
        self.voltsSetCodeEntries = [tk.Spinbox(self.voltagesFrame, width=8, justify=tk.RIGHT,
                                               textvariable=self.voltsSetCodeVars[i],
                                               from_=0, to=65535, increment=1,
                                               command=self.set_voltage_dac_code_update)
                                    for i in xrange(self.nVolts)]
        for v in self.voltsSetCodeEntries:
            v.bind('<Return>', self.set_voltage_dac_code_update)

        # caption
        tk.Label(self.voltagesFrame, text="Name", width=15,
                 fg="white", bg="black").grid(row=0, column=0, sticky=tk.W+tk.E)
        tk.Label(self.voltagesFrame, text="Set Voltage [V]", width=20,
                 fg="white", bg="black").grid(row=0, column=1, sticky=tk.W+tk.E)
        tk.Label(self.voltagesFrame, text="Set Volt DAC code", width=20,
                 fg="white", bg="black").grid(row=0, column=2, sticky=tk.W+tk.E)
        tk.Label(self.voltagesFrame, text="Measured Voltage [V]",
                 fg="white", bg="black").grid(row=0, column=3, sticky=tk.W+tk.E)

        # placing widgets
        for i in xrange(self.nVolts):
            self.voltsNameLabels[i].grid(row=i+1,column=0)
            self.voltsSetEntries[i].grid(row=i+1, column=1)
            self.voltsSetCodeEntries[i].grid(row=i+1, column=2)
            self.voltsOutputLabels[i].grid(row=i+1, column=3)

        # self-updating functions
        self.update_values_display()

    def quit(self):
        with self.cd.cv:
            self.cd.quit = True
            self.cd.cv.notify()
        self.master.destroy()

    def update_values_display(self):
        for i in xrange(self.nVolts):
            self.voltsILabels[i].configure(text="{:7.3f}".format(self.cd.inputIs[i]))
            self.voltsOutputLabels[i].configure(text="{:7.3f}".format(self.cd.voltsOutput[i]))
        self.master.after(int(1000*self.cd.tI), self.update_values_display)

    def select_current_sensor(self, *args):
        with self.cd.cv:
            self.cd.currentSensor = self.sensorSelVar.get()
            # load Vcodes for the specific sensor
            for i in xrange(self.nVolts):
                self.voltsSetCodeVars[i].set(self.cd.sensorVcodes[self.cd.currentSensor][i])
        self.set_voltage_dac_code_update()

    def set_voltage_update(self, *args):
        with self.cd.cv:
            for i in xrange(self.nVolts):
                self.cd.inputVs[i] = self.voltsSetVars[i].get()
                self.cd.inputVcodes[i] = self.cd.tms1mmReg.dac_volt2code(self.cd.inputVs[i])
                self.voltsSetCodeVars[i].set(self.cd.inputVcodes[i])
                # update info for the array
                self.cd.sensorVcodes[self.cd.currentSensor][i] = self.cd.inputVcodes[i]
            self.cd.vUpdated = True
            print(self.cd.inputVs)
            print(self.cd.inputVcodes)
        return True

    def set_voltage_dac_code_update(self, *args):
        with self.cd.cv:
            for i in xrange(self.nVolts):
                self.cd.inputVcodes[i] = self.voltsSetCodeVars[i].get()
                self.cd.inputVs[i] = self.cd.tms1mmReg.dac_code2volt(self.cd.inputVcodes[i])
                self.voltsSetVars[i].set(round(self.cd.inputVs[i],4))
                # update info for the array
                self.cd.sensorVcodes[self.cd.currentSensor][i] = self.cd.inputVcodes[i]
            self.cd.vUpdated = True
            print(self.cd.inputVcodes)
        return True

class SensorConfig(threading.Thread):
    # Do not try to access tk.IntVar etc. here.  Since after
    # master.destroy(), those variables associated with tk seem to be
    # destroyed as well and accessing them would result in this thread
    # to hang.

    def __init__(self, cd):
        threading.Thread.__init__(self)
        self.cd = cd
        self.s = self.cd.ctrlSocket
        self.dac8568 = TMS1mmX19Config.DAC8568(self.cd.cmd)
        self.tms1mmReg = cd.tms1mmReg
        self.tms1mmX19sensorInChain = {0 : 2, 1 : 2, 2 : 1, 3 : 1, 4 : 2, 5 : 3, 6 : 3, 7 : 2,
                                       8 : 1, 9 : 0, 10 : 0, 11 : 0, 12 : 1, 13 : 2, 14 : 3,
                                       15 : 4, 16 : 4, 17 : 4, 18 : 3}
        self.tms1mmX19chainSensors = {0 : [9, 10, 11],
                                      1 : [8, 2, 3, 12],
                                      2 : [7, 1, 0, 4, 13],
                                      3 : [18, 6, 5, 14],
                                      4 : [17, 16, 15]}
        #
        self.set_global_defaults()

    def run(self):
        with self.cd.cv:
            while not self.cd.quit:
                self.cd.cv.wait(self.cd.tI)
                if self.cd.vUpdated:
                    self.update_sensor(self.cd.currentSensor)
                    self.cd.vUpdated = False
                self.get_inputs()

    def set_global_defaults(self):
        tms_pwr_on          = 1
        tms_sdm_clk_src_sel = 0 # 0: FPGA, 1: external
        tms_sdm_clkff_div   = 0 #2 # /2**x, 0 disables clock
        adc_clk_src_sel     = 0
        adc_clkff_div       = 0
        adc_sdrn_ddr        = 0 # 0: sdr, 1: ddr
        cmdStr  = self.cd.cmd.write_register(0, adc_clkff_div       <<12 |
                                                tms_sdm_clkff_div   << 8 |
                                                adc_sdrn_ddr        << 3 |
                                                adc_clk_src_sel     << 2 |
                                                tms_sdm_clk_src_sel << 1 |
                                                tms_pwr_on)
        self.s.sendall(cmdStr)
        time.sleep(0.001)
        # tms sdm idelay
        cmdStr  = self.cd.cmd.write_register(14, 38<<8 | 1) # clk loopback
        cmdStr += self.cd.cmd.send_pulse(1<<4)
        cmdStr += self.cd.cmd.write_register(14, 0<<8 | 0)
        cmdStr += self.cd.cmd.send_pulse(1<<4)
        self.s.sendall(cmdStr)
        # adc idelay
        cmdStr  = self.cd.cmd.write_register(14, 20<<8 | 1) # clk loopback
        cmdStr += self.cd.cmd.send_pulse(1<<5)
        cmdStr += self.cd.cmd.write_register(14, 19<<8 | 0)
        cmdStr += self.cd.cmd.send_pulse(1<<5)
        self.s.sendall(cmdStr)
        # DAC provided ref voltages
        self.s.sendall(self.dac8568.turn_on_2V5_ref())
        self.s.sendall(self.dac8568.set_voltage(0, 1.207))
        self.s.sendall(self.dac8568.set_voltage(1, 1.024))
        self.s.sendall(self.dac8568.set_voltage(2, 1.65))
        time.sleep(0.001)
        for c,l in self.tms1mmX19chainSensors.iteritems():
            self.update_sensor(l[0])
        time.sleep(0.001)

    def get_config_vector_for_sensor(self, iSensor):
        x2gain = 2
        bufferTest = False
        sdmTest = False

        self.tms1mmReg.set_power_down(0, 0)
        self.tms1mmReg.set_power_down(1, 1) # AOUT2_CSA PD
        self.tms1mmReg.set_power_down(2, 1)
        self.tms1mmReg.set_power_down(3, 1)

        if bufferTest:
            self.tms1mmReg.set_k(0, 0) # 0 - K1 is open, disconnect CSA output
            self.tms1mmReg.set_k(1, 1) # 1 - K2 is closed, allow BufferX2_testIN to inject signal
            self.tms1mmReg.set_k(4, 0) # 0 - K5 is open, disconnect SDM loads
            self.tms1mmReg.set_k(6, 1) # 1 - K7 is closed, BufferX2 output to AOUT_BufferX2
        if x2gain == 2:
            self.tms1mmReg.set_k(2, 1) # 1 - K3 is closed, K4 is open, setting gain to X2
            self.tms1mmReg.set_k(3, 0)
        else:
            self.tms1mmReg.set_k(2, 0)
            self.tms1mmReg.set_k(3, 1)
        if sdmTest:
            self.tms1mmReg.set_k(4, 0)
            self.tms1mmReg.set_k(5, 1)
        else:
            self.tms1mmReg.set_k(5, 0)

        self.tms1mmReg.set_k(6, 0) # 1 - K7 BufferX2 output to AOUT_BufferX2
        self.tms1mmReg.set_k(7, 1) # 1 - K8 CSA out to AOUT1_CSA
        self.tms1mmReg.set_k(9, 0) # 1 - K10 CSA out to AOUT2_CSA that drives 50Ohm
        self.tms1mmReg.set_dac(0, self.cd.sensorVcodes[iSensor][0]) # VBIASN
        self.tms1mmReg.set_dac(1, self.cd.sensorVcodes[iSensor][1]) # VBIASP
        self.tms1mmReg.set_dac(2, self.cd.sensorVcodes[iSensor][2]) # VCASN
        self.tms1mmReg.set_dac(3, self.cd.sensorVcodes[iSensor][3]) # VCASP
        self.tms1mmReg.set_dac(4, self.cd.sensorVcodes[iSensor][4]) # VDIS
        self.tms1mmReg.set_dac(5, self.cd.sensorVcodes[iSensor][5]) # VREF
        #
        return self.tms1mmReg.get_config_vector()

    def update_sensor(self, iSensor):
        colAddr = self.tms1mmX19sensorInChain[iSensor]
        sensorsInChain = self.tms1mmX19chainSensors[colAddr]
        print("Updating chain {:d} with sensors {:}".format(colAddr, sensorsInChain))
        for i in sensorsInChain:
            data = self.get_config_vector_for_sensor(i)
            TMS1mmX19Config.tms_sio_rw(self.s, self.cd.cmd, colAddr, data)
        # tms reset and load register
        self.s.sendall(self.cd.cmd.send_pulse(1<<0))

    def get_inputs(self):
        return

if __name__ == "__main__":

    parser = argparse.ArgumentParser()
    parser.add_argument("-d", "--data-ip-port", type=str, default="192.168.2.3:1024", help="data source ipaddr and port")
    parser.add_argument("-c", "--control-ip-port", type=str, default="192.168.2.3:1025", help="control system ipaddr and port")
    args = parser.parse_args()

    dataIpPort = args.data_ip_port.split(':')
    sD = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
    sD.connect((dataIpPort[0],int(dataIpPort[1])))

    ctrlIpPort = args.control_ip_port.split(':')
    sC = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
    sC.connect((ctrlIpPort[0],int(ctrlIpPort[1])))

    cmd = Cmd()
    cd = CommonData(cmd, dataSocket=sD, ctrlSocket=sC)
    sensorConfig = SensorConfig(cd)

    root = tk.Tk()
    root.wm_title("Topmetal-S 1mm version x19 array Tuner")
    controlPanel = ControlPanelGUI(root, cd)

    dataPanelMaster = tk.Toplevel(root)
    dataPanel = DataPanelGUI(dataPanelMaster, cd)

    sensorConfig.start()
    root.mainloop()
    # If you put root.destroy() here, it will cause an error if
    # the window is closed with the window manager.

    sensorConfig.join()

    sC.close()
    sD.close()
