EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
EELAYER 25 0
EELAYER END
$Descr USLedger 17000 11000
encoding utf-8
Sheet 1 1
Title "Topmetal-S sensor tiled plane, 10cm diameter version"
Date "2017-03-28"
Rev "0"
Comp "LBNL"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L LED D1
U 1 1 58DA1C98
P 8000 5000
F 0 "D1" H 8000 5100 50  0000 C CNN
F 1 "LED" H 8000 4900 50  0000 C CNN
F 2 "LEDs:LED_0603" H 8000 5000 50  0001 C CNN
F 3 "" H 8000 5000 50  0001 C CNN
	1    8000 5000
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR01
U 1 1 58DA1D97
P 8150 5200
F 0 "#PWR01" H 8150 4950 50  0001 C CNN
F 1 "GND" H 8150 5050 50  0000 C CNN
F 2 "" H 8150 5200 50  0001 C CNN
F 3 "" H 8150 5200 50  0001 C CNN
	1    8150 5200
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 58DA1DBE
P 7850 4650
F 0 "R1" V 7930 4650 50  0000 C CNN
F 1 "R" V 7850 4650 50  0000 C CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" V 7780 4650 50  0001 C CNN
F 3 "" H 7850 4650 50  0001 C CNN
	1    7850 4650
	-1   0    0    1   
$EndComp
$Comp
L VDD #PWR02
U 1 1 58DA1E23
P 7850 4400
F 0 "#PWR02" H 7850 4250 50  0001 C CNN
F 1 "VDD" H 7850 4550 50  0000 C CNN
F 2 "" H 7850 4400 50  0001 C CNN
F 3 "" H 7850 4400 50  0001 C CNN
	1    7850 4400
	1    0    0    -1  
$EndComp
Wire Wire Line
	7850 4400 7850 4500
Wire Wire Line
	7850 4800 7850 5000
Wire Wire Line
	8150 5000 8150 5200
$Comp
L PWR_FLAG #FLG03
U 1 1 58DA1F76
P 8150 4400
F 0 "#FLG03" H 8150 4475 50  0001 C CNN
F 1 "PWR_FLAG" H 8150 4550 50  0000 C CNN
F 2 "" H 8150 4400 50  0001 C CNN
F 3 "" H 8150 4400 50  0001 C CNN
	1    8150 4400
	1    0    0    -1  
$EndComp
Wire Wire Line
	8150 4400 8150 4450
Wire Wire Line
	8150 4450 7850 4450
Connection ~ 7850 4450
$Comp
L PWR_FLAG #FLG04
U 1 1 58DA1FB4
P 8450 5200
F 0 "#FLG04" H 8450 5275 50  0001 C CNN
F 1 "PWR_FLAG" H 8450 5350 50  0000 C CNN
F 2 "" H 8450 5200 50  0001 C CNN
F 3 "" H 8450 5200 50  0001 C CNN
	1    8450 5200
	-1   0    0    1   
$EndComp
Wire Wire Line
	8450 5200 8450 5150
Wire Wire Line
	8450 5150 8150 5150
Connection ~ 8150 5150
$EndSCHEMATC
