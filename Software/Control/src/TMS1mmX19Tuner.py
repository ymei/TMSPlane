#!/usr/bin/env python
# -*- coding: utf-8 -*-

## @package TMS1mmX19Tuner
# Human interface for tuning the Topmetal-S 1mm version chip x19 array
#

from __future__ import print_function
from __future__ import division
import math,sys,time,os,shutil
from datetime import datetime
import array,copy
import ctypes
import socket
import argparse
import json
from command import *
from sigproc import *
import TMS1mmX19Config
from PyDE import *

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

    def __init__(self, cmd=Cmd(), dataSocket=None, ctrlSocket=None, nSamples=16384,
                 tms1mmReg=TMS1mmX19Config.TMS1mmReg(), sigproc=None):

        self.cmd = cmd
        self.dataSocket = dataSocket
        self.ctrlSocket = ctrlSocket
        self.dataFName = ["adc.dat", "sdm.dat"]
        # number of chips
        self.nCh = 19
        self.nAdcCh = 20
        self.adcSdmCycRatio = 5
        self.nSamples = nSamples
        self.nWords = 512//32 * self.nSamples
        # signal processor
        if (not sigproc):
            self.sigproc = SigProc(self.nSamples, self.nAdcCh, self.nCh, self.adcSdmCycRatio)
        # adc sampling interval in us
        self.adcDt = 0.2
        self.adcData = self.sigproc.generate_adcDataBuf() # ((ctypes.c_float * self.nSamples) * self.nAdcCh)()
        self.sdmData = self.sigproc.generate_sdmDataBuf() # ((ctypes.c_byte * (self.nSamples*self.adcSdmCycRatio)) * (self.nCh*2))()
        # size equals FPGA internal data fifo size
        self.sampleBuf = bytearray(4 * self.nWords)
        # number of voltages in a sensor to control
        self.nVolts = 6
        # update time interval (second)
        self.tI = 0.5
        #
        self.x2gain = 2
        self.bufferTest = 0
        self.sdmMode = 0 # 0 : disabled, 1 : normal operation, 2 : test with signal injection
        self.aoutBuf = 0 # 0 : AOUT1, 1 : AOUT2, >1 : disable both
        #
        self.voltsNames = ['VBIASN', 'VBIASP', 'VCASN', 'VCASP', 'VDIS', 'VREF']
        # auto tune
        self.atCalled = 0
        #self.atBounds = [(1.3, 1.4), (1.5, 1.6), (1.45, 1.6), (1.1, 1.35), (1.1, 1.6), (2.4, 2.5)]
        self.atBounds = [(0.8, 2.0), (0.8, 2.0), (0.8, 2.0), (0.8, 2.0), (0.8, 2.0), (2.2, 2.8)]
        #self.atBounds = [(1.0, 1.8), (1.0, 1.8), (1.0, 1.8), (1.0, 1.8), (1.0, 1.8)]
        self.atTbounds = (3000, 3500) # time of pulse bounds
        self.atMeasNavg = 10 # number of measurements for average
        self.atMaxIters = 100
        self.atBestRet   = 0.0
        self.atBestVolts = [0.0 for i in range(len(self.voltsNames))]
        #
        self.cv = threading.Condition() # condition variable
        ########################################< cv protected <
        self.quit = False
        self.vUpdated = False
        #
        self.inputVs = [1.379, 1.546, 1.626, 1.169, 1.357, 2.458]
        self.inputVcodes = [tms1mmReg.dac_volt2code(v) for v in self.inputVs]
        # measured and returned values, not used but displayed
        self.voltsOutput = [0.0 for i in range(self.nVolts)]
        self.inputIs = [0.0 for i in range(self.nVolts)]
        #
        self.currentSensor = 0
        self.sensorVcodes = [[v for v in self.inputVcodes] for i in range(self.nCh)]
        ########################################> cv protected >
        self.tms1mmReg = tms1mmReg

