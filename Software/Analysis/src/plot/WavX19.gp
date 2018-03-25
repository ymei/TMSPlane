fname="WavX19adc.dat"
set output "WavX19.eps"
set terminal postscript eps enhanced color solid size 6.5,6 "Helvetica" 12

unset xlabel
set xrange [500:1000]
set xtics 500,200

unset ylabel
set format y "%5.3f"
set ytics 0.005

set key samplen 0 font ",16"

set label 1 "t [{/Symbol m}s]" at screen 0.32,0.095 font ",18"
set label 2 "[V]" at screen 0.23,0.13 rotate by 90 font ",18"

cx=0.4
cy=0.4

set multiplot
set size 0.2,0.18

set origin cx+0,       cy+0
plot fname u ($0*0.2):1 w step t '0'
set origin cx+0,       cy+0.2
plot fname u ($0*0.2):2 w step t '1'
set origin cx-0.173205,cy+0.1
plot fname u ($0*0.2):3 w step t '2'
set origin cx-0.173205,cy-0.1
plot fname u ($0*0.2):4 w step t '3'
set origin cx+0,       cy-0.2
plot fname u ($0*0.2):5 w step t '4'
set origin cx+0.173205,cy-0.1
plot fname u ($0*0.2):6 w step t '5'
set origin cx+0.173205,cy+0.1
plot fname u ($0*0.2):7 w step t '6'
set origin cx-0,       cy+0.4
plot fname u ($0*0.2):8 w step t '7'
set origin cx-0.173205,cy+0.3
plot fname u ($0*0.2):9 w step t '8'
set origin cx-0.34641, cy+0.2
plot fname u ($0*0.2):10 w step t '9'
set origin cx-0.34641, cy+0
plot fname u ($0*0.2):11 w step t '10'
set origin cx-0.34641, cy-0.2
plot fname u ($0*0.2):12 w step t '11'
set origin cx-0.173205,cy-0.3
plot fname u ($0*0.2):13 w step t '12'
set origin cx-0,       cy-0.4
plot fname u ($0*0.2):14 w step t '13'
set origin cx+0.173205,cy-0.3
plot fname u ($0*0.2):15 w step t '14'
set origin cx+0.34641, cy-0.2
plot fname u ($0*0.2):16 w step t '15'
set origin cx+0.34641, cy-0
plot fname u ($0*0.2):17 w step t '16'
set origin cx+0.34641, cy+0.2
plot fname u ($0*0.2):18 w step t '17'
set origin cx+0.173205,cy+0.3
plot fname u ($0*0.2):19 w step t '18'

unset multiplot
unset output
