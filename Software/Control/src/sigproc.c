/*
 * Copyright (c) 2017 -- 2018
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
#include <float.h>
#include <math.h>

#include "common.h"
#include "sigproc.h"

int sigproc_demux_fifodata(const char *fData, size_t bytesPerSample, size_t nSamples, size_t adcSdmCycRatio,
                           ANALYSIS_WAVEFORM_BASE_TYPE *adcData, size_t nAdcCh, char *sdmData, size_t nSdmCh, double adcVoffset, double adcLSB)
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
                      const char *adcFName, const ANALYSIS_WAVEFORM_BASE_TYPE *adcData, size_t nAdcCh,
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

int filters_trapezoidal(size_t wavLen, const ANALYSIS_WAVEFORM_BASE_TYPE *inWav, ANALYSIS_WAVEFORM_BASE_TYPE *outWav,
                        size_t k, size_t l, double M)
{
    double s, pp;
    ssize_t i, j, jk, jl, jkl;
    double vj, vjk, vjl, vjkl, dkl;

    s = 0.0; pp = 0.0;

    for(i=0; i<wavLen; i++) {
        j=i; jk = j-k; jl = j-l; jkl = j-k-l;
        vj   = j>=0   ? inWav[j]   : inWav[0];
        vjk  = jk>=0  ? inWav[jk]  : inWav[0];
        vjl  = jl>=0  ? inWav[jl]  : inWav[0];
        vjkl = jkl>=0 ? inWav[jkl] : inWav[0];

        dkl = vj - vjk - vjl + vjkl;
        pp = pp + dkl;
        if(M>=0.0) {
            s = s + pp + dkl * M;
        }
        else { /* infinite decay time, so the input is a step function */
            s = s + dkl;
        }
        outWav[i] = s / (fabs(M) * (double)k);
    }
    return 0;
}

int sigproc_measure_pulse(size_t nSamples, const ANALYSIS_WAVEFORM_BASE_TYPE *adcData, size_t nAdcCh,
                          size_t nFltParam, const double *fltParam,
                          size_t nMeasParam, double *measParam)
{
    size_t nBl;
    ssize_t iCh, i, j;
    const ANALYSIS_WAVEFORM_BASE_TYPE *adcChData;
    ANALYSIS_WAVEFORM_BASE_TYPE *scrAry; /* scratch array space */
    double *measChParam, v, bl, bln;

    FILE *fpa;
    if((fpa=fopen("flt.dat", "w"))==NULL) {
        perror("flt.dat");
        return -1;
    }

    nBl = (size_t)fltParam[0];
    scrAry = (ANALYSIS_WAVEFORM_BASE_TYPE*)calloc(nSamples, sizeof(ANALYSIS_WAVEFORM_BASE_TYPE));
    for(iCh=0; iCh<nAdcCh; iCh++) {
        adcChData = adcData + nSamples * iCh;
        measChParam = measParam + nMeasParam * iCh;
        /* baseline and baseline noise */
        bl = 0.0; bln = 0.0;
        for(i=0; i<nBl; i++) {
            bl += adcChData[i];
            bln += adcChData[i] * adcChData[i];
        }
        bl /= (double)nBl;
        bln = sqrt((bln - (double)nBl * bl*bl)/(nBl - 1.0));
        measChParam[0] = bl;
        measChParam[1] = bln;
        /* peak location and height */
        filters_trapezoidal(nSamples, adcChData, scrAry, (size_t)fltParam[1], (size_t)fltParam[2], (double)fltParam[3]);
        v = -DBL_MAX; j = 0;
        for(i=0; i<nSamples; i++) {
            if(scrAry[i] > v) {
                v = scrAry[i];
                j = i;
            }
            fprintf(fpa, "%g\n", scrAry[i] + bl);
        }
        measChParam[2] = j;
        measChParam[3] = v;
        fprintf(fpa, "\n\n");
    }
    free(scrAry);

    fclose(fpa);
    return 0;
}
