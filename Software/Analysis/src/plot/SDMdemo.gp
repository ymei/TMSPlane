fname = 'SDMdemo.dat'
set palette model RGB defined (0.0 1.0 1.0 1.0, 1/256. 1.0 1.0 1.0, 1/255. 0.0 0.0 0.51, 0.34 0.0 0.81 1.0, 0.61 0.87 1.0 0.12, 0.84 1.0 0.2 0.0, 1.0 0.51 0.0 0.0) positive

set output "1.eps"
set terminal postscript eps enhanced solid color "Helvetica" 14

set multiplot
#layout 3,1 margins screen 0.12,0.88,0.95,0.1 spacing screen 0.1

set lmargin at screen 0.1
set rmargin at screen 0.92
set bmargin at screen 0.86
set tmargin at screen 0.98

set xrange [128:(128+512)]
set xlabel ""
set format x ""
set yrange [-0.1:2.6]
set ylabel "SDM\nbit streams" offset -2,0
set ytics ("0" 0, "1" 1, "0" 1.5, "1" 2.5)

plot fname u 0:8 w step lt 3 t '', '' u 0:($9+1.5) w step lt 4 t ''
set ylabel offset 0,0

set bmargin at screen 0.60
set tmargin at screen 0.85

unset log x
set xrange [128:(128+512)]
set format x "%h"
set xlabel "Sample index, 40ns/sample"
unset log y
set yrange [-32:32]
unset ytics
set ytics
set ytics nomirror
set format y "%h"
set ylabel "Merged\ndigital amplitude"
set link y via y/40. inverse y*40.
set y2tics 0.2 right offset 3,0 tc lt 2
set format y2 "%.1f"
set y2label 'Analog amplitude [V]' tc lt 2 offset -1,0

plot fname u 0:2 w step t '', '' u 0:3 w step axes x1y2 lw 4 t ''

set bmargin at screen 0.1
set tmargin at screen 0.5

set key left
set xrange [3e4:12.5e6]
set log x
set format x "%.1s%c"
set xlabel 'Frequency [Hz]'
set yrange [1e-8:0.03]
set log y
set ytics mirror
set format y "10^{%L}"
set ylabel 'Spectral density [V/{/Symbol \326}Hz]'
unset y2tics
unset y2label

set label 1 "Butterworth low-pass filter,\n10th order, f_{-3dB}=1MHz" at first 36e3,5e-4
set label 2 "Bin size: 293.4Hz" at first 3.5e6,5.0e-8
plot fname u 4:5 w step t 'SDM output', '' u 4:7 w step t 'Filtered'

unset multiplot
unset output
set term x11
