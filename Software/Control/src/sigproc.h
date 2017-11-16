#ifndef __SIGPROC_H__
#define __SIGPROC_H__

int sigproc_demux_fifodata(const char *fData, size_t bytesPerSample, size_t nSamples, size_t adcSdmCycRatio,
                           float *adcData, size_t nAdcCh, char *sdmData, size_t nSdmCh, double adcVoffset, double adcLSB);
int sigproc_save_data(size_t nSamples, time_t timeStamp, size_t adcSdmCycRatio,
                      const char *adcFName, const float *adcData, size_t nAdcCh,
                      const char *sdmFName, const char *sdmData, size_t nSdmCh);

#endif /* __SIGPROC_H__ */
