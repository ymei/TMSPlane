/*
 * Copyright (c) 2017
 *
 *     Yuan Mei
 *
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 * notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 * notice, this list of conditions and the following disclaimer in the
 * documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <time.h>

#include "common.h"
#include "sigproc.h"

int sigproc_demux_fifodata(const char *fData, size_t bytesPerSample, size_t nSamples, size_t adcSdmCycRatio,
                           float *adcData, size_t nAdcCh, char *sdmData, size_t nSdmCh, double adcVoffset, double adcLSB)
{
    int v;
    ssize_t i, j, idx0, b0, bi, bs, ch, ss;
    for(i=0; i<nSamples; i++) {
        for(j=0; j<nAdcCh; j++) {
            idx0 = bytesPerSample - 1 - j*2;
            v = ((unsigned char)(fData[i * bytesPerSample + idx0 - 1]) << 8
                 |(unsigned char)(fData[i * bytesPerSample + idx0]));
            /* convert to signed int */
            v = (v ^ 0x8000) - 0x8000;
            /* convert to actual volts */
            adcData[j*nSamples + i] = v * adcLSB + adcVoffset;
        }
        b0 = nAdcCh*2;
        for(j=0; j<adcSdmCycRatio*nSdmCh*2; j++) {
            bi = bytesPerSample - 1 - b0 - (ssize_t)(j / 8);
            bs = j % 8;
            ss = (ssize_t)(j / (nSdmCh*2));
            ch = j % (nSdmCh*2);
            sdmData[ch*nSamples*adcSdmCycRatio + i*adcSdmCycRatio + ss] = ((unsigned char)(fData[i * bytesPerSample + bi]) >> bs) & 0x1;
        }
    }
    return 0;
}

int sigproc_save_data(size_t nSamples, time_t timeStamp, size_t adcSdmCycRatio,
                      const char *adcFName, const float *adcData, size_t nAdcCh,
                      const char *sdmFName, const char *sdmData, size_t nSdmCh)
{
    FILE *fpa, *fps;
    ssize_t i, j;

    if((fpa=fopen(adcFName, "w"))==NULL) {
        perror(adcFName);
        return -1;
    }
    if((fps=fopen(sdmFName, "w"))==NULL) {
        perror(sdmFName);
        return -1;
    }
    fprintf(fpa, "# TimeStamp: 0x%016lx 5Msps ADC\n", timeStamp);
    for(i=0; i<nSamples; i++) {
        for(j=0; j<nAdcCh; j++) {
            fprintf(fpa, " %9.6f", adcData[j*nSamples + i]);
        }
        fprintf(fpa, "\n");
    }
    fprintf(fps, "# TimeStamp: 0x%016lx 25Msps SDM\n", timeStamp);
    for(i=0; i<nSamples*adcSdmCycRatio; i++) {
        for(j=0; j<nSdmCh; j++) {
            fprintf(fps, " %1d", sdmData[j*nSamples*adcSdmCycRatio + i]);
        }
        fprintf(fps, "\n");
    }

    fclose(fpa);
    fclose(fps);
    return 0;
}