class DataPanelGUI(object):

    ##
    # @param [in] dataFigSize (w, h) in inches for the data plots figure assuming dpi=72
    def __init__(self, master, cd, dataFigSize=(13, 12.5), visibleChannels=None):
        self.master = master
        self.cd = cd
        self.nAdcCh = self.cd.nAdcCh
        self.nSdmCh = self.cd.nCh
        self.adcSdmCycRatio = self.cd.adcSdmCycRatio

        self.master.wm_title("Topmetal-S 1mm version x19 array data")
        # appropriate quitting
        self.master.wm_protocol("WM_DELETE_WINDOW", self.quit)

        # frame for plotting
        self.dataPlotsFrame = tk.Frame(self.master)
        self.dataPlotsFrame.pack(side=tk.TOP, fill=tk.BOTH, expand=True)
        self.dataPlotsFrame.bind("<Configure>", self.on_resize)
        self.dataPlotsFigure = Figure(figsize=dataFigSize, dpi=72)
        self.dataPlotsFigure.subplots_adjust(left=0.1, right=0.98, top=0.98, bottom=0.05, hspace=0, wspace=0)
        if visibleChannels == None or len(visibleChannels) == 0:
            visibleChannels = [i for i in range(self.nAdcCh-1)]
        # x-axis is shared
        dataPlotsSubplotN = self.dataPlotsFigure.add_subplot(
            len(visibleChannels)+1, 1, len(visibleChannels)+1, xlabel='t [us]', ylabel='[V]')
        self.dataPlotsSubplots = {}
        for i in range(len(visibleChannels)):
            self.dataPlotsSubplots[visibleChannels[i]] = self.dataPlotsFigure.add_subplot(
                len(visibleChannels)+1, 1, i+1, sharex=dataPlotsSubplotN)
        for i,a in self.dataPlotsSubplots.items():
            artist.setp(a.get_xticklabels(), visible=False)
        self.dataPlotsSubplots[self.nAdcCh-1] = dataPlotsSubplotN
        self.dataPlotsCanvas = FigureCanvasTkAgg(self.dataPlotsFigure, master=self.dataPlotsFrame)
        self.dataPlotsCanvas.show()
        self.dataPlotsCanvas.get_tk_widget().pack(side=tk.TOP, fill=tk.BOTH, expand=True)
        self.dataPlotsToolbar = NavigationToolbar2TkAgg(self.dataPlotsCanvas, self.dataPlotsFrame)
        self.dataPlotsToolbar.update()
        self.dataPlotsCanvas._tkcanvas.pack(side=tk.TOP, fill=tk.BOTH, expand=True)
        self.dataPlotsCanvas.mpl_connect('key_press_event', self.on_key_event)
        #
        self.buttonFrame = tk.Frame(self.master)
        self.buttonFrame.pack(side=tk.BOTTOM, fill=tk.BOTH, expand=True)
        self.resampleButton = tk.Button(master=self.buttonFrame, text='Re-sample', command=self.get_and_plot_data)
        self.resampleButton.pack(side=tk.LEFT, fill=tk.X, expand=True)
        self.refreshButton = tk.Button(master=self.buttonFrame, text='Refresh', command=self.plot_data)
        self.refreshButton.pack(side=tk.RIGHT, fill=tk.X)
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
        self.cd.sigproc.demux_fifodata(buf, self.cd.adcData, self.cd.sdmData)
        # self.demux_fifodata(buf, self.cd.adcData, self.cd.sdmData)
        self.plot_data()
        # self.save_data(self.cd.dataFName)
        self.cd.sigproc.measure_pulse(self.cd.adcData)
        self.cd.sigproc.save_data(self.cd.dataFName, self.cd.adcData, self.cd.sdmData)

    def plot_data(self):
        # self.dataPlotsFigure.clf(keep_observers=True)
        for i,a in self.dataPlotsSubplots.items():
            a.cla()
        for i,a in self.dataPlotsSubplots.items():
            if i == self.nAdcCh-1:
                a.set_xlabel(u't [us]')
                a.set_ylabel('[V]')
                continue
            artist.setp(a.get_xticklabels(), visible=False)
            a.set_ylabel("#{:d}".format(i), rotation=0)
        nSamples = len(self.cd.adcData[0])
        x = [self.cd.adcDt * i for i in range(nSamples)]
        for i,a in self.dataPlotsSubplots.items():
            a.locator_params(axis='y', tight=True, nbins=4)
            a.yaxis.set_major_formatter(FormatStrFormatter('%7.4f'))
            a.set_xlim([0.0, self.cd.adcDt * nSamples])
            a.step(x, array.array('f', self.cd.adcData[i]), where='post')
        self.dataPlotsCanvas.show()
        self.dataPlotsToolbar.update()
        return

    def demux_fifodata(self, fData, adcData=None, sdmData=None, adcVoffset=1.024, adcLSB=62.5e-6):
        wWidth = 512
        bytesPerSample = wWidth // 8
        if type(fData[0]) == str:
            fD = bytearray(fData)
        else:
            fD = fData
        if len(fD) % bytesPerSample != 0:
            return []
        nSamples = len(fD) // bytesPerSample
        if adcData == None:
            adcData = ((ctypes.c_float * nSamples) * self.nAdcCh)()
        if sdmData == None:
            sdmData = ((ctypes.c_byte * (nSamples*self.adcSdmCycRatio)) * (self.nSdmCh*2))()
        for i in range(nSamples):
            for j in range(self.nAdcCh):
                idx0 = bytesPerSample - 1 - j*2
                v = ( fD[i * bytesPerSample + idx0 - 1] << 8
                    | fD[i * bytesPerSample + idx0])
                # convert to signed int
                v = (v ^ 0x8000) - 0x8000
                # convert to actual volts
                adcData[j][i] = v * adcLSB + adcVoffset
            b0 = self.nAdcCh*2
            for j in range(self.adcSdmCycRatio*self.nSdmCh*2):
                bi = bytesPerSample - 1 - b0 - int(j / 8)
                bs = j % 8
                ss = int(j / (self.nSdmCh*2))
                ch = j % (self.nSdmCh*2)
                sdmData[ch][i*self.adcSdmCycRatio + ss] = (fD[i * bytesPerSample + bi] >> bs) & 0x1
        #
        return adcData

    def save_data(self, fNames):
        timeStamp = int(time.time())
        with open(fNames[0], 'w') as fp:
            fp.write("# TimeStamp: 0x{:016x} 5Msps ADC\n".format(timeStamp))
            nSamples = len(self.cd.adcData[0])
            for i in range(nSamples):
                for j in range(len(self.cd.adcData)):
                    fp.write(" {:9.6f}".format(self.cd.adcData[j][i]))
                fp.write("\n")
        with open(fNames[1], 'w') as fp:
            fp.write("# TimeStamp: 0x{:016x} 25Msps SDM\n".format(timeStamp))
            nSamples = len(self.cd.sdmData[0])
            for i in range(nSamples):
                for j in range(len(self.cd.sdmData)):
                    fp.write(" {:1d}".format(self.cd.sdmData[j][i]))
                fp.write("\n")

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
                                      for i in range(self.nCh)]
        for i in range(len(self.sensorSelRadioButtons)):
            b = self.sensorSelRadioButtons[i]
            b.grid(row=self.sensorLocOnGrid[i][0], column=self.sensorLocOnGrid[i][1])

        # frame for controls
        self.voltagesFrame = tk.Frame(master)
        self.voltagesFrame.pack(side=tk.TOP)

        # GUI widgets
        self.voltsNameLabels =  [tk.Label(self.voltagesFrame, text=self.cd.voltsNames[i])
                             for i in range(self.nVolts)]
        self.voltsILabels = [tk.Label(self.voltagesFrame, font="Courier 10", text="0.0 A")
                             for i in range(self.nVolts)]

        self.voltsOutputLabels = [tk.Label(self.voltagesFrame, font="Courier 10", text="0.0 V")
                                  for i in range(self.nVolts)]

        # update to latest display values
        with self.cd.cv:
            for i in range(self.nVolts):
                self.cd.inputVcodes[i] = self.cd.sensorVcodes[self.cd.currentSensor][i]
                self.cd.inputVs[i] = self.cd.tms1mmReg.dac_code2volt(self.cd.inputVcodes[i])
        #
        self.voltsSetVars = [tk.DoubleVar() for i in range(self.nVolts)]
        for i in range(self.nVolts):
            self.voltsSetVars[i].set(self.cd.inputVs[i])
        self.voltsSetEntries = [tk.Spinbox(self.voltagesFrame, width=8, justify=tk.RIGHT,
                                           textvariable=self.voltsSetVars[i],
                                           from_=0.0, to=3.3, increment=0.001,
                                           format_="%6.4f",
                                           command=self.set_voltage_update)
                                for i in range(self.nVolts)]
        for v in self.voltsSetEntries:
            v.bind('<Return>', self.set_voltage_update)

        self.voltsSetCodeVars = [tk.IntVar() for i in range(self.nVolts)]
        for i in range(self.nVolts):
            self.voltsSetCodeVars[i].set(self.cd.inputVcodes[i])
        self.voltsSetCodeEntries = [tk.Spinbox(self.voltagesFrame, width=8, justify=tk.RIGHT,
                                               textvariable=self.voltsSetCodeVars[i],
                                               from_=0, to=65535, increment=1,
                                               command=self.set_voltage_dac_code_update)
                                    for i in range(self.nVolts)]
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
        for i in range(self.nVolts):
            self.voltsNameLabels[i].grid(row=i+1,column=0)
            self.voltsSetEntries[i].grid(row=i+1, column=1)
            self.voltsSetCodeEntries[i].grid(row=i+1, column=2)
            self.voltsOutputLabels[i].grid(row=i+1, column=3)

        # buttons
        self.buttonFrame = tk.Frame(self.master)
        self.buttonFrame.pack(side=tk.BOTTOM, fill=tk.BOTH, expand=True)
        self.autoTuneButton = tk.Button(master=self.buttonFrame, text='AutoTune', command=self.auto_tune)
        self.autoTuneButton.pack(side=tk.LEFT, fill=tk.X, expand=True)

        # self-updating functions
        self.update_values_display()

    def quit(self):
        with self.cd.cv:
            self.cd.quit = True
            self.cd.cv.notify()
        self.master.destroy()

    def update_values_display(self):
        for i in range(self.nVolts):
            self.voltsILabels[i].configure(text="{:7.3f}".format(self.cd.inputIs[i]))
            self.voltsOutputLabels[i].configure(text="{:7.3f}".format(self.cd.voltsOutput[i]))
        self.master.after(int(1000*self.cd.tI), self.update_values_display)

    def select_current_sensor(self, *args):
        with self.cd.cv:
            self.cd.currentSensor = self.sensorSelVar.get()
            # load Vcodes for the specific sensor
            for i in range(self.nVolts):
                self.voltsSetCodeVars[i].set(self.cd.sensorVcodes[self.cd.currentSensor][i])
        self.set_voltage_dac_code_update()

    def set_voltage_update(self, *args):
        with self.cd.cv:
            for i in range(self.nVolts):
                self.cd.inputVs[i] = self.voltsSetVars[i].get()
                self.cd.inputVcodes[i] = self.cd.tms1mmReg.dac_volt2code(self.cd.inputVs[i])
                self.voltsSetCodeVars[i].set(self.cd.inputVcodes[i])
                # update info for the array
                self.cd.sensorVcodes[self.cd.currentSensor][i] = self.cd.inputVcodes[i]
            self.cd.vUpdated = True
            print("Set volts: ", self.cd.inputVs)
            print("Set volt codes: ", self.cd.inputVcodes)
        return True

    def set_voltage_dac_code_update(self, *args):
        with self.cd.cv:
            for i in range(self.nVolts):
                self.cd.inputVcodes[i] = self.voltsSetCodeVars[i].get()
                self.cd.inputVs[i] = self.cd.tms1mmReg.dac_code2volt(self.cd.inputVcodes[i])
                self.voltsSetVars[i].set(round(self.cd.inputVs[i],4))
                # update info for the array
                self.cd.sensorVcodes[self.cd.currentSensor][i] = self.cd.inputVcodes[i]
            self.cd.vUpdated = True
            print(self.cd.inputVcodes)
        return True

    def auto_tune(self, *args):
        startTime = datetime.now()
        self.cd.atCalled = 0
        de = DE(self.auto_tune_fun, self.cd.atBounds, maxiters=self.cd.atMaxIters)
        ret = de.solve()
        print(ret)
        print("AutoTune: best ret: {:}".format(self.cd.atBestRet), self.cd.atBestVolts)
        for i in range(min(self.nVolts, len(self.cd.atBestVolts))):
            self.voltsSetVars[i].set(self.cd.atBestVolts[i])
        self.set_voltage_update()
        stopTime = datetime.now()
        runTime = stopTime - startTime
        print("AutoTune: run time: {:}, fun called: {:d}".format(str(runTime), self.cd.atCalled))
        self.auto_tune_fun(self.cd.atBestVolts)
        return ret

    def auto_tune_fun(self, x):
        print("AutoTune: called: {:d}".format(self.cd.atCalled))
        self.cd.atCalled += 1
        for i in range(min(self.nVolts, len(x))):
            self.voltsSetVars[i].set(x[i])
        self.set_voltage_update()
        time.sleep(2.0)
        meas = [[] for i in range(self.cd.sigproc.nParamMax)]
        for i in range(self.cd.atMeasNavg):
            # reset data fifo
            self.cd.dataSocket.sendall(self.cd.cmd.send_pulse(1<<2));
            time.sleep(0.05)
            buf = self.cd.cmd.acquire_from_datafifo(self.cd.dataSocket, self.cd.nWords, self.cd.sampleBuf)
            self.cd.sigproc.demux_fifodata(buf, self.cd.adcData, self.cd.sdmData)
            currMeasP = self.cd.sigproc.measure_pulse(self.cd.adcData)[self.cd.currentSensor]
            if currMeasP[2] < self.cd.atTbounds[0] or currMeasP[2] > self.cd.atTbounds[1] or currMeasP[3] < 0:
                return 0
            for j in range(len(currMeasP)):
                meas[j].append(currMeasP[j])
        currMeasP = [sum(x)/len(x) for x in meas]
        print("AutoTune: meas after {:d} avgs : {:}".format(self.cd.atMeasNavg, currMeasP))
        ret = -currMeasP[3]/currMeasP[1]
        print("AutoTune: ret : ", ret, currMeasP[1], currMeasP[3])
        if ret < self.cd.atBestRet:
            self.cd.atBestRet = ret
            for i in range(len(self.cd.atBestVolts)):
                self.cd.atBestVolts[i] = self.cd.inputVs[i]
        return ret

