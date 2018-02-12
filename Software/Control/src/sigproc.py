from __future__ import print_function
from __future__ import division
import time
from ctypes import *

class SigProc(object):
    soname = "./build/sigproc.so"
    ANALYSIS_WAVEFORM_BASE_TYPE = c_float

    def __init__(self, nSamples, nAdcCh, nSdmCh, adcSdmCycRatio):
        self.sigprocSO = cdll.LoadLibrary(self.soname)
        self.nSamples = nSamples
        self.nAdcCh = nAdcCh
        self.nSdmCh = nSdmCh
        self.adcSdmCycRatio = adcSdmCycRatio
        self.nParamMax = 10
        self.fltParam  =  (c_double * self.nParamMax)()
        self.measParam = ((c_double * self.nParamMax) * self.nAdcCh)()

    def generate_adcDataBuf(self):
        return ((self.ANALYSIS_WAVEFORM_BASE_TYPE * self.nSamples) * self.nAdcCh)()

    def generate_sdmDataBuf(self):
        return ((c_byte * (self.nSamples*self.adcSdmCycRatio)) * (self.nSdmCh*2))()

    def demux_fifodata(self, fData, adcData, sdmData, adcVoffset=1.024, adcLSB=62.5e-6):
        wWidth = 512
        bytesPerSample = wWidth // 8
        if type(fData[0]) == str:
            fD = bytearray(fData)
        else:
            fD = fData
        if len(fD) % bytesPerSample != 0:
            return None
        nSamples = len(fD) // bytesPerSample
        fD = create_string_buffer(bytes(fD), len(fD))
        cfun = self.sigprocSO.sigproc_demux_fifodata
        ret = cfun(byref(fD), c_size_t(bytesPerSample), c_size_t(nSamples), c_size_t(self.adcSdmCycRatio),
                   byref(adcData), c_size_t(self.nAdcCh), byref(sdmData), c_size_t(self.nSdmCh), c_double(adcVoffset), c_double(adcLSB))
        return adcData

    def save_data(self, fNames, adcData, sdmData):
        timeStamp = int(time.time())
        nSamples = len(adcData[0])
        adcSdmCycRatio = len(sdmData[0]) // nSamples
        nAdcCh = len(adcData)
        nSdmCh = len(sdmData)
        cfun = self.sigprocSO.sigproc_save_data
        ret = cfun(c_size_t(nSamples), c_long(timeStamp), c_size_t(adcSdmCycRatio),
                   c_char_p(fNames[0].encode("ascii")), byref(adcData), c_size_t(nAdcCh),
                   c_char_p(fNames[1].encode("ascii")), byref(sdmData), c_size_t(nSdmCh))

    def measure_pulse(self, adcData, fltParam=[500, 150, 200, -1.0]):
        nSamples = len(adcData[0])
        nAdcCh = len(adcData)
        nFltParam = len(self.fltParam)
        nMeasParam = len(self.measParam[0])
        for i in range(min(nFltParam, len(fltParam))):
            self.fltParam[i] = fltParam[i]
        cfun = self.sigprocSO.sigproc_measure_pulse
        ret = cfun(c_size_t(nSamples), byref(adcData), c_size_t(nAdcCh),
                   c_size_t(nFltParam), byref(self.fltParam),
                   c_size_t(nMeasParam), byref(self.measParam))
        # for l in self.measParam:
        #    print(list(l))
        return self.measParam
