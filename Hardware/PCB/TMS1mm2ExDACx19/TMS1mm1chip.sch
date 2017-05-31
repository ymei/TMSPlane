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
LIBS:TMSch
LIBS:TMS1mm1chip-cache
EELAYER 26 0
EELAYER END
$Descr USLedger 17000 11000
encoding utf-8
Sheet 1 1
Title "Topmetal-S array"
Date ""
Rev "0"
Comp "KiSch"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L TMS1mm U0
U 1 1 58EEFFC1
P 8500 5500
F 0 "U0" H 8450 6900 60  0000 C CNN
F 1 "TMS1mm2ExDAC" H 8500 4200 60  0000 C CNN
F 2 "Topmetal:TMS1mm2ExDAC" H 8430 5500 50  0000 C CNN
F 3 "" H 8500 5500 50  0000 C CNN
	1    8500 5500
	1    0    0    -1  
$EndComp
Text Label 7650 4350 2    60   ~ 0
Gring
Text Label 7650 4450 2    60   ~ 0
AVDD
Text Label 7650 4550 2    60   ~ 0
AGND
Text Label 7650 4650 2    60   ~ 0
GND_NMOSI
Text Label 7650 4750 2    60   ~ 0
CSA_VREF_{}
Text Label 7650 4850 2    60   ~ 0
CSA_VREF_{}
Text Label 7650 4950 2    60   ~ 0
CSA_VDIS_{}
Text Label 7650 5050 2    60   ~ 0
CSA_VDIS_{}
Text Label 7650 5150 2    60   ~ 0
VCASN_{}
Text Label 7650 5250 2    60   ~ 0
VCASN_{}
Text Label 7650 5350 2    60   ~ 0
VCASP_{}
Text Label 7650 5450 2    60   ~ 0
VCASP_{}
Text Label 7650 5550 2    60   ~ 0
DVDD
Text Label 7650 5650 2    60   ~ 0
DGND
Text Label 7650 5750 2    60   ~ 0
LVDS_VREF
Text Label 7650 5850 2    60   ~ 0
RESET
Text Label 7650 5950 2    60   ~ 0
SDM_OUT2_{}_P
Text Label 7650 6050 2    60   ~ 0
SDM_OUT2_{}_N
Text Label 7650 6150 2    60   ~ 0
SDM_OUT1_{}_N
Text Label 7650 6250 2    60   ~ 0
SDM_OUT1_{}_P
Text Label 7650 6350 2    60   ~ 0
CLK_N
Text Label 7650 6450 2    60   ~ 0
CLK_P
Text Label 7650 6550 2    60   ~ 0
SCK_{}
Text Label 7650 6650 2    60   ~ 0
SDO_{}
Text Label 9350 6750 0    60   ~ 0
SDO_{}
Text Label 9350 6650 0    60   ~ 0
SDM_VDD_Shield
Text Label 9350 6550 0    60   ~ 0
AVDD
Text Label 9350 6450 0    60   ~ 0
AGND
Text Label 9350 6350 0    60   ~ 0
SDM_BIAS_{}
Text Label 9350 6250 0    60   ~ 0
SDM_BIAS_{}
Text Label 9350 6150 0    60   ~ 0
GND_VREF
Text Label 9350 6050 0    60   ~ 0
Ref3
Text Label 9350 5950 0    60   ~ 0
Ref1
Text Label 9350 5850 0    60   ~ 0
Ref2
Text Label 9350 5750 0    60   ~ 0
SDM_testIN
NoConn ~ 9350 5650
NoConn ~ 9350 5550
NoConn ~ 9350 5450
NoConn ~ 9350 5350
Text Label 9350 5250 0    60   ~ 0
DAC_BufferX2_VREF
Text Label 9350 5150 0    60   ~ 0
CSA_VBIASN_{}
Text Label 9350 5050 0    60   ~ 0
CSA_VBIASN_{}
Text Label 9350 4950 0    60   ~ 0
CSA_VBIASP_{}
Text Label 9350 4850 0    60   ~ 0
CSA_VBIASP_{}
NoConn ~ 9350 4750
Text Label 9350 4550 0    60   ~ 0
AGND
Text Label 9350 4450 0    60   ~ 0
AVDD
Text Label 9350 4350 0    60   ~ 0
AGND
Text Label 9350 4250 0    60   ~ 0
AVDD
Text Label 9350 4650 0    60   ~ 0
AOUT1_CSA_{}
$Comp
L C C0
U 1 1 592E2452
P 8000 7150
F 0 "C0" H 8115 7196 50  0000 L CNN
F 1 "1u" H 8115 7105 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 8038 7000 50  0001 C CNN
F 3 "" H 8000 7150 50  0001 C CNN
	1    8000 7150
	1    0    0    -1  
$EndComp
$Comp
L C C1
U 1 1 592E24A6
P 8450 7150
F 0 "C1" H 8565 7196 50  0000 L CNN
F 1 "1u" H 8565 7105 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 8488 7000 50  0001 C CNN
F 3 "" H 8450 7150 50  0001 C CNN
	1    8450 7150
	1    0    0    -1  
$EndComp
$Comp
L C C2
U 1 1 592E2531
P 8900 7150
F 0 "C2" H 9015 7196 50  0000 L CNN
F 1 "1u" H 9015 7105 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 8938 7000 50  0001 C CNN
F 3 "" H 8900 7150 50  0001 C CNN
	1    8900 7150
	1    0    0    -1  
$EndComp
Text Label 8000 7000 0    60   ~ 0
DVDD
Text Label 8000 7300 0    60   ~ 0
DGND
Wire Wire Line
	8450 7000 8900 7000
Wire Wire Line
	8900 7300 8450 7300
Text Label 8600 7000 0    60   ~ 0
AVDD
Text Label 8600 7300 0    60   ~ 0
AGND
$EndSCHEMATC