class SensorConfig(threading.Thread):
    # Do not try to access tk.IntVar etc. here.  Since after
    # master.destroy(), those variables associated with tk seem to be
    # destroyed as well and accessing them would result in this thread
    # to hang.

    def __init__(self, cd, configFName):
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
        self.configFName = configFName
        self.read_config_file()
        #
        self.set_global_defaults()

    def run(self):
        with self.cd.cv:
            while not self.cd.quit:
                self.cd.cv.wait(self.cd.tI)
                if self.cd.vUpdated:
                    self.update_sensor(self.cd.currentSensor)
                    self.write_config_file()
                    self.cd.vUpdated = False
                self.get_inputs()

    def set_global_defaults(self):
        tms_pwr_on          = 1
        tms_sdm_clk_src_sel = 0 # 0: FPGA, 1: external
        if self.cd.sdmMode:
            tms_sdm_clkff_div = 2 # /2**x, 0 disables clock
        else:
            tms_sdm_clkff_div = 0
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
        for c,l in self.tms1mmX19chainSensors.items():
            self.update_sensor(l[0])
        time.sleep(0.001)

    def get_config_vector_for_sensor(self, iSensor):

        if self.cd.bufferTest:
            self.tms1mmReg.set_k(0, 0) # 0 - K1 is open, disconnect CSA output
            self.tms1mmReg.set_k(1, 1) # 1 - K2 is closed, allow BufferX2_testIN to inject signal
            self.tms1mmReg.set_k(4, 0) # 0 - K5 is open, disconnect SDM loads
            self.tms1mmReg.set_k(6, 1) # 1 - K7 is closed, BufferX2 output to AOUT_BufferX2
            self.tms1mmReg.set_power_down(3, 0) # Power on AOUT_BufferX2
        else:
            self.tms1mmReg.set_k(0, 1) # 1 - K1 is closed, connect CSA output to buffer
            self.tms1mmReg.set_k(1, 0) # 0 - K2 is open,
            self.tms1mmReg.set_k(6, 0) # 0 - K7 is open
            self.tms1mmReg.set_power_down(3, 1) # Power down AOUT_BufferX2

        if self.cd.x2gain == 2:
            self.tms1mmReg.set_k(2, 1) # 1 - K3 is closed, K4 is open, setting gain to X2
            self.tms1mmReg.set_k(3, 0)
        else:
            self.tms1mmReg.set_k(2, 0)
            self.tms1mmReg.set_k(3, 1)

        if self.cd.sdmMode == 2:   # test mode
            self.tms1mmReg.set_k(4, 0)
            self.tms1mmReg.set_k(5, 1)
        elif self.cd.sdmMode == 1: # normal operation
            self.tms1mmReg.set_k(0, 1) # 1 - K1 is closed, connect CSA output to buffer
            self.tms1mmReg.set_k(4, 1)
            self.tms1mmReg.set_k(5, 0)
        else:                      # disabled
            self.tms1mmReg.set_k(4, 0)
            self.tms1mmReg.set_k(5, 0)

        if self.cd.aoutBuf == 0:
            self.tms1mmReg.set_power_down(0, 0) # AOUT1_CSA PD
            self.tms1mmReg.set_power_down(1, 1) # AOUT2_CSA PD
            self.tms1mmReg.set_k(7, 1)          # 1 - K8 CSA out to AOUT1_CSA
        elif self.cd.aoutBuf == 1:
            self.tms1mmReg.set_power_down(0, 1) # AOUT1_CSA PD
            self.tms1mmReg.set_power_down(1, 0) # AOUT2_CSA PD
            self.tms1mmReg.set_k(8, 1)          # 1 - K9 CSA out to AOUT2_CSA that drives 50Ohm
        self.tms1mmReg.set_power_down(2, 1)

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
            print("Send  : 0x{:0x}".format(data))
            ret = TMS1mmX19Config.tms_sio_rw(self.s, self.cd.cmd, colAddr, data)
            print("Return: 0x{:0x}".format(ret) + " equal = {:}".format(data == ret))
        # tms reset and load register
        self.s.sendall(self.cd.cmd.send_pulse(1<<0))

    def get_inputs(self):
        return

    def read_config_file(self, fName=None):
        if fName:
            self.configFName = fName
        if os.path.isfile(self.configFName):
            with open(self.configFName, 'r') as fp:
                config = json.load(fp)
                for i in range(len(config)):
                    for j in range(len(self.cd.voltsNames)):
                        self.cd.sensorVcodes[i][j] = config[repr(i)][self.cd.voltsNames[j]]
        else:
            return self.cd.sensorVcodes

    def write_config_file(self, fName=None):
        if fName:
            self.configFName = fName
        config = {}
        for i in range(self.cd.nCh):
            config[i] = dict(zip(self.cd.voltsNames, self.cd.sensorVcodes[i]))
        with open(self.configFName, 'w') as fp:
            fp.write(json.dumps(config, sort_keys=True, indent=4))

if __name__ == "__main__":

    parser = argparse.ArgumentParser(formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument("-a", "--aout-buf", type=int, default="1", help="AOUT buffer select, 0:AOUT1, 1:AOUT2, >1:disable both")
    parser.add_argument("-c", "--control-ip-port", type=str, default="192.168.2.3:1025", help="control system ipaddr and port")
    parser.add_argument("-d", "--data-ip-port", type=str, default="192.168.2.3:1024", help="data source ipaddr and port")
    parser.add_argument("-f", "--config-file", type=str, default="config.json", help="configuration file, will be overwritten")
    parser.add_argument("-g", "--bufferx2-gain", type=int, default="2", help="BufferX2 gain")
    parser.add_argument("-l", "--visible-channels", type=str, default="None", help="List of ADC channels to plot (made visible).  None or [] means all channels")
    parser.add_argument("-s", "--sdm-mode", type=int, default="0", help="SDM working mode, 0:disabled, 1:normal operation, 2:test with signal injection")
    parser.add_argument("-t", "--buffer-test", type=int, default="0", help="Buffer test")
    #
    args = parser.parse_args()

    dataIpPort = args.data_ip_port.split(':')
    sD = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
    sD.connect((dataIpPort[0],int(dataIpPort[1])))

    ctrlIpPort = args.control_ip_port.split(':')
    sC = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
    sC.connect((ctrlIpPort[0],int(ctrlIpPort[1])))

    cmd = Cmd()
    cd = CommonData(cmd, dataSocket=sD, ctrlSocket=sC)
    cd.aoutBuf = args.aout_buf
    cd.x2gain = args.bufferx2_gain
    cd.sdmMode = args.sdm_mode
    cd.bufferTest = args.buffer_test
    #
    sensorConfig = SensorConfig(cd, configFName=args.config_file)
    sensorConfig.start()
    #
    root = tk.Tk()
    root.wm_title("Topmetal-S 1mm version x19 array Tuner")
    controlPanel = ControlPanelGUI(root, cd)
    #
    dataPanelMaster = tk.Toplevel(root)
    dataPanel = DataPanelGUI(dataPanelMaster, cd, visibleChannels=eval(args.visible_channels))
    root.mainloop()
    # If you put root.destroy() here, it will cause an error if
    # the window is closed with the window manager.

    sensorConfig.join()

    sC.close()
    sD.close()
