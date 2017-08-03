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
LIBS:TMS1mmX19-cache
EELAYER 26 0
EELAYER END
$Descr User 20000 22000
encoding utf-8
Sheet 3 3
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
U 1 1 59697F2A
P 10000 11000
F 0 "U0" H 9950 12400 60  0000 C CNN
F 1 "TMS1mm" H 10000 9700 60  0000 C CNN
F 2 "Topmetal:TMS1mmAout1or2" H 9930 11000 50  0000 C CNN
F 3 "" H 10000 11000 50  0000 C CNN
	1    10000 11000
	1    0    0    -1  
$EndComp
Text GLabel 9150 9850 0    60   BiDi ~ 0
Gring
Text GLabel 9150 9950 0    60   BiDi ~ 0
AVDD
Text GLabel 9150 10050 0    60   BiDi ~ 0
AGND
Text GLabel 9150 10150 0    60   BiDi ~ 0
GND_NMOSI
Text GLabel 9150 10250 0    60   BiDi ~ 0
CSA_VREF_0
Text GLabel 9150 10350 0    60   BiDi ~ 0
CSA_VREF_0
Text GLabel 9150 10450 0    60   BiDi ~ 0
CSA_VDIS_0
Text GLabel 9150 10550 0    60   BiDi ~ 0
CSA_VDIS_0
Text GLabel 9150 10650 0    60   BiDi ~ 0
VCASN_0
Text GLabel 9150 10750 0    60   BiDi ~ 0
VCASN_0
Text GLabel 9150 10850 0    60   BiDi ~ 0
VCASP_0
Text GLabel 9150 10950 0    60   BiDi ~ 0
VCASP_0
Text GLabel 9150 11050 0    60   BiDi ~ 0
DVDD
Text GLabel 9150 11150 0    60   BiDi ~ 0
DGND
Text GLabel 9150 11250 0    60   BiDi ~ 0
LVDS_VREF
Text GLabel 9150 11350 0    60   BiDi ~ 0
RESET
Text GLabel 9150 11450 0    60   BiDi ~ 0
SDM_OUT2_0_P
Text GLabel 9150 11550 0    60   BiDi ~ 0
SDM_OUT2_0_N
Text GLabel 9150 11650 0    60   BiDi ~ 0
SDM_OUT1_0_N
Text GLabel 9150 11750 0    60   BiDi ~ 0
SDM_OUT1_0_P
Text GLabel 9150 11850 0    60   BiDi ~ 0
CLK_0_N
Text GLabel 9150 11950 0    60   BiDi ~ 0
CLK_0_P
Text GLabel 9150 12050 0    60   BiDi ~ 0
SCK_0
Text GLabel 9150 12150 0    60   BiDi ~ 0
SDO_4
Text GLabel 10850 12250 2    60   BiDi ~ 0
SDO_0
Text GLabel 10850 12150 2    60   BiDi ~ 0
SDM_VDD_Shield
Text GLabel 10850 12050 2    60   BiDi ~ 0
AVDD
Text GLabel 10850 11950 2    60   BiDi ~ 0
AGND
Text GLabel 10850 11850 2    60   BiDi ~ 0
SDM_BIAS_0
Text GLabel 10850 11750 2    60   BiDi ~ 0
SDM_BIAS_0
Text GLabel 10850 11650 2    60   BiDi ~ 0
GND_VREF
Text GLabel 10850 11550 2    60   BiDi ~ 0
Ref3
Text GLabel 10850 11450 2    60   BiDi ~ 0
Ref1
Text GLabel 10850 11350 2    60   BiDi ~ 0
Ref2
Text GLabel 10850 11250 2    60   BiDi ~ 0
SDM_testIN
NoConn ~ 10850 11150
NoConn ~ 10850 11050
NoConn ~ 10850 10950
NoConn ~ 10850 10850
Text GLabel 10850 10750 2    60   BiDi ~ 0
DAC_BufferX2_VREF
Text GLabel 10850 10650 2    60   BiDi ~ 0
CSA_VBIASN_0
Text GLabel 10850 10550 2    60   BiDi ~ 0
CSA_VBIASN_0
Text GLabel 10850 10450 2    60   BiDi ~ 0
CSA_VBIASP_0
Text GLabel 10850 10350 2    60   BiDi ~ 0
CSA_VBIASP_0
NoConn ~ 10850 10250
Text GLabel 10850 10150 2    60   BiDi ~ 0
AOUT1_CSA_0
Text GLabel 10850 10050 2    60   BiDi ~ 0
AGND
Text GLabel 10850 9950 2    60   BiDi ~ 0
AVDD
Text GLabel 10850 9850 2    60   BiDi ~ 0
AGND
Text GLabel 10850 9750 2    60   BiDi ~ 0
AVDD
$Comp
L C C0
U 1 1 59697F2B
P 9500 12650
F 0 "C0" H 9500 12730 50  0000 L CNN
F 1 "1u" H 9500 12550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 9430 12650 50  0001 C CNN
F 3 "" H 9500 12650 50  0001 C CNN
	1    9500 12650
	1    0    0    -1  
$EndComp
$Comp
L C C1
U 1 1 59697F2C
P 10000 12650
F 0 "C1" H 10000 12730 50  0000 L CNN
F 1 "1u" H 10000 12550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 9930 12650 50  0001 C CNN
F 3 "" H 10000 12650 50  0001 C CNN
	1    10000 12650
	1    0    0    -1  
$EndComp
$Comp
L C C2
U 1 1 59697F2D
P 10500 12650
F 0 "C2" H 10500 12730 50  0000 L CNN
F 1 "1u" H 10500 12550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 10430 12650 50  0001 C CNN
F 3 "" H 10500 12650 50  0001 C CNN
	1    10500 12650
	1    0    0    -1  
$EndComp
Text GLabel 9500 12800 0    60   BiDi ~ 0
DGND
Text GLabel 9500 12500 0    60   BiDi ~ 0
DVDD
Text GLabel 10000 12800 0    60   BiDi ~ 0
AGND
Text GLabel 10000 12500 0    60   BiDi ~ 0
AVDD
Text GLabel 10500 12800 0    60   BiDi ~ 0
AGND
Text GLabel 10500 12500 0    60   BiDi ~ 0
AVDD
$Comp
L TMS1mm U1
U 1 1 59697F2E
P 10000 7000
F 0 "U1" H 9950 8400 60  0000 C CNN
F 1 "TMS1mm" H 10000 5700 60  0000 C CNN
F 2 "Topmetal:TMS1mmAout1or2" H 9930 7000 50  0000 C CNN
F 3 "" H 10000 7000 50  0000 C CNN
	1    10000 7000
	1    0    0    -1  
$EndComp
Text GLabel 9150 5850 0    60   BiDi ~ 0
Gring
Text GLabel 9150 5950 0    60   BiDi ~ 0
AVDD
Text GLabel 9150 6050 0    60   BiDi ~ 0
AGND
Text GLabel 9150 6150 0    60   BiDi ~ 0
GND_NMOSI
Text GLabel 9150 6250 0    60   BiDi ~ 0
CSA_VREF_1
Text GLabel 9150 6350 0    60   BiDi ~ 0
CSA_VREF_1
Text GLabel 9150 6450 0    60   BiDi ~ 0
CSA_VDIS_1
Text GLabel 9150 6550 0    60   BiDi ~ 0
CSA_VDIS_1
Text GLabel 9150 6650 0    60   BiDi ~ 0
VCASN_1
Text GLabel 9150 6750 0    60   BiDi ~ 0
VCASN_1
Text GLabel 9150 6850 0    60   BiDi ~ 0
VCASP_1
Text GLabel 9150 6950 0    60   BiDi ~ 0
VCASP_1
Text GLabel 9150 7050 0    60   BiDi ~ 0
DVDD
Text GLabel 9150 7150 0    60   BiDi ~ 0
DGND
Text GLabel 9150 7250 0    60   BiDi ~ 0
LVDS_VREF
Text GLabel 9150 7350 0    60   BiDi ~ 0
RESET
Text GLabel 9150 7450 0    60   BiDi ~ 0
SDM_OUT2_1_P
Text GLabel 9150 7550 0    60   BiDi ~ 0
SDM_OUT2_1_N
Text GLabel 9150 7650 0    60   BiDi ~ 0
SDM_OUT1_1_N
Text GLabel 9150 7750 0    60   BiDi ~ 0
SDM_OUT1_1_P
Text GLabel 9150 7850 0    60   BiDi ~ 0
CLK_0_N
Text GLabel 9150 7950 0    60   BiDi ~ 0
CLK_0_P
Text GLabel 9150 8050 0    60   BiDi ~ 0
SCK_0
Text GLabel 9150 8150 0    60   BiDi ~ 0
SDO_0
Text GLabel 10850 8250 2    60   BiDi ~ 0
SDO_1
Text GLabel 10850 8150 2    60   BiDi ~ 0
SDM_VDD_Shield
Text GLabel 10850 8050 2    60   BiDi ~ 0
AVDD
Text GLabel 10850 7950 2    60   BiDi ~ 0
AGND
Text GLabel 10850 7850 2    60   BiDi ~ 0
SDM_BIAS_1
Text GLabel 10850 7750 2    60   BiDi ~ 0
SDM_BIAS_1
Text GLabel 10850 7650 2    60   BiDi ~ 0
GND_VREF
Text GLabel 10850 7550 2    60   BiDi ~ 0
Ref3
Text GLabel 10850 7450 2    60   BiDi ~ 0
Ref1
Text GLabel 10850 7350 2    60   BiDi ~ 0
Ref2
Text GLabel 10850 7250 2    60   BiDi ~ 0
SDM_testIN
NoConn ~ 10850 7150
NoConn ~ 10850 7050
NoConn ~ 10850 6950
NoConn ~ 10850 6850
Text GLabel 10850 6750 2    60   BiDi ~ 0
DAC_BufferX2_VREF
Text GLabel 10850 6650 2    60   BiDi ~ 0
CSA_VBIASN_1
Text GLabel 10850 6550 2    60   BiDi ~ 0
CSA_VBIASN_1
Text GLabel 10850 6450 2    60   BiDi ~ 0
CSA_VBIASP_1
Text GLabel 10850 6350 2    60   BiDi ~ 0
CSA_VBIASP_1
NoConn ~ 10850 6250
Text GLabel 10850 6150 2    60   BiDi ~ 0
AOUT1_CSA_1
Text GLabel 10850 6050 2    60   BiDi ~ 0
AGND
Text GLabel 10850 5950 2    60   BiDi ~ 0
AVDD
Text GLabel 10850 5850 2    60   BiDi ~ 0
AGND
Text GLabel 10850 5750 2    60   BiDi ~ 0
AVDD
$Comp
L C C10
U 1 1 59697F2F
P 9500 8650
F 0 "C10" H 9500 8730 50  0000 L CNN
F 1 "1u" H 9500 8550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 9430 8650 50  0001 C CNN
F 3 "" H 9500 8650 50  0001 C CNN
	1    9500 8650
	1    0    0    -1  
$EndComp
$Comp
L C C11
U 1 1 59697F30
P 10000 8650
F 0 "C11" H 10000 8730 50  0000 L CNN
F 1 "1u" H 10000 8550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 9930 8650 50  0001 C CNN
F 3 "" H 10000 8650 50  0001 C CNN
	1    10000 8650
	1    0    0    -1  
$EndComp
$Comp
L C C12
U 1 1 59697F31
P 10500 8650
F 0 "C12" H 10500 8730 50  0000 L CNN
F 1 "1u" H 10500 8550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 10430 8650 50  0001 C CNN
F 3 "" H 10500 8650 50  0001 C CNN
	1    10500 8650
	1    0    0    -1  
$EndComp
Text GLabel 9500 8800 0    60   BiDi ~ 0
DGND
Text GLabel 9500 8500 0    60   BiDi ~ 0
DVDD
Text GLabel 10000 8800 0    60   BiDi ~ 0
AGND
Text GLabel 10000 8500 0    60   BiDi ~ 0
AVDD
Text GLabel 10500 8800 0    60   BiDi ~ 0
AGND
Text GLabel 10500 8500 0    60   BiDi ~ 0
AVDD
$Comp
L TMS1mm U2
U 1 1 59697F32
P 6536 9000
F 0 "U2" H 6486 10400 60  0000 C CNN
F 1 "TMS1mm" H 6536 7700 60  0000 C CNN
F 2 "Topmetal:TMS1mmAout1or2" H 6466 9000 50  0000 C CNN
F 3 "" H 6536 9000 50  0000 C CNN
	1    6536 9000
	1    0    0    -1  
$EndComp
Text GLabel 5686 7850 0    60   BiDi ~ 0
Gring
Text GLabel 5686 7950 0    60   BiDi ~ 0
AVDD
Text GLabel 5686 8050 0    60   BiDi ~ 0
AGND
Text GLabel 5686 8150 0    60   BiDi ~ 0
GND_NMOSI
Text GLabel 5686 8250 0    60   BiDi ~ 0
CSA_VREF_2
Text GLabel 5686 8350 0    60   BiDi ~ 0
CSA_VREF_2
Text GLabel 5686 8450 0    60   BiDi ~ 0
CSA_VDIS_2
Text GLabel 5686 8550 0    60   BiDi ~ 0
CSA_VDIS_2
Text GLabel 5686 8650 0    60   BiDi ~ 0
VCASN_2
Text GLabel 5686 8750 0    60   BiDi ~ 0
VCASN_2
Text GLabel 5686 8850 0    60   BiDi ~ 0
VCASP_2
Text GLabel 5686 8950 0    60   BiDi ~ 0
VCASP_2
Text GLabel 5686 9050 0    60   BiDi ~ 0
DVDD
Text GLabel 5686 9150 0    60   BiDi ~ 0
DGND
Text GLabel 5686 9250 0    60   BiDi ~ 0
LVDS_VREF
Text GLabel 5686 9350 0    60   BiDi ~ 0
RESET
Text GLabel 5686 9450 0    60   BiDi ~ 0
SDM_OUT2_2_P
Text GLabel 5686 9550 0    60   BiDi ~ 0
SDM_OUT2_2_N
Text GLabel 5686 9650 0    60   BiDi ~ 0
SDM_OUT1_2_N
Text GLabel 5686 9750 0    60   BiDi ~ 0
SDM_OUT1_2_P
Text GLabel 5686 9850 0    60   BiDi ~ 0
CLK_-1_N
Text GLabel 5686 9950 0    60   BiDi ~ 0
CLK_-1_P
Text GLabel 5686 10050 0    60   BiDi ~ 0
SCK_-1
Text GLabel 5686 10150 0    60   BiDi ~ 0
SDO_3
Text GLabel 7386 10250 2    60   BiDi ~ 0
SDO_2
Text GLabel 7386 10150 2    60   BiDi ~ 0
SDM_VDD_Shield
Text GLabel 7386 10050 2    60   BiDi ~ 0
AVDD
Text GLabel 7386 9950 2    60   BiDi ~ 0
AGND
Text GLabel 7386 9850 2    60   BiDi ~ 0
SDM_BIAS_2
Text GLabel 7386 9750 2    60   BiDi ~ 0
SDM_BIAS_2
Text GLabel 7386 9650 2    60   BiDi ~ 0
GND_VREF
Text GLabel 7386 9550 2    60   BiDi ~ 0
Ref3
Text GLabel 7386 9450 2    60   BiDi ~ 0
Ref1
Text GLabel 7386 9350 2    60   BiDi ~ 0
Ref2
Text GLabel 7386 9250 2    60   BiDi ~ 0
SDM_testIN
NoConn ~ 7386 9150
NoConn ~ 7386 9050
NoConn ~ 7386 8950
NoConn ~ 7386 8850
Text GLabel 7386 8750 2    60   BiDi ~ 0
DAC_BufferX2_VREF
Text GLabel 7386 8650 2    60   BiDi ~ 0
CSA_VBIASN_2
Text GLabel 7386 8550 2    60   BiDi ~ 0
CSA_VBIASN_2
Text GLabel 7386 8450 2    60   BiDi ~ 0
CSA_VBIASP_2
Text GLabel 7386 8350 2    60   BiDi ~ 0
CSA_VBIASP_2
NoConn ~ 7386 8250
Text GLabel 7386 8150 2    60   BiDi ~ 0
AOUT1_CSA_2
Text GLabel 7386 8050 2    60   BiDi ~ 0
AGND
Text GLabel 7386 7950 2    60   BiDi ~ 0
AVDD
Text GLabel 7386 7850 2    60   BiDi ~ 0
AGND
Text GLabel 7386 7750 2    60   BiDi ~ 0
AVDD
$Comp
L C C20
U 1 1 59697F33
P 6036 10650
F 0 "C20" H 6036 10730 50  0000 L CNN
F 1 "1u" H 6036 10550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 5966 10650 50  0001 C CNN
F 3 "" H 6036 10650 50  0001 C CNN
	1    6036 10650
	1    0    0    -1  
$EndComp
$Comp
L C C21
U 1 1 59697F34
P 6536 10650
F 0 "C21" H 6536 10730 50  0000 L CNN
F 1 "1u" H 6536 10550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 6466 10650 50  0001 C CNN
F 3 "" H 6536 10650 50  0001 C CNN
	1    6536 10650
	1    0    0    -1  
$EndComp
$Comp
L C C22
U 1 1 59697F35
P 7036 10650
F 0 "C22" H 7036 10730 50  0000 L CNN
F 1 "1u" H 7036 10550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 6966 10650 50  0001 C CNN
F 3 "" H 7036 10650 50  0001 C CNN
	1    7036 10650
	1    0    0    -1  
$EndComp
Text GLabel 6036 10800 0    60   BiDi ~ 0
DGND
Text GLabel 6036 10500 0    60   BiDi ~ 0
DVDD
Text GLabel 6536 10800 0    60   BiDi ~ 0
AGND
Text GLabel 6536 10500 0    60   BiDi ~ 0
AVDD
Text GLabel 7036 10800 0    60   BiDi ~ 0
AGND
Text GLabel 7036 10500 0    60   BiDi ~ 0
AVDD
$Comp
L TMS1mm U3
U 1 1 59697F36
P 6536 13000
F 0 "U3" H 6486 14400 60  0000 C CNN
F 1 "TMS1mm" H 6536 11700 60  0000 C CNN
F 2 "Topmetal:TMS1mmAout1or2" H 6466 13000 50  0000 C CNN
F 3 "" H 6536 13000 50  0000 C CNN
	1    6536 13000
	1    0    0    -1  
$EndComp
Text GLabel 5686 11850 0    60   BiDi ~ 0
Gring
Text GLabel 5686 11950 0    60   BiDi ~ 0
AVDD
Text GLabel 5686 12050 0    60   BiDi ~ 0
AGND
Text GLabel 5686 12150 0    60   BiDi ~ 0
GND_NMOSI
Text GLabel 5686 12250 0    60   BiDi ~ 0
CSA_VREF_3
Text GLabel 5686 12350 0    60   BiDi ~ 0
CSA_VREF_3
Text GLabel 5686 12450 0    60   BiDi ~ 0
CSA_VDIS_3
Text GLabel 5686 12550 0    60   BiDi ~ 0
CSA_VDIS_3
Text GLabel 5686 12650 0    60   BiDi ~ 0
VCASN_3
Text GLabel 5686 12750 0    60   BiDi ~ 0
VCASN_3
Text GLabel 5686 12850 0    60   BiDi ~ 0
VCASP_3
Text GLabel 5686 12950 0    60   BiDi ~ 0
VCASP_3
Text GLabel 5686 13050 0    60   BiDi ~ 0
DVDD
Text GLabel 5686 13150 0    60   BiDi ~ 0
DGND
Text GLabel 5686 13250 0    60   BiDi ~ 0
LVDS_VREF
Text GLabel 5686 13350 0    60   BiDi ~ 0
RESET
Text GLabel 5686 13450 0    60   BiDi ~ 0
SDM_OUT2_3_P
Text GLabel 5686 13550 0    60   BiDi ~ 0
SDM_OUT2_3_N
Text GLabel 5686 13650 0    60   BiDi ~ 0
SDM_OUT1_3_N
Text GLabel 5686 13750 0    60   BiDi ~ 0
SDM_OUT1_3_P
Text GLabel 5686 13850 0    60   BiDi ~ 0
CLK_-1_N
Text GLabel 5686 13950 0    60   BiDi ~ 0
CLK_-1_P
Text GLabel 5686 14050 0    60   BiDi ~ 0
SCK_-1
Text GLabel 5686 14150 0    60   BiDi ~ 0
SDO_12
Text GLabel 7386 14250 2    60   BiDi ~ 0
SDO_3
Text GLabel 7386 14150 2    60   BiDi ~ 0
SDM_VDD_Shield
Text GLabel 7386 14050 2    60   BiDi ~ 0
AVDD
Text GLabel 7386 13950 2    60   BiDi ~ 0
AGND
Text GLabel 7386 13850 2    60   BiDi ~ 0
SDM_BIAS_3
Text GLabel 7386 13750 2    60   BiDi ~ 0
SDM_BIAS_3
Text GLabel 7386 13650 2    60   BiDi ~ 0
GND_VREF
Text GLabel 7386 13550 2    60   BiDi ~ 0
Ref3
Text GLabel 7386 13450 2    60   BiDi ~ 0
Ref1
Text GLabel 7386 13350 2    60   BiDi ~ 0
Ref2
Text GLabel 7386 13250 2    60   BiDi ~ 0
SDM_testIN
NoConn ~ 7386 13150
NoConn ~ 7386 13050
NoConn ~ 7386 12950
NoConn ~ 7386 12850
Text GLabel 7386 12750 2    60   BiDi ~ 0
DAC_BufferX2_VREF
Text GLabel 7386 12650 2    60   BiDi ~ 0
CSA_VBIASN_3
Text GLabel 7386 12550 2    60   BiDi ~ 0
CSA_VBIASN_3
Text GLabel 7386 12450 2    60   BiDi ~ 0
CSA_VBIASP_3
Text GLabel 7386 12350 2    60   BiDi ~ 0
CSA_VBIASP_3
NoConn ~ 7386 12250
Text GLabel 7386 12150 2    60   BiDi ~ 0
AOUT1_CSA_3
Text GLabel 7386 12050 2    60   BiDi ~ 0
AGND
Text GLabel 7386 11950 2    60   BiDi ~ 0
AVDD
Text GLabel 7386 11850 2    60   BiDi ~ 0
AGND
Text GLabel 7386 11750 2    60   BiDi ~ 0
AVDD
$Comp
L C C30
U 1 1 59697F37
P 6036 14650
F 0 "C30" H 6036 14730 50  0000 L CNN
F 1 "1u" H 6036 14550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 5966 14650 50  0001 C CNN
F 3 "" H 6036 14650 50  0001 C CNN
	1    6036 14650
	1    0    0    -1  
$EndComp
$Comp
L C C31
U 1 1 59697F38
P 6536 14650
F 0 "C31" H 6536 14730 50  0000 L CNN
F 1 "1u" H 6536 14550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 6466 14650 50  0001 C CNN
F 3 "" H 6536 14650 50  0001 C CNN
	1    6536 14650
	1    0    0    -1  
$EndComp
$Comp
L C C32
U 1 1 59697F39
P 7036 14650
F 0 "C32" H 7036 14730 50  0000 L CNN
F 1 "1u" H 7036 14550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 6966 14650 50  0001 C CNN
F 3 "" H 7036 14650 50  0001 C CNN
	1    7036 14650
	1    0    0    -1  
$EndComp
Text GLabel 6036 14800 0    60   BiDi ~ 0
DGND
Text GLabel 6036 14500 0    60   BiDi ~ 0
DVDD
Text GLabel 6536 14800 0    60   BiDi ~ 0
AGND
Text GLabel 6536 14500 0    60   BiDi ~ 0
AVDD
Text GLabel 7036 14800 0    60   BiDi ~ 0
AGND
Text GLabel 7036 14500 0    60   BiDi ~ 0
AVDD
$Comp
L TMS1mm U4
U 1 1 59697F3A
P 10000 15000
F 0 "U4" H 9950 16400 60  0000 C CNN
F 1 "TMS1mm" H 10000 13700 60  0000 C CNN
F 2 "Topmetal:TMS1mmAout1or2" H 9930 15000 50  0000 C CNN
F 3 "" H 10000 15000 50  0000 C CNN
	1    10000 15000
	1    0    0    -1  
$EndComp
Text GLabel 9150 13850 0    60   BiDi ~ 0
Gring
Text GLabel 9150 13950 0    60   BiDi ~ 0
AVDD
Text GLabel 9150 14050 0    60   BiDi ~ 0
AGND
Text GLabel 9150 14150 0    60   BiDi ~ 0
GND_NMOSI
Text GLabel 9150 14250 0    60   BiDi ~ 0
CSA_VREF_4
Text GLabel 9150 14350 0    60   BiDi ~ 0
CSA_VREF_4
Text GLabel 9150 14450 0    60   BiDi ~ 0
CSA_VDIS_4
Text GLabel 9150 14550 0    60   BiDi ~ 0
CSA_VDIS_4
Text GLabel 9150 14650 0    60   BiDi ~ 0
VCASN_4
Text GLabel 9150 14750 0    60   BiDi ~ 0
VCASN_4
Text GLabel 9150 14850 0    60   BiDi ~ 0
VCASP_4
Text GLabel 9150 14950 0    60   BiDi ~ 0
VCASP_4
Text GLabel 9150 15050 0    60   BiDi ~ 0
DVDD
Text GLabel 9150 15150 0    60   BiDi ~ 0
DGND
Text GLabel 9150 15250 0    60   BiDi ~ 0
LVDS_VREF
Text GLabel 9150 15350 0    60   BiDi ~ 0
RESET
Text GLabel 9150 15450 0    60   BiDi ~ 0
SDM_OUT2_4_P
Text GLabel 9150 15550 0    60   BiDi ~ 0
SDM_OUT2_4_N
Text GLabel 9150 15650 0    60   BiDi ~ 0
SDM_OUT1_4_N
Text GLabel 9150 15750 0    60   BiDi ~ 0
SDM_OUT1_4_P
Text GLabel 9150 15850 0    60   BiDi ~ 0
CLK_0_N
Text GLabel 9150 15950 0    60   BiDi ~ 0
CLK_0_P
Text GLabel 9150 16050 0    60   BiDi ~ 0
SCK_0
Text GLabel 9150 16150 0    60   BiDi ~ 0
SDO_13
Text GLabel 10850 16250 2    60   BiDi ~ 0
SDO_4
Text GLabel 10850 16150 2    60   BiDi ~ 0
SDM_VDD_Shield
Text GLabel 10850 16050 2    60   BiDi ~ 0
AVDD
Text GLabel 10850 15950 2    60   BiDi ~ 0
AGND
Text GLabel 10850 15850 2    60   BiDi ~ 0
SDM_BIAS_4
Text GLabel 10850 15750 2    60   BiDi ~ 0
SDM_BIAS_4
Text GLabel 10850 15650 2    60   BiDi ~ 0
GND_VREF
Text GLabel 10850 15550 2    60   BiDi ~ 0
Ref3
Text GLabel 10850 15450 2    60   BiDi ~ 0
Ref1
Text GLabel 10850 15350 2    60   BiDi ~ 0
Ref2
Text GLabel 10850 15250 2    60   BiDi ~ 0
SDM_testIN
NoConn ~ 10850 15150
NoConn ~ 10850 15050
NoConn ~ 10850 14950
NoConn ~ 10850 14850
Text GLabel 10850 14750 2    60   BiDi ~ 0
DAC_BufferX2_VREF
Text GLabel 10850 14650 2    60   BiDi ~ 0
CSA_VBIASN_4
Text GLabel 10850 14550 2    60   BiDi ~ 0
CSA_VBIASN_4
Text GLabel 10850 14450 2    60   BiDi ~ 0
CSA_VBIASP_4
Text GLabel 10850 14350 2    60   BiDi ~ 0
CSA_VBIASP_4
NoConn ~ 10850 14250
Text GLabel 10850 14150 2    60   BiDi ~ 0
AOUT1_CSA_4
Text GLabel 10850 14050 2    60   BiDi ~ 0
AGND
Text GLabel 10850 13950 2    60   BiDi ~ 0
AVDD
Text GLabel 10850 13850 2    60   BiDi ~ 0
AGND
Text GLabel 10850 13750 2    60   BiDi ~ 0
AVDD
$Comp
L C C40
U 1 1 59697F3B
P 9500 16650
F 0 "C40" H 9500 16730 50  0000 L CNN
F 1 "1u" H 9500 16550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 9430 16650 50  0001 C CNN
F 3 "" H 9500 16650 50  0001 C CNN
	1    9500 16650
	1    0    0    -1  
$EndComp
$Comp
L C C41
U 1 1 59697F3C
P 10000 16650
F 0 "C41" H 10000 16730 50  0000 L CNN
F 1 "1u" H 10000 16550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 9930 16650 50  0001 C CNN
F 3 "" H 10000 16650 50  0001 C CNN
	1    10000 16650
	1    0    0    -1  
$EndComp
$Comp
L C C42
U 1 1 59697F3D
P 10500 16650
F 0 "C42" H 10500 16730 50  0000 L CNN
F 1 "1u" H 10500 16550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 10430 16650 50  0001 C CNN
F 3 "" H 10500 16650 50  0001 C CNN
	1    10500 16650
	1    0    0    -1  
$EndComp
Text GLabel 9500 16800 0    60   BiDi ~ 0
DGND
Text GLabel 9500 16500 0    60   BiDi ~ 0
DVDD
Text GLabel 10000 16800 0    60   BiDi ~ 0
AGND
Text GLabel 10000 16500 0    60   BiDi ~ 0
AVDD
Text GLabel 10500 16800 0    60   BiDi ~ 0
AGND
Text GLabel 10500 16500 0    60   BiDi ~ 0
AVDD
$Comp
L TMS1mm U5
U 1 1 59697F3E
P 13464 13000
F 0 "U5" H 13414 14400 60  0000 C CNN
F 1 "TMS1mm" H 13464 11700 60  0000 C CNN
F 2 "Topmetal:TMS1mmAout1or2" H 13394 13000 50  0000 C CNN
F 3 "" H 13464 13000 50  0000 C CNN
	1    13464 13000
	1    0    0    -1  
$EndComp
Text GLabel 12614 11850 0    60   BiDi ~ 0
Gring
Text GLabel 12614 11950 0    60   BiDi ~ 0
AVDD
Text GLabel 12614 12050 0    60   BiDi ~ 0
AGND
Text GLabel 12614 12150 0    60   BiDi ~ 0
GND_NMOSI
Text GLabel 12614 12250 0    60   BiDi ~ 0
CSA_VREF_5
Text GLabel 12614 12350 0    60   BiDi ~ 0
CSA_VREF_5
Text GLabel 12614 12450 0    60   BiDi ~ 0
CSA_VDIS_5
Text GLabel 12614 12550 0    60   BiDi ~ 0
CSA_VDIS_5
Text GLabel 12614 12650 0    60   BiDi ~ 0
VCASN_5
Text GLabel 12614 12750 0    60   BiDi ~ 0
VCASN_5
Text GLabel 12614 12850 0    60   BiDi ~ 0
VCASP_5
Text GLabel 12614 12950 0    60   BiDi ~ 0
VCASP_5
Text GLabel 12614 13050 0    60   BiDi ~ 0
DVDD
Text GLabel 12614 13150 0    60   BiDi ~ 0
DGND
Text GLabel 12614 13250 0    60   BiDi ~ 0
LVDS_VREF
Text GLabel 12614 13350 0    60   BiDi ~ 0
RESET
Text GLabel 12614 13450 0    60   BiDi ~ 0
SDM_OUT2_5_P
Text GLabel 12614 13550 0    60   BiDi ~ 0
SDM_OUT2_5_N
Text GLabel 12614 13650 0    60   BiDi ~ 0
SDM_OUT1_5_N
Text GLabel 12614 13750 0    60   BiDi ~ 0
SDM_OUT1_5_P
Text GLabel 12614 13850 0    60   BiDi ~ 0
CLK_1_N
Text GLabel 12614 13950 0    60   BiDi ~ 0
CLK_1_P
Text GLabel 12614 14050 0    60   BiDi ~ 0
SCK_1
Text GLabel 12614 14150 0    60   BiDi ~ 0
SDO_14
Text GLabel 14314 14250 2    60   BiDi ~ 0
SDO_5
Text GLabel 14314 14150 2    60   BiDi ~ 0
SDM_VDD_Shield
Text GLabel 14314 14050 2    60   BiDi ~ 0
AVDD
Text GLabel 14314 13950 2    60   BiDi ~ 0
AGND
Text GLabel 14314 13850 2    60   BiDi ~ 0
SDM_BIAS_5
Text GLabel 14314 13750 2    60   BiDi ~ 0
SDM_BIAS_5
Text GLabel 14314 13650 2    60   BiDi ~ 0
GND_VREF
Text GLabel 14314 13550 2    60   BiDi ~ 0
Ref3
Text GLabel 14314 13450 2    60   BiDi ~ 0
Ref1
Text GLabel 14314 13350 2    60   BiDi ~ 0
Ref2
Text GLabel 14314 13250 2    60   BiDi ~ 0
SDM_testIN
NoConn ~ 14314 13150
NoConn ~ 14314 13050
NoConn ~ 14314 12950
NoConn ~ 14314 12850
Text GLabel 14314 12750 2    60   BiDi ~ 0
DAC_BufferX2_VREF
Text GLabel 14314 12650 2    60   BiDi ~ 0
CSA_VBIASN_5
Text GLabel 14314 12550 2    60   BiDi ~ 0
CSA_VBIASN_5
Text GLabel 14314 12450 2    60   BiDi ~ 0
CSA_VBIASP_5
Text GLabel 14314 12350 2    60   BiDi ~ 0
CSA_VBIASP_5
NoConn ~ 14314 12250
Text GLabel 14314 12150 2    60   BiDi ~ 0
AOUT1_CSA_5
Text GLabel 14314 12050 2    60   BiDi ~ 0
AGND
Text GLabel 14314 11950 2    60   BiDi ~ 0
AVDD
Text GLabel 14314 11850 2    60   BiDi ~ 0
AGND
Text GLabel 14314 11750 2    60   BiDi ~ 0
AVDD
$Comp
L C C50
U 1 1 59697F3F
P 12964 14650
F 0 "C50" H 12964 14730 50  0000 L CNN
F 1 "1u" H 12964 14550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 12894 14650 50  0001 C CNN
F 3 "" H 12964 14650 50  0001 C CNN
	1    12964 14650
	1    0    0    -1  
$EndComp
$Comp
L C C51
U 1 1 59697F40
P 13464 14650
F 0 "C51" H 13464 14730 50  0000 L CNN
F 1 "1u" H 13464 14550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 13394 14650 50  0001 C CNN
F 3 "" H 13464 14650 50  0001 C CNN
	1    13464 14650
	1    0    0    -1  
$EndComp
$Comp
L C C52
U 1 1 59697F41
P 13964 14650
F 0 "C52" H 13964 14730 50  0000 L CNN
F 1 "1u" H 13964 14550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 13894 14650 50  0001 C CNN
F 3 "" H 13964 14650 50  0001 C CNN
	1    13964 14650
	1    0    0    -1  
$EndComp
Text GLabel 12964 14800 0    60   BiDi ~ 0
DGND
Text GLabel 12964 14500 0    60   BiDi ~ 0
DVDD
Text GLabel 13464 14800 0    60   BiDi ~ 0
AGND
Text GLabel 13464 14500 0    60   BiDi ~ 0
AVDD
Text GLabel 13964 14800 0    60   BiDi ~ 0
AGND
Text GLabel 13964 14500 0    60   BiDi ~ 0
AVDD
$Comp
L TMS1mm U6
U 1 1 59697F42
P 13464 9000
F 0 "U6" H 13414 10400 60  0000 C CNN
F 1 "TMS1mm" H 13464 7700 60  0000 C CNN
F 2 "Topmetal:TMS1mmAout1or2" H 13394 9000 50  0000 C CNN
F 3 "" H 13464 9000 50  0000 C CNN
	1    13464 9000
	1    0    0    -1  
$EndComp
Text GLabel 12614 7850 0    60   BiDi ~ 0
Gring
Text GLabel 12614 7950 0    60   BiDi ~ 0
AVDD
Text GLabel 12614 8050 0    60   BiDi ~ 0
AGND
Text GLabel 12614 8150 0    60   BiDi ~ 0
GND_NMOSI
Text GLabel 12614 8250 0    60   BiDi ~ 0
CSA_VREF_6
Text GLabel 12614 8350 0    60   BiDi ~ 0
CSA_VREF_6
Text GLabel 12614 8450 0    60   BiDi ~ 0
CSA_VDIS_6
Text GLabel 12614 8550 0    60   BiDi ~ 0
CSA_VDIS_6
Text GLabel 12614 8650 0    60   BiDi ~ 0
VCASN_6
Text GLabel 12614 8750 0    60   BiDi ~ 0
VCASN_6
Text GLabel 12614 8850 0    60   BiDi ~ 0
VCASP_6
Text GLabel 12614 8950 0    60   BiDi ~ 0
VCASP_6
Text GLabel 12614 9050 0    60   BiDi ~ 0
DVDD
Text GLabel 12614 9150 0    60   BiDi ~ 0
DGND
Text GLabel 12614 9250 0    60   BiDi ~ 0
LVDS_VREF
Text GLabel 12614 9350 0    60   BiDi ~ 0
RESET
Text GLabel 12614 9450 0    60   BiDi ~ 0
SDM_OUT2_6_P
Text GLabel 12614 9550 0    60   BiDi ~ 0
SDM_OUT2_6_N
Text GLabel 12614 9650 0    60   BiDi ~ 0
SDM_OUT1_6_N
Text GLabel 12614 9750 0    60   BiDi ~ 0
SDM_OUT1_6_P
Text GLabel 12614 9850 0    60   BiDi ~ 0
CLK_1_N
Text GLabel 12614 9950 0    60   BiDi ~ 0
CLK_1_P
Text GLabel 12614 10050 0    60   BiDi ~ 0
SCK_1
Text GLabel 12614 10150 0    60   BiDi ~ 0
SDO_5
Text GLabel 14314 10250 2    60   BiDi ~ 0
SDO_6
Text GLabel 14314 10150 2    60   BiDi ~ 0
SDM_VDD_Shield
Text GLabel 14314 10050 2    60   BiDi ~ 0
AVDD
Text GLabel 14314 9950 2    60   BiDi ~ 0
AGND
Text GLabel 14314 9850 2    60   BiDi ~ 0
SDM_BIAS_6
Text GLabel 14314 9750 2    60   BiDi ~ 0
SDM_BIAS_6
Text GLabel 14314 9650 2    60   BiDi ~ 0
GND_VREF
Text GLabel 14314 9550 2    60   BiDi ~ 0
Ref3
Text GLabel 14314 9450 2    60   BiDi ~ 0
Ref1
Text GLabel 14314 9350 2    60   BiDi ~ 0
Ref2
Text GLabel 14314 9250 2    60   BiDi ~ 0
SDM_testIN
NoConn ~ 14314 9150
NoConn ~ 14314 9050
NoConn ~ 14314 8950
NoConn ~ 14314 8850
Text GLabel 14314 8750 2    60   BiDi ~ 0
DAC_BufferX2_VREF
Text GLabel 14314 8650 2    60   BiDi ~ 0
CSA_VBIASN_6
Text GLabel 14314 8550 2    60   BiDi ~ 0
CSA_VBIASN_6
Text GLabel 14314 8450 2    60   BiDi ~ 0
CSA_VBIASP_6
Text GLabel 14314 8350 2    60   BiDi ~ 0
CSA_VBIASP_6
NoConn ~ 14314 8250
Text GLabel 14314 8150 2    60   BiDi ~ 0
AOUT1_CSA_6
Text GLabel 14314 8050 2    60   BiDi ~ 0
AGND
Text GLabel 14314 7950 2    60   BiDi ~ 0
AVDD
Text GLabel 14314 7850 2    60   BiDi ~ 0
AGND
Text GLabel 14314 7750 2    60   BiDi ~ 0
AVDD
$Comp
L C C60
U 1 1 59697F43
P 12964 10650
F 0 "C60" H 12964 10730 50  0000 L CNN
F 1 "1u" H 12964 10550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 12894 10650 50  0001 C CNN
F 3 "" H 12964 10650 50  0001 C CNN
	1    12964 10650
	1    0    0    -1  
$EndComp
$Comp
L C C61
U 1 1 59697F44
P 13464 10650
F 0 "C61" H 13464 10730 50  0000 L CNN
F 1 "1u" H 13464 10550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 13394 10650 50  0001 C CNN
F 3 "" H 13464 10650 50  0001 C CNN
	1    13464 10650
	1    0    0    -1  
$EndComp
$Comp
L C C62
U 1 1 59697F45
P 13964 10650
F 0 "C62" H 13964 10730 50  0000 L CNN
F 1 "1u" H 13964 10550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 13894 10650 50  0001 C CNN
F 3 "" H 13964 10650 50  0001 C CNN
	1    13964 10650
	1    0    0    -1  
$EndComp
Text GLabel 12964 10800 0    60   BiDi ~ 0
DGND
Text GLabel 12964 10500 0    60   BiDi ~ 0
DVDD
Text GLabel 13464 10800 0    60   BiDi ~ 0
AGND
Text GLabel 13464 10500 0    60   BiDi ~ 0
AVDD
Text GLabel 13964 10800 0    60   BiDi ~ 0
AGND
Text GLabel 13964 10500 0    60   BiDi ~ 0
AVDD
$Comp
L TMS1mm U7
U 1 1 59697F46
P 10000 3000
F 0 "U7" H 9950 4400 60  0000 C CNN
F 1 "TMS1mm" H 10000 1700 60  0000 C CNN
F 2 "Topmetal:TMS1mmAout1or2" H 9930 3000 50  0000 C CNN
F 3 "" H 10000 3000 50  0000 C CNN
	1    10000 3000
	1    0    0    -1  
$EndComp
Text GLabel 9150 1850 0    60   BiDi ~ 0
Gring
Text GLabel 9150 1950 0    60   BiDi ~ 0
AVDD
Text GLabel 9150 2050 0    60   BiDi ~ 0
AGND
Text GLabel 9150 2150 0    60   BiDi ~ 0
GND_NMOSI
Text GLabel 9150 2250 0    60   BiDi ~ 0
CSA_VREF_7
Text GLabel 9150 2350 0    60   BiDi ~ 0
CSA_VREF_7
Text GLabel 9150 2450 0    60   BiDi ~ 0
CSA_VDIS_7
Text GLabel 9150 2550 0    60   BiDi ~ 0
CSA_VDIS_7
Text GLabel 9150 2650 0    60   BiDi ~ 0
VCASN_7
Text GLabel 9150 2750 0    60   BiDi ~ 0
VCASN_7
Text GLabel 9150 2850 0    60   BiDi ~ 0
VCASP_7
Text GLabel 9150 2950 0    60   BiDi ~ 0
VCASP_7
Text GLabel 9150 3050 0    60   BiDi ~ 0
DVDD
Text GLabel 9150 3150 0    60   BiDi ~ 0
DGND
Text GLabel 9150 3250 0    60   BiDi ~ 0
LVDS_VREF
Text GLabel 9150 3350 0    60   BiDi ~ 0
RESET
Text GLabel 9150 3450 0    60   BiDi ~ 0
SDM_OUT2_7_P
Text GLabel 9150 3550 0    60   BiDi ~ 0
SDM_OUT2_7_N
Text GLabel 9150 3650 0    60   BiDi ~ 0
SDM_OUT1_7_N
Text GLabel 9150 3750 0    60   BiDi ~ 0
SDM_OUT1_7_P
Text GLabel 9150 3850 0    60   BiDi ~ 0
CLK_0_N
Text GLabel 9150 3950 0    60   BiDi ~ 0
CLK_0_P
Text GLabel 9150 4050 0    60   BiDi ~ 0
SCK_0
Text GLabel 9150 4150 0    60   BiDi ~ 0
SDO_1
Text GLabel 10850 4250 2    60   BiDi ~ 0
SDO_7
Text GLabel 10850 4150 2    60   BiDi ~ 0
SDM_VDD_Shield
Text GLabel 10850 4050 2    60   BiDi ~ 0
AVDD
Text GLabel 10850 3950 2    60   BiDi ~ 0
AGND
Text GLabel 10850 3850 2    60   BiDi ~ 0
SDM_BIAS_7
Text GLabel 10850 3750 2    60   BiDi ~ 0
SDM_BIAS_7
Text GLabel 10850 3650 2    60   BiDi ~ 0
GND_VREF
Text GLabel 10850 3550 2    60   BiDi ~ 0
Ref3
Text GLabel 10850 3450 2    60   BiDi ~ 0
Ref1
Text GLabel 10850 3350 2    60   BiDi ~ 0
Ref2
Text GLabel 10850 3250 2    60   BiDi ~ 0
SDM_testIN
NoConn ~ 10850 3150
NoConn ~ 10850 3050
NoConn ~ 10850 2950
NoConn ~ 10850 2850
Text GLabel 10850 2750 2    60   BiDi ~ 0
DAC_BufferX2_VREF
Text GLabel 10850 2650 2    60   BiDi ~ 0
CSA_VBIASN_7
Text GLabel 10850 2550 2    60   BiDi ~ 0
CSA_VBIASN_7
Text GLabel 10850 2450 2    60   BiDi ~ 0
CSA_VBIASP_7
Text GLabel 10850 2350 2    60   BiDi ~ 0
CSA_VBIASP_7
NoConn ~ 10850 2250
Text GLabel 10850 2150 2    60   BiDi ~ 0
AOUT1_CSA_7
Text GLabel 10850 2050 2    60   BiDi ~ 0
AGND
Text GLabel 10850 1950 2    60   BiDi ~ 0
AVDD
Text GLabel 10850 1850 2    60   BiDi ~ 0
AGND
Text GLabel 10850 1750 2    60   BiDi ~ 0
AVDD
$Comp
L C C70
U 1 1 59697F47
P 9500 4650
F 0 "C70" H 9500 4730 50  0000 L CNN
F 1 "1u" H 9500 4550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 9430 4650 50  0001 C CNN
F 3 "" H 9500 4650 50  0001 C CNN
	1    9500 4650
	1    0    0    -1  
$EndComp
$Comp
L C C71
U 1 1 59697F48
P 10000 4650
F 0 "C71" H 10000 4730 50  0000 L CNN
F 1 "1u" H 10000 4550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 9930 4650 50  0001 C CNN
F 3 "" H 10000 4650 50  0001 C CNN
	1    10000 4650
	1    0    0    -1  
$EndComp
$Comp
L C C72
U 1 1 59697F49
P 10500 4650
F 0 "C72" H 10500 4730 50  0000 L CNN
F 1 "1u" H 10500 4550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 10430 4650 50  0001 C CNN
F 3 "" H 10500 4650 50  0001 C CNN
	1    10500 4650
	1    0    0    -1  
$EndComp
Text GLabel 9500 4800 0    60   BiDi ~ 0
DGND
Text GLabel 9500 4500 0    60   BiDi ~ 0
DVDD
Text GLabel 10000 4800 0    60   BiDi ~ 0
AGND
Text GLabel 10000 4500 0    60   BiDi ~ 0
AVDD
Text GLabel 10500 4800 0    60   BiDi ~ 0
AGND
Text GLabel 10500 4500 0    60   BiDi ~ 0
AVDD
$Comp
L TMS1mm U8
U 1 1 59697F4A
P 6536 5000
F 0 "U8" H 6486 6400 60  0000 C CNN
F 1 "TMS1mm" H 6536 3700 60  0000 C CNN
F 2 "Topmetal:TMS1mmAout1or2" H 6466 5000 50  0000 C CNN
F 3 "" H 6536 5000 50  0000 C CNN
	1    6536 5000
	1    0    0    -1  
$EndComp
Text GLabel 5686 3850 0    60   BiDi ~ 0
Gring
Text GLabel 5686 3950 0    60   BiDi ~ 0
AVDD
Text GLabel 5686 4050 0    60   BiDi ~ 0
AGND
Text GLabel 5686 4150 0    60   BiDi ~ 0
GND_NMOSI
Text GLabel 5686 4250 0    60   BiDi ~ 0
CSA_VREF_8
Text GLabel 5686 4350 0    60   BiDi ~ 0
CSA_VREF_8
Text GLabel 5686 4450 0    60   BiDi ~ 0
CSA_VDIS_8
Text GLabel 5686 4550 0    60   BiDi ~ 0
CSA_VDIS_8
Text GLabel 5686 4650 0    60   BiDi ~ 0
VCASN_8
Text GLabel 5686 4750 0    60   BiDi ~ 0
VCASN_8
Text GLabel 5686 4850 0    60   BiDi ~ 0
VCASP_8
Text GLabel 5686 4950 0    60   BiDi ~ 0
VCASP_8
Text GLabel 5686 5050 0    60   BiDi ~ 0
DVDD
Text GLabel 5686 5150 0    60   BiDi ~ 0
DGND
Text GLabel 5686 5250 0    60   BiDi ~ 0
LVDS_VREF
Text GLabel 5686 5350 0    60   BiDi ~ 0
RESET
Text GLabel 5686 5450 0    60   BiDi ~ 0
SDM_OUT2_8_P
Text GLabel 5686 5550 0    60   BiDi ~ 0
SDM_OUT2_8_N
Text GLabel 5686 5650 0    60   BiDi ~ 0
SDM_OUT1_8_N
Text GLabel 5686 5750 0    60   BiDi ~ 0
SDM_OUT1_8_P
Text GLabel 5686 5850 0    60   BiDi ~ 0
CLK_-1_N
Text GLabel 5686 5950 0    60   BiDi ~ 0
CLK_-1_P
Text GLabel 5686 6050 0    60   BiDi ~ 0
SCK_-1
Text GLabel 5686 6150 0    60   BiDi ~ 0
SDO_2
Text GLabel 7386 6250 2    60   BiDi ~ 0
SDO_8
Text GLabel 7386 6150 2    60   BiDi ~ 0
SDM_VDD_Shield
Text GLabel 7386 6050 2    60   BiDi ~ 0
AVDD
Text GLabel 7386 5950 2    60   BiDi ~ 0
AGND
Text GLabel 7386 5850 2    60   BiDi ~ 0
SDM_BIAS_8
Text GLabel 7386 5750 2    60   BiDi ~ 0
SDM_BIAS_8
Text GLabel 7386 5650 2    60   BiDi ~ 0
GND_VREF
Text GLabel 7386 5550 2    60   BiDi ~ 0
Ref3
Text GLabel 7386 5450 2    60   BiDi ~ 0
Ref1
Text GLabel 7386 5350 2    60   BiDi ~ 0
Ref2
Text GLabel 7386 5250 2    60   BiDi ~ 0
SDM_testIN
NoConn ~ 7386 5150
NoConn ~ 7386 5050
NoConn ~ 7386 4950
NoConn ~ 7386 4850
Text GLabel 7386 4750 2    60   BiDi ~ 0
DAC_BufferX2_VREF
Text GLabel 7386 4650 2    60   BiDi ~ 0
CSA_VBIASN_8
Text GLabel 7386 4550 2    60   BiDi ~ 0
CSA_VBIASN_8
Text GLabel 7386 4450 2    60   BiDi ~ 0
CSA_VBIASP_8
Text GLabel 7386 4350 2    60   BiDi ~ 0
CSA_VBIASP_8
NoConn ~ 7386 4250
Text GLabel 7386 4150 2    60   BiDi ~ 0
AOUT1_CSA_8
Text GLabel 7386 4050 2    60   BiDi ~ 0
AGND
Text GLabel 7386 3950 2    60   BiDi ~ 0
AVDD
Text GLabel 7386 3850 2    60   BiDi ~ 0
AGND
Text GLabel 7386 3750 2    60   BiDi ~ 0
AVDD
$Comp
L C C80
U 1 1 59697F4B
P 6036 6650
F 0 "C80" H 6036 6730 50  0000 L CNN
F 1 "1u" H 6036 6550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 5966 6650 50  0001 C CNN
F 3 "" H 6036 6650 50  0001 C CNN
	1    6036 6650
	1    0    0    -1  
$EndComp
$Comp
L C C81
U 1 1 59697F4C
P 6536 6650
F 0 "C81" H 6536 6730 50  0000 L CNN
F 1 "1u" H 6536 6550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 6466 6650 50  0001 C CNN
F 3 "" H 6536 6650 50  0001 C CNN
	1    6536 6650
	1    0    0    -1  
$EndComp
$Comp
L C C82
U 1 1 59697F4D
P 7036 6650
F 0 "C82" H 7036 6730 50  0000 L CNN
F 1 "1u" H 7036 6550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 6966 6650 50  0001 C CNN
F 3 "" H 7036 6650 50  0001 C CNN
	1    7036 6650
	1    0    0    -1  
$EndComp
Text GLabel 6036 6800 0    60   BiDi ~ 0
DGND
Text GLabel 6036 6500 0    60   BiDi ~ 0
DVDD
Text GLabel 6536 6800 0    60   BiDi ~ 0
AGND
Text GLabel 6536 6500 0    60   BiDi ~ 0
AVDD
Text GLabel 7036 6800 0    60   BiDi ~ 0
AGND
Text GLabel 7036 6500 0    60   BiDi ~ 0
AVDD
$Comp
L TMS1mm U9
U 1 1 59697F4E
P 3072 7000
F 0 "U9" H 3022 8400 60  0000 C CNN
F 1 "TMS1mm" H 3072 5700 60  0000 C CNN
F 2 "Topmetal:TMS1mmAout1or2" H 3002 7000 50  0000 C CNN
F 3 "" H 3072 7000 50  0000 C CNN
	1    3072 7000
	1    0    0    -1  
$EndComp
Text GLabel 2222 5850 0    60   BiDi ~ 0
Gring
Text GLabel 2222 5950 0    60   BiDi ~ 0
AVDD
Text GLabel 2222 6050 0    60   BiDi ~ 0
AGND
Text GLabel 2222 6150 0    60   BiDi ~ 0
GND_NMOSI
Text GLabel 2222 6250 0    60   BiDi ~ 0
CSA_VREF_9
Text GLabel 2222 6350 0    60   BiDi ~ 0
CSA_VREF_9
Text GLabel 2222 6450 0    60   BiDi ~ 0
CSA_VDIS_9
Text GLabel 2222 6550 0    60   BiDi ~ 0
CSA_VDIS_9
Text GLabel 2222 6650 0    60   BiDi ~ 0
VCASN_9
Text GLabel 2222 6750 0    60   BiDi ~ 0
VCASN_9
Text GLabel 2222 6850 0    60   BiDi ~ 0
VCASP_9
Text GLabel 2222 6950 0    60   BiDi ~ 0
VCASP_9
Text GLabel 2222 7050 0    60   BiDi ~ 0
DVDD
Text GLabel 2222 7150 0    60   BiDi ~ 0
DGND
Text GLabel 2222 7250 0    60   BiDi ~ 0
LVDS_VREF
Text GLabel 2222 7350 0    60   BiDi ~ 0
RESET
Text GLabel 2222 7450 0    60   BiDi ~ 0
SDM_OUT2_9_P
Text GLabel 2222 7550 0    60   BiDi ~ 0
SDM_OUT2_9_N
Text GLabel 2222 7650 0    60   BiDi ~ 0
SDM_OUT1_9_N
Text GLabel 2222 7750 0    60   BiDi ~ 0
SDM_OUT1_9_P
Text GLabel 2222 7850 0    60   BiDi ~ 0
CLK_-2_N
Text GLabel 2222 7950 0    60   BiDi ~ 0
CLK_-2_P
Text GLabel 2222 8050 0    60   BiDi ~ 0
SCK_-2
Text GLabel 2222 8150 0    60   BiDi ~ 0
SDO_10
Text GLabel 3922 8250 2    60   BiDi ~ 0
SDO_9
Text GLabel 3922 8150 2    60   BiDi ~ 0
SDM_VDD_Shield
Text GLabel 3922 8050 2    60   BiDi ~ 0
AVDD
Text GLabel 3922 7950 2    60   BiDi ~ 0
AGND
Text GLabel 3922 7850 2    60   BiDi ~ 0
SDM_BIAS_9
Text GLabel 3922 7750 2    60   BiDi ~ 0
SDM_BIAS_9
Text GLabel 3922 7650 2    60   BiDi ~ 0
GND_VREF
Text GLabel 3922 7550 2    60   BiDi ~ 0
Ref3
Text GLabel 3922 7450 2    60   BiDi ~ 0
Ref1
Text GLabel 3922 7350 2    60   BiDi ~ 0
Ref2
Text GLabel 3922 7250 2    60   BiDi ~ 0
SDM_testIN
NoConn ~ 3922 7150
NoConn ~ 3922 7050
NoConn ~ 3922 6950
NoConn ~ 3922 6850
Text GLabel 3922 6750 2    60   BiDi ~ 0
DAC_BufferX2_VREF
Text GLabel 3922 6650 2    60   BiDi ~ 0
CSA_VBIASN_9
Text GLabel 3922 6550 2    60   BiDi ~ 0
CSA_VBIASN_9
Text GLabel 3922 6450 2    60   BiDi ~ 0
CSA_VBIASP_9
Text GLabel 3922 6350 2    60   BiDi ~ 0
CSA_VBIASP_9
NoConn ~ 3922 6250
Text GLabel 3922 6150 2    60   BiDi ~ 0
AOUT1_CSA_9
Text GLabel 3922 6050 2    60   BiDi ~ 0
AGND
Text GLabel 3922 5950 2    60   BiDi ~ 0
AVDD
Text GLabel 3922 5850 2    60   BiDi ~ 0
AGND
Text GLabel 3922 5750 2    60   BiDi ~ 0
AVDD
$Comp
L C C90
U 1 1 59697F4F
P 2572 8650
F 0 "C90" H 2572 8730 50  0000 L CNN
F 1 "1u" H 2572 8550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 2502 8650 50  0001 C CNN
F 3 "" H 2572 8650 50  0001 C CNN
	1    2572 8650
	1    0    0    -1  
$EndComp
$Comp
L C C91
U 1 1 59697F50
P 3072 8650
F 0 "C91" H 3072 8730 50  0000 L CNN
F 1 "1u" H 3072 8550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 3002 8650 50  0001 C CNN
F 3 "" H 3072 8650 50  0001 C CNN
	1    3072 8650
	1    0    0    -1  
$EndComp
$Comp
L C C92
U 1 1 59697F51
P 3572 8650
F 0 "C92" H 3572 8730 50  0000 L CNN
F 1 "1u" H 3572 8550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 3502 8650 50  0001 C CNN
F 3 "" H 3572 8650 50  0001 C CNN
	1    3572 8650
	1    0    0    -1  
$EndComp
Text GLabel 2572 8800 0    60   BiDi ~ 0
DGND
Text GLabel 2572 8500 0    60   BiDi ~ 0
DVDD
Text GLabel 3072 8800 0    60   BiDi ~ 0
AGND
Text GLabel 3072 8500 0    60   BiDi ~ 0
AVDD
Text GLabel 3572 8800 0    60   BiDi ~ 0
AGND
Text GLabel 3572 8500 0    60   BiDi ~ 0
AVDD
$Comp
L TMS1mm U10
U 1 1 59697F52
P 3072 11000
F 0 "U10" H 3022 12400 60  0000 C CNN
F 1 "TMS1mm" H 3072 9700 60  0000 C CNN
F 2 "Topmetal:TMS1mmAout1or2" H 3002 11000 50  0000 C CNN
F 3 "" H 3072 11000 50  0000 C CNN
	1    3072 11000
	1    0    0    -1  
$EndComp
Text GLabel 2222 9850 0    60   BiDi ~ 0
Gring
Text GLabel 2222 9950 0    60   BiDi ~ 0
AVDD
Text GLabel 2222 10050 0    60   BiDi ~ 0
AGND
Text GLabel 2222 10150 0    60   BiDi ~ 0
GND_NMOSI
Text GLabel 2222 10250 0    60   BiDi ~ 0
CSA_VREF_10
Text GLabel 2222 10350 0    60   BiDi ~ 0
CSA_VREF_10
Text GLabel 2222 10450 0    60   BiDi ~ 0
CSA_VDIS_10
Text GLabel 2222 10550 0    60   BiDi ~ 0
CSA_VDIS_10
Text GLabel 2222 10650 0    60   BiDi ~ 0
VCASN_10
Text GLabel 2222 10750 0    60   BiDi ~ 0
VCASN_10
Text GLabel 2222 10850 0    60   BiDi ~ 0
VCASP_10
Text GLabel 2222 10950 0    60   BiDi ~ 0
VCASP_10
Text GLabel 2222 11050 0    60   BiDi ~ 0
DVDD
Text GLabel 2222 11150 0    60   BiDi ~ 0
DGND
Text GLabel 2222 11250 0    60   BiDi ~ 0
LVDS_VREF
Text GLabel 2222 11350 0    60   BiDi ~ 0
RESET
Text GLabel 2222 11450 0    60   BiDi ~ 0
SDM_OUT2_10_P
Text GLabel 2222 11550 0    60   BiDi ~ 0
SDM_OUT2_10_N
Text GLabel 2222 11650 0    60   BiDi ~ 0
SDM_OUT1_10_N
Text GLabel 2222 11750 0    60   BiDi ~ 0
SDM_OUT1_10_P
Text GLabel 2222 11850 0    60   BiDi ~ 0
CLK_-2_N
Text GLabel 2222 11950 0    60   BiDi ~ 0
CLK_-2_P
Text GLabel 2222 12050 0    60   BiDi ~ 0
SCK_-2
Text GLabel 2222 12150 0    60   BiDi ~ 0
SDO_11
Text GLabel 3922 12250 2    60   BiDi ~ 0
SDO_10
Text GLabel 3922 12150 2    60   BiDi ~ 0
SDM_VDD_Shield
Text GLabel 3922 12050 2    60   BiDi ~ 0
AVDD
Text GLabel 3922 11950 2    60   BiDi ~ 0
AGND
Text GLabel 3922 11850 2    60   BiDi ~ 0
SDM_BIAS_10
Text GLabel 3922 11750 2    60   BiDi ~ 0
SDM_BIAS_10
Text GLabel 3922 11650 2    60   BiDi ~ 0
GND_VREF
Text GLabel 3922 11550 2    60   BiDi ~ 0
Ref3
Text GLabel 3922 11450 2    60   BiDi ~ 0
Ref1
Text GLabel 3922 11350 2    60   BiDi ~ 0
Ref2
Text GLabel 3922 11250 2    60   BiDi ~ 0
SDM_testIN
NoConn ~ 3922 11150
NoConn ~ 3922 11050
NoConn ~ 3922 10950
NoConn ~ 3922 10850
Text GLabel 3922 10750 2    60   BiDi ~ 0
DAC_BufferX2_VREF
Text GLabel 3922 10650 2    60   BiDi ~ 0
CSA_VBIASN_10
Text GLabel 3922 10550 2    60   BiDi ~ 0
CSA_VBIASN_10
Text GLabel 3922 10450 2    60   BiDi ~ 0
CSA_VBIASP_10
Text GLabel 3922 10350 2    60   BiDi ~ 0
CSA_VBIASP_10
NoConn ~ 3922 10250
Text GLabel 3922 10150 2    60   BiDi ~ 0
AOUT1_CSA_10
Text GLabel 3922 10050 2    60   BiDi ~ 0
AGND
Text GLabel 3922 9950 2    60   BiDi ~ 0
AVDD
Text GLabel 3922 9850 2    60   BiDi ~ 0
AGND
Text GLabel 3922 9750 2    60   BiDi ~ 0
AVDD
$Comp
L C C100
U 1 1 59697F53
P 2572 12650
F 0 "C100" H 2572 12730 50  0000 L CNN
F 1 "1u" H 2572 12550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 2502 12650 50  0001 C CNN
F 3 "" H 2572 12650 50  0001 C CNN
	1    2572 12650
	1    0    0    -1  
$EndComp
$Comp
L C C101
U 1 1 59697F54
P 3072 12650
F 0 "C101" H 3072 12730 50  0000 L CNN
F 1 "1u" H 3072 12550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 3002 12650 50  0001 C CNN
F 3 "" H 3072 12650 50  0001 C CNN
	1    3072 12650
	1    0    0    -1  
$EndComp
$Comp
L C C102
U 1 1 59697F55
P 3572 12650
F 0 "C102" H 3572 12730 50  0000 L CNN
F 1 "1u" H 3572 12550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 3502 12650 50  0001 C CNN
F 3 "" H 3572 12650 50  0001 C CNN
	1    3572 12650
	1    0    0    -1  
$EndComp
Text GLabel 2572 12800 0    60   BiDi ~ 0
DGND
Text GLabel 2572 12500 0    60   BiDi ~ 0
DVDD
Text GLabel 3072 12800 0    60   BiDi ~ 0
AGND
Text GLabel 3072 12500 0    60   BiDi ~ 0
AVDD
Text GLabel 3572 12800 0    60   BiDi ~ 0
AGND
Text GLabel 3572 12500 0    60   BiDi ~ 0
AVDD
$Comp
L TMS1mm U11
U 1 1 59697F56
P 3072 15000
F 0 "U11" H 3022 16400 60  0000 C CNN
F 1 "TMS1mm" H 3072 13700 60  0000 C CNN
F 2 "Topmetal:TMS1mmAout1or2" H 3002 15000 50  0000 C CNN
F 3 "" H 3072 15000 50  0000 C CNN
	1    3072 15000
	1    0    0    -1  
$EndComp
Text GLabel 2222 13850 0    60   BiDi ~ 0
Gring
Text GLabel 2222 13950 0    60   BiDi ~ 0
AVDD
Text GLabel 2222 14050 0    60   BiDi ~ 0
AGND
Text GLabel 2222 14150 0    60   BiDi ~ 0
GND_NMOSI
Text GLabel 2222 14250 0    60   BiDi ~ 0
CSA_VREF_11
Text GLabel 2222 14350 0    60   BiDi ~ 0
CSA_VREF_11
Text GLabel 2222 14450 0    60   BiDi ~ 0
CSA_VDIS_11
Text GLabel 2222 14550 0    60   BiDi ~ 0
CSA_VDIS_11
Text GLabel 2222 14650 0    60   BiDi ~ 0
VCASN_11
Text GLabel 2222 14750 0    60   BiDi ~ 0
VCASN_11
Text GLabel 2222 14850 0    60   BiDi ~ 0
VCASP_11
Text GLabel 2222 14950 0    60   BiDi ~ 0
VCASP_11
Text GLabel 2222 15050 0    60   BiDi ~ 0
DVDD
Text GLabel 2222 15150 0    60   BiDi ~ 0
DGND
Text GLabel 2222 15250 0    60   BiDi ~ 0
LVDS_VREF
Text GLabel 2222 15350 0    60   BiDi ~ 0
RESET
Text GLabel 2222 15450 0    60   BiDi ~ 0
SDM_OUT2_11_P
Text GLabel 2222 15550 0    60   BiDi ~ 0
SDM_OUT2_11_N
Text GLabel 2222 15650 0    60   BiDi ~ 0
SDM_OUT1_11_N
Text GLabel 2222 15750 0    60   BiDi ~ 0
SDM_OUT1_11_P
Text GLabel 2222 15850 0    60   BiDi ~ 0
CLK_-2_N
Text GLabel 2222 15950 0    60   BiDi ~ 0
CLK_-2_P
Text GLabel 2222 16050 0    60   BiDi ~ 0
SCK_-2
Text GLabel 2222 16150 0    60   BiDi ~ 0
SDO_26
Text GLabel 3922 16250 2    60   BiDi ~ 0
SDO_11
Text GLabel 3922 16150 2    60   BiDi ~ 0
SDM_VDD_Shield
Text GLabel 3922 16050 2    60   BiDi ~ 0
AVDD
Text GLabel 3922 15950 2    60   BiDi ~ 0
AGND
Text GLabel 3922 15850 2    60   BiDi ~ 0
SDM_BIAS_11
Text GLabel 3922 15750 2    60   BiDi ~ 0
SDM_BIAS_11
Text GLabel 3922 15650 2    60   BiDi ~ 0
GND_VREF
Text GLabel 3922 15550 2    60   BiDi ~ 0
Ref3
Text GLabel 3922 15450 2    60   BiDi ~ 0
Ref1
Text GLabel 3922 15350 2    60   BiDi ~ 0
Ref2
Text GLabel 3922 15250 2    60   BiDi ~ 0
SDM_testIN
NoConn ~ 3922 15150
NoConn ~ 3922 15050
NoConn ~ 3922 14950
NoConn ~ 3922 14850
Text GLabel 3922 14750 2    60   BiDi ~ 0
DAC_BufferX2_VREF
Text GLabel 3922 14650 2    60   BiDi ~ 0
CSA_VBIASN_11
Text GLabel 3922 14550 2    60   BiDi ~ 0
CSA_VBIASN_11
Text GLabel 3922 14450 2    60   BiDi ~ 0
CSA_VBIASP_11
Text GLabel 3922 14350 2    60   BiDi ~ 0
CSA_VBIASP_11
NoConn ~ 3922 14250
Text GLabel 3922 14150 2    60   BiDi ~ 0
AOUT1_CSA_11
Text GLabel 3922 14050 2    60   BiDi ~ 0
AGND
Text GLabel 3922 13950 2    60   BiDi ~ 0
AVDD
Text GLabel 3922 13850 2    60   BiDi ~ 0
AGND
Text GLabel 3922 13750 2    60   BiDi ~ 0
AVDD
$Comp
L C C110
U 1 1 59697F57
P 2572 16650
F 0 "C110" H 2572 16730 50  0000 L CNN
F 1 "1u" H 2572 16550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 2502 16650 50  0001 C CNN
F 3 "" H 2572 16650 50  0001 C CNN
	1    2572 16650
	1    0    0    -1  
$EndComp
$Comp
L C C111
U 1 1 59697F58
P 3072 16650
F 0 "C111" H 3072 16730 50  0000 L CNN
F 1 "1u" H 3072 16550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 3002 16650 50  0001 C CNN
F 3 "" H 3072 16650 50  0001 C CNN
	1    3072 16650
	1    0    0    -1  
$EndComp
$Comp
L C C112
U 1 1 59697F59
P 3572 16650
F 0 "C112" H 3572 16730 50  0000 L CNN
F 1 "1u" H 3572 16550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 3502 16650 50  0001 C CNN
F 3 "" H 3572 16650 50  0001 C CNN
	1    3572 16650
	1    0    0    -1  
$EndComp
Text GLabel 2572 16800 0    60   BiDi ~ 0
DGND
Text GLabel 2572 16500 0    60   BiDi ~ 0
DVDD
Text GLabel 3072 16800 0    60   BiDi ~ 0
AGND
Text GLabel 3072 16500 0    60   BiDi ~ 0
AVDD
Text GLabel 3572 16800 0    60   BiDi ~ 0
AGND
Text GLabel 3572 16500 0    60   BiDi ~ 0
AVDD
$Comp
L TMS1mm U12
U 1 1 59697F5A
P 6536 17000
F 0 "U12" H 6486 18400 60  0000 C CNN
F 1 "TMS1mm" H 6536 15700 60  0000 C CNN
F 2 "Topmetal:TMS1mmAout1or2" H 6466 17000 50  0000 C CNN
F 3 "" H 6536 17000 50  0000 C CNN
	1    6536 17000
	1    0    0    -1  
$EndComp
Text GLabel 5686 15850 0    60   BiDi ~ 0
Gring
Text GLabel 5686 15950 0    60   BiDi ~ 0
AVDD
Text GLabel 5686 16050 0    60   BiDi ~ 0
AGND
Text GLabel 5686 16150 0    60   BiDi ~ 0
GND_NMOSI
Text GLabel 5686 16250 0    60   BiDi ~ 0
CSA_VREF_12
Text GLabel 5686 16350 0    60   BiDi ~ 0
CSA_VREF_12
Text GLabel 5686 16450 0    60   BiDi ~ 0
CSA_VDIS_12
Text GLabel 5686 16550 0    60   BiDi ~ 0
CSA_VDIS_12
Text GLabel 5686 16650 0    60   BiDi ~ 0
VCASN_12
Text GLabel 5686 16750 0    60   BiDi ~ 0
VCASN_12
Text GLabel 5686 16850 0    60   BiDi ~ 0
VCASP_12
Text GLabel 5686 16950 0    60   BiDi ~ 0
VCASP_12
Text GLabel 5686 17050 0    60   BiDi ~ 0
DVDD
Text GLabel 5686 17150 0    60   BiDi ~ 0
DGND
Text GLabel 5686 17250 0    60   BiDi ~ 0
LVDS_VREF
Text GLabel 5686 17350 0    60   BiDi ~ 0
RESET
Text GLabel 5686 17450 0    60   BiDi ~ 0
SDM_OUT2_12_P
Text GLabel 5686 17550 0    60   BiDi ~ 0
SDM_OUT2_12_N
Text GLabel 5686 17650 0    60   BiDi ~ 0
SDM_OUT1_12_N
Text GLabel 5686 17750 0    60   BiDi ~ 0
SDM_OUT1_12_P
Text GLabel 5686 17850 0    60   BiDi ~ 0
CLK_-1_N
Text GLabel 5686 17950 0    60   BiDi ~ 0
CLK_-1_P
Text GLabel 5686 18050 0    60   BiDi ~ 0
SCK_-1
Text GLabel 5686 18150 0    60   BiDi ~ 0
SDO_27
Text GLabel 7386 18250 2    60   BiDi ~ 0
SDO_12
Text GLabel 7386 18150 2    60   BiDi ~ 0
SDM_VDD_Shield
Text GLabel 7386 18050 2    60   BiDi ~ 0
AVDD
Text GLabel 7386 17950 2    60   BiDi ~ 0
AGND
Text GLabel 7386 17850 2    60   BiDi ~ 0
SDM_BIAS_12
Text GLabel 7386 17750 2    60   BiDi ~ 0
SDM_BIAS_12
Text GLabel 7386 17650 2    60   BiDi ~ 0
GND_VREF
Text GLabel 7386 17550 2    60   BiDi ~ 0
Ref3
Text GLabel 7386 17450 2    60   BiDi ~ 0
Ref1
Text GLabel 7386 17350 2    60   BiDi ~ 0
Ref2
Text GLabel 7386 17250 2    60   BiDi ~ 0
SDM_testIN
NoConn ~ 7386 17150
NoConn ~ 7386 17050
NoConn ~ 7386 16950
NoConn ~ 7386 16850
Text GLabel 7386 16750 2    60   BiDi ~ 0
DAC_BufferX2_VREF
Text GLabel 7386 16650 2    60   BiDi ~ 0
CSA_VBIASN_12
Text GLabel 7386 16550 2    60   BiDi ~ 0
CSA_VBIASN_12
Text GLabel 7386 16450 2    60   BiDi ~ 0
CSA_VBIASP_12
Text GLabel 7386 16350 2    60   BiDi ~ 0
CSA_VBIASP_12
NoConn ~ 7386 16250
Text GLabel 7386 16150 2    60   BiDi ~ 0
AOUT1_CSA_12
Text GLabel 7386 16050 2    60   BiDi ~ 0
AGND
Text GLabel 7386 15950 2    60   BiDi ~ 0
AVDD
Text GLabel 7386 15850 2    60   BiDi ~ 0
AGND
Text GLabel 7386 15750 2    60   BiDi ~ 0
AVDD
$Comp
L C C120
U 1 1 59697F5B
P 6036 18650
F 0 "C120" H 6036 18730 50  0000 L CNN
F 1 "1u" H 6036 18550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 5966 18650 50  0001 C CNN
F 3 "" H 6036 18650 50  0001 C CNN
	1    6036 18650
	1    0    0    -1  
$EndComp
$Comp
L C C121
U 1 1 59697F5C
P 6536 18650
F 0 "C121" H 6536 18730 50  0000 L CNN
F 1 "1u" H 6536 18550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 6466 18650 50  0001 C CNN
F 3 "" H 6536 18650 50  0001 C CNN
	1    6536 18650
	1    0    0    -1  
$EndComp
$Comp
L C C122
U 1 1 59697F5D
P 7036 18650
F 0 "C122" H 7036 18730 50  0000 L CNN
F 1 "1u" H 7036 18550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 6966 18650 50  0001 C CNN
F 3 "" H 7036 18650 50  0001 C CNN
	1    7036 18650
	1    0    0    -1  
$EndComp
Text GLabel 6036 18800 0    60   BiDi ~ 0
DGND
Text GLabel 6036 18500 0    60   BiDi ~ 0
DVDD
Text GLabel 6536 18800 0    60   BiDi ~ 0
AGND
Text GLabel 6536 18500 0    60   BiDi ~ 0
AVDD
Text GLabel 7036 18800 0    60   BiDi ~ 0
AGND
Text GLabel 7036 18500 0    60   BiDi ~ 0
AVDD
$Comp
L TMS1mm U13
U 1 1 59697F5E
P 10000 19000
F 0 "U13" H 9950 20400 60  0000 C CNN
F 1 "TMS1mm" H 10000 17700 60  0000 C CNN
F 2 "Topmetal:TMS1mmAout1or2" H 9930 19000 50  0000 C CNN
F 3 "" H 10000 19000 50  0000 C CNN
	1    10000 19000
	1    0    0    -1  
$EndComp
Text GLabel 9150 17850 0    60   BiDi ~ 0
Gring
Text GLabel 9150 17950 0    60   BiDi ~ 0
AVDD
Text GLabel 9150 18050 0    60   BiDi ~ 0
AGND
Text GLabel 9150 18150 0    60   BiDi ~ 0
GND_NMOSI
Text GLabel 9150 18250 0    60   BiDi ~ 0
CSA_VREF_13
Text GLabel 9150 18350 0    60   BiDi ~ 0
CSA_VREF_13
Text GLabel 9150 18450 0    60   BiDi ~ 0
CSA_VDIS_13
Text GLabel 9150 18550 0    60   BiDi ~ 0
CSA_VDIS_13
Text GLabel 9150 18650 0    60   BiDi ~ 0
VCASN_13
Text GLabel 9150 18750 0    60   BiDi ~ 0
VCASN_13
Text GLabel 9150 18850 0    60   BiDi ~ 0
VCASP_13
Text GLabel 9150 18950 0    60   BiDi ~ 0
VCASP_13
Text GLabel 9150 19050 0    60   BiDi ~ 0
DVDD
Text GLabel 9150 19150 0    60   BiDi ~ 0
DGND
Text GLabel 9150 19250 0    60   BiDi ~ 0
LVDS_VREF
Text GLabel 9150 19350 0    60   BiDi ~ 0
RESET
Text GLabel 9150 19450 0    60   BiDi ~ 0
SDM_OUT2_13_P
Text GLabel 9150 19550 0    60   BiDi ~ 0
SDM_OUT2_13_N
Text GLabel 9150 19650 0    60   BiDi ~ 0
SDM_OUT1_13_N
Text GLabel 9150 19750 0    60   BiDi ~ 0
SDM_OUT1_13_P
Text GLabel 9150 19850 0    60   BiDi ~ 0
CLK_0_N
Text GLabel 9150 19950 0    60   BiDi ~ 0
CLK_0_P
Text GLabel 9150 20050 0    60   BiDi ~ 0
SCK_0
Text GLabel 9150 20150 0    60   BiDi ~ 0
SDO_28
Text GLabel 10850 20250 2    60   BiDi ~ 0
SDO_13
Text GLabel 10850 20150 2    60   BiDi ~ 0
SDM_VDD_Shield
Text GLabel 10850 20050 2    60   BiDi ~ 0
AVDD
Text GLabel 10850 19950 2    60   BiDi ~ 0
AGND
Text GLabel 10850 19850 2    60   BiDi ~ 0
SDM_BIAS_13
Text GLabel 10850 19750 2    60   BiDi ~ 0
SDM_BIAS_13
Text GLabel 10850 19650 2    60   BiDi ~ 0
GND_VREF
Text GLabel 10850 19550 2    60   BiDi ~ 0
Ref3
Text GLabel 10850 19450 2    60   BiDi ~ 0
Ref1
Text GLabel 10850 19350 2    60   BiDi ~ 0
Ref2
Text GLabel 10850 19250 2    60   BiDi ~ 0
SDM_testIN
NoConn ~ 10850 19150
NoConn ~ 10850 19050
NoConn ~ 10850 18950
NoConn ~ 10850 18850
Text GLabel 10850 18750 2    60   BiDi ~ 0
DAC_BufferX2_VREF
Text GLabel 10850 18650 2    60   BiDi ~ 0
CSA_VBIASN_13
Text GLabel 10850 18550 2    60   BiDi ~ 0
CSA_VBIASN_13
Text GLabel 10850 18450 2    60   BiDi ~ 0
CSA_VBIASP_13
Text GLabel 10850 18350 2    60   BiDi ~ 0
CSA_VBIASP_13
NoConn ~ 10850 18250
Text GLabel 10850 18150 2    60   BiDi ~ 0
AOUT1_CSA_13
Text GLabel 10850 18050 2    60   BiDi ~ 0
AGND
Text GLabel 10850 17950 2    60   BiDi ~ 0
AVDD
Text GLabel 10850 17850 2    60   BiDi ~ 0
AGND
Text GLabel 10850 17750 2    60   BiDi ~ 0
AVDD
$Comp
L C C130
U 1 1 59697F5F
P 9500 20650
F 0 "C130" H 9500 20730 50  0000 L CNN
F 1 "1u" H 9500 20550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 9430 20650 50  0001 C CNN
F 3 "" H 9500 20650 50  0001 C CNN
	1    9500 20650
	1    0    0    -1  
$EndComp
$Comp
L C C131
U 1 1 59697F60
P 10000 20650
F 0 "C131" H 10000 20730 50  0000 L CNN
F 1 "1u" H 10000 20550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 9930 20650 50  0001 C CNN
F 3 "" H 10000 20650 50  0001 C CNN
	1    10000 20650
	1    0    0    -1  
$EndComp
$Comp
L C C132
U 1 1 59697F61
P 10500 20650
F 0 "C132" H 10500 20730 50  0000 L CNN
F 1 "1u" H 10500 20550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 10430 20650 50  0001 C CNN
F 3 "" H 10500 20650 50  0001 C CNN
	1    10500 20650
	1    0    0    -1  
$EndComp
Text GLabel 9500 20800 0    60   BiDi ~ 0
DGND
Text GLabel 9500 20500 0    60   BiDi ~ 0
DVDD
Text GLabel 10000 20800 0    60   BiDi ~ 0
AGND
Text GLabel 10000 20500 0    60   BiDi ~ 0
AVDD
Text GLabel 10500 20800 0    60   BiDi ~ 0
AGND
Text GLabel 10500 20500 0    60   BiDi ~ 0
AVDD
$Comp
L TMS1mm U14
U 1 1 59697F62
P 13464 17000
F 0 "U14" H 13414 18400 60  0000 C CNN
F 1 "TMS1mm" H 13464 15700 60  0000 C CNN
F 2 "Topmetal:TMS1mmAout1or2" H 13394 17000 50  0000 C CNN
F 3 "" H 13464 17000 50  0000 C CNN
	1    13464 17000
	1    0    0    -1  
$EndComp
Text GLabel 12614 15850 0    60   BiDi ~ 0
Gring
Text GLabel 12614 15950 0    60   BiDi ~ 0
AVDD
Text GLabel 12614 16050 0    60   BiDi ~ 0
AGND
Text GLabel 12614 16150 0    60   BiDi ~ 0
GND_NMOSI
Text GLabel 12614 16250 0    60   BiDi ~ 0
CSA_VREF_14
Text GLabel 12614 16350 0    60   BiDi ~ 0
CSA_VREF_14
Text GLabel 12614 16450 0    60   BiDi ~ 0
CSA_VDIS_14
Text GLabel 12614 16550 0    60   BiDi ~ 0
CSA_VDIS_14
Text GLabel 12614 16650 0    60   BiDi ~ 0
VCASN_14
Text GLabel 12614 16750 0    60   BiDi ~ 0
VCASN_14
Text GLabel 12614 16850 0    60   BiDi ~ 0
VCASP_14
Text GLabel 12614 16950 0    60   BiDi ~ 0
VCASP_14
Text GLabel 12614 17050 0    60   BiDi ~ 0
DVDD
Text GLabel 12614 17150 0    60   BiDi ~ 0
DGND
Text GLabel 12614 17250 0    60   BiDi ~ 0
LVDS_VREF
Text GLabel 12614 17350 0    60   BiDi ~ 0
RESET
Text GLabel 12614 17450 0    60   BiDi ~ 0
SDM_OUT2_14_P
Text GLabel 12614 17550 0    60   BiDi ~ 0
SDM_OUT2_14_N
Text GLabel 12614 17650 0    60   BiDi ~ 0
SDM_OUT1_14_N
Text GLabel 12614 17750 0    60   BiDi ~ 0
SDM_OUT1_14_P
Text GLabel 12614 17850 0    60   BiDi ~ 0
CLK_1_N
Text GLabel 12614 17950 0    60   BiDi ~ 0
CLK_1_P
Text GLabel 12614 18050 0    60   BiDi ~ 0
SCK_1
Text GLabel 12614 18150 0    60   BiDi ~ 0
SDO_29
Text GLabel 14314 18250 2    60   BiDi ~ 0
SDO_14
Text GLabel 14314 18150 2    60   BiDi ~ 0
SDM_VDD_Shield
Text GLabel 14314 18050 2    60   BiDi ~ 0
AVDD
Text GLabel 14314 17950 2    60   BiDi ~ 0
AGND
Text GLabel 14314 17850 2    60   BiDi ~ 0
SDM_BIAS_14
Text GLabel 14314 17750 2    60   BiDi ~ 0
SDM_BIAS_14
Text GLabel 14314 17650 2    60   BiDi ~ 0
GND_VREF
Text GLabel 14314 17550 2    60   BiDi ~ 0
Ref3
Text GLabel 14314 17450 2    60   BiDi ~ 0
Ref1
Text GLabel 14314 17350 2    60   BiDi ~ 0
Ref2
Text GLabel 14314 17250 2    60   BiDi ~ 0
SDM_testIN
NoConn ~ 14314 17150
NoConn ~ 14314 17050
NoConn ~ 14314 16950
NoConn ~ 14314 16850
Text GLabel 14314 16750 2    60   BiDi ~ 0
DAC_BufferX2_VREF
Text GLabel 14314 16650 2    60   BiDi ~ 0
CSA_VBIASN_14
Text GLabel 14314 16550 2    60   BiDi ~ 0
CSA_VBIASN_14
Text GLabel 14314 16450 2    60   BiDi ~ 0
CSA_VBIASP_14
Text GLabel 14314 16350 2    60   BiDi ~ 0
CSA_VBIASP_14
NoConn ~ 14314 16250
Text GLabel 14314 16150 2    60   BiDi ~ 0
AOUT1_CSA_14
Text GLabel 14314 16050 2    60   BiDi ~ 0
AGND
Text GLabel 14314 15950 2    60   BiDi ~ 0
AVDD
Text GLabel 14314 15850 2    60   BiDi ~ 0
AGND
Text GLabel 14314 15750 2    60   BiDi ~ 0
AVDD
$Comp
L C C140
U 1 1 59697F63
P 12964 18650
F 0 "C140" H 12964 18730 50  0000 L CNN
F 1 "1u" H 12964 18550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 12894 18650 50  0001 C CNN
F 3 "" H 12964 18650 50  0001 C CNN
	1    12964 18650
	1    0    0    -1  
$EndComp
$Comp
L C C141
U 1 1 59697F64
P 13464 18650
F 0 "C141" H 13464 18730 50  0000 L CNN
F 1 "1u" H 13464 18550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 13394 18650 50  0001 C CNN
F 3 "" H 13464 18650 50  0001 C CNN
	1    13464 18650
	1    0    0    -1  
$EndComp
$Comp
L C C142
U 1 1 59697F65
P 13964 18650
F 0 "C142" H 13964 18730 50  0000 L CNN
F 1 "1u" H 13964 18550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 13894 18650 50  0001 C CNN
F 3 "" H 13964 18650 50  0001 C CNN
	1    13964 18650
	1    0    0    -1  
$EndComp
Text GLabel 12964 18800 0    60   BiDi ~ 0
DGND
Text GLabel 12964 18500 0    60   BiDi ~ 0
DVDD
Text GLabel 13464 18800 0    60   BiDi ~ 0
AGND
Text GLabel 13464 18500 0    60   BiDi ~ 0
AVDD
Text GLabel 13964 18800 0    60   BiDi ~ 0
AGND
Text GLabel 13964 18500 0    60   BiDi ~ 0
AVDD
$Comp
L TMS1mm U15
U 1 1 59697F66
P 16928 15000
F 0 "U15" H 16878 16400 60  0000 C CNN
F 1 "TMS1mm" H 16928 13700 60  0000 C CNN
F 2 "Topmetal:TMS1mmAout1or2" H 16858 15000 50  0000 C CNN
F 3 "" H 16928 15000 50  0000 C CNN
	1    16928 15000
	1    0    0    -1  
$EndComp
Text GLabel 16078 13850 0    60   BiDi ~ 0
Gring
Text GLabel 16078 13950 0    60   BiDi ~ 0
AVDD
Text GLabel 16078 14050 0    60   BiDi ~ 0
AGND
Text GLabel 16078 14150 0    60   BiDi ~ 0
GND_NMOSI
Text GLabel 16078 14250 0    60   BiDi ~ 0
CSA_VREF_15
Text GLabel 16078 14350 0    60   BiDi ~ 0
CSA_VREF_15
Text GLabel 16078 14450 0    60   BiDi ~ 0
CSA_VDIS_15
Text GLabel 16078 14550 0    60   BiDi ~ 0
CSA_VDIS_15
Text GLabel 16078 14650 0    60   BiDi ~ 0
VCASN_15
Text GLabel 16078 14750 0    60   BiDi ~ 0
VCASN_15
Text GLabel 16078 14850 0    60   BiDi ~ 0
VCASP_15
Text GLabel 16078 14950 0    60   BiDi ~ 0
VCASP_15
Text GLabel 16078 15050 0    60   BiDi ~ 0
DVDD
Text GLabel 16078 15150 0    60   BiDi ~ 0
DGND
Text GLabel 16078 15250 0    60   BiDi ~ 0
LVDS_VREF
Text GLabel 16078 15350 0    60   BiDi ~ 0
RESET
Text GLabel 16078 15450 0    60   BiDi ~ 0
SDM_OUT2_15_P
Text GLabel 16078 15550 0    60   BiDi ~ 0
SDM_OUT2_15_N
Text GLabel 16078 15650 0    60   BiDi ~ 0
SDM_OUT1_15_N
Text GLabel 16078 15750 0    60   BiDi ~ 0
SDM_OUT1_15_P
Text GLabel 16078 15850 0    60   BiDi ~ 0
CLK_2_N
Text GLabel 16078 15950 0    60   BiDi ~ 0
CLK_2_P
Text GLabel 16078 16050 0    60   BiDi ~ 0
SCK_2
Text GLabel 16078 16150 0    60   BiDi ~ 0
SDO_30
Text GLabel 17778 16250 2    60   BiDi ~ 0
SDO_15
Text GLabel 17778 16150 2    60   BiDi ~ 0
SDM_VDD_Shield
Text GLabel 17778 16050 2    60   BiDi ~ 0
AVDD
Text GLabel 17778 15950 2    60   BiDi ~ 0
AGND
Text GLabel 17778 15850 2    60   BiDi ~ 0
SDM_BIAS_15
Text GLabel 17778 15750 2    60   BiDi ~ 0
SDM_BIAS_15
Text GLabel 17778 15650 2    60   BiDi ~ 0
GND_VREF
Text GLabel 17778 15550 2    60   BiDi ~ 0
Ref3
Text GLabel 17778 15450 2    60   BiDi ~ 0
Ref1
Text GLabel 17778 15350 2    60   BiDi ~ 0
Ref2
Text GLabel 17778 15250 2    60   BiDi ~ 0
SDM_testIN
NoConn ~ 17778 15150
NoConn ~ 17778 15050
NoConn ~ 17778 14950
NoConn ~ 17778 14850
Text GLabel 17778 14750 2    60   BiDi ~ 0
DAC_BufferX2_VREF
Text GLabel 17778 14650 2    60   BiDi ~ 0
CSA_VBIASN_15
Text GLabel 17778 14550 2    60   BiDi ~ 0
CSA_VBIASN_15
Text GLabel 17778 14450 2    60   BiDi ~ 0
CSA_VBIASP_15
Text GLabel 17778 14350 2    60   BiDi ~ 0
CSA_VBIASP_15
NoConn ~ 17778 14250
Text GLabel 17778 14150 2    60   BiDi ~ 0
AOUT1_CSA_15
Text GLabel 17778 14050 2    60   BiDi ~ 0
AGND
Text GLabel 17778 13950 2    60   BiDi ~ 0
AVDD
Text GLabel 17778 13850 2    60   BiDi ~ 0
AGND
Text GLabel 17778 13750 2    60   BiDi ~ 0
AVDD
$Comp
L C C150
U 1 1 59697F67
P 16428 16650
F 0 "C150" H 16428 16730 50  0000 L CNN
F 1 "1u" H 16428 16550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 16358 16650 50  0001 C CNN
F 3 "" H 16428 16650 50  0001 C CNN
	1    16428 16650
	1    0    0    -1  
$EndComp
$Comp
L C C151
U 1 1 59697F68
P 16928 16650
F 0 "C151" H 16928 16730 50  0000 L CNN
F 1 "1u" H 16928 16550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 16858 16650 50  0001 C CNN
F 3 "" H 16928 16650 50  0001 C CNN
	1    16928 16650
	1    0    0    -1  
$EndComp
$Comp
L C C152
U 1 1 59697F69
P 17428 16650
F 0 "C152" H 17428 16730 50  0000 L CNN
F 1 "1u" H 17428 16550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 17358 16650 50  0001 C CNN
F 3 "" H 17428 16650 50  0001 C CNN
	1    17428 16650
	1    0    0    -1  
$EndComp
Text GLabel 16428 16800 0    60   BiDi ~ 0
DGND
Text GLabel 16428 16500 0    60   BiDi ~ 0
DVDD
Text GLabel 16928 16800 0    60   BiDi ~ 0
AGND
Text GLabel 16928 16500 0    60   BiDi ~ 0
AVDD
Text GLabel 17428 16800 0    60   BiDi ~ 0
AGND
Text GLabel 17428 16500 0    60   BiDi ~ 0
AVDD
$Comp
L TMS1mm U16
U 1 1 59697F6A
P 16928 11000
F 0 "U16" H 16878 12400 60  0000 C CNN
F 1 "TMS1mm" H 16928 9700 60  0000 C CNN
F 2 "Topmetal:TMS1mmAout1or2" H 16858 11000 50  0000 C CNN
F 3 "" H 16928 11000 50  0000 C CNN
	1    16928 11000
	1    0    0    -1  
$EndComp
Text GLabel 16078 9850 0    60   BiDi ~ 0
Gring
Text GLabel 16078 9950 0    60   BiDi ~ 0
AVDD
Text GLabel 16078 10050 0    60   BiDi ~ 0
AGND
Text GLabel 16078 10150 0    60   BiDi ~ 0
GND_NMOSI
Text GLabel 16078 10250 0    60   BiDi ~ 0
CSA_VREF_16
Text GLabel 16078 10350 0    60   BiDi ~ 0
CSA_VREF_16
Text GLabel 16078 10450 0    60   BiDi ~ 0
CSA_VDIS_16
Text GLabel 16078 10550 0    60   BiDi ~ 0
CSA_VDIS_16
Text GLabel 16078 10650 0    60   BiDi ~ 0
VCASN_16
Text GLabel 16078 10750 0    60   BiDi ~ 0
VCASN_16
Text GLabel 16078 10850 0    60   BiDi ~ 0
VCASP_16
Text GLabel 16078 10950 0    60   BiDi ~ 0
VCASP_16
Text GLabel 16078 11050 0    60   BiDi ~ 0
DVDD
Text GLabel 16078 11150 0    60   BiDi ~ 0
DGND
Text GLabel 16078 11250 0    60   BiDi ~ 0
LVDS_VREF
Text GLabel 16078 11350 0    60   BiDi ~ 0
RESET
Text GLabel 16078 11450 0    60   BiDi ~ 0
SDM_OUT2_16_P
Text GLabel 16078 11550 0    60   BiDi ~ 0
SDM_OUT2_16_N
Text GLabel 16078 11650 0    60   BiDi ~ 0
SDM_OUT1_16_N
Text GLabel 16078 11750 0    60   BiDi ~ 0
SDM_OUT1_16_P
Text GLabel 16078 11850 0    60   BiDi ~ 0
CLK_2_N
Text GLabel 16078 11950 0    60   BiDi ~ 0
CLK_2_P
Text GLabel 16078 12050 0    60   BiDi ~ 0
SCK_2
Text GLabel 16078 12150 0    60   BiDi ~ 0
SDO_15
Text GLabel 17778 12250 2    60   BiDi ~ 0
SDO_16
Text GLabel 17778 12150 2    60   BiDi ~ 0
SDM_VDD_Shield
Text GLabel 17778 12050 2    60   BiDi ~ 0
AVDD
Text GLabel 17778 11950 2    60   BiDi ~ 0
AGND
Text GLabel 17778 11850 2    60   BiDi ~ 0
SDM_BIAS_16
Text GLabel 17778 11750 2    60   BiDi ~ 0
SDM_BIAS_16
Text GLabel 17778 11650 2    60   BiDi ~ 0
GND_VREF
Text GLabel 17778 11550 2    60   BiDi ~ 0
Ref3
Text GLabel 17778 11450 2    60   BiDi ~ 0
Ref1
Text GLabel 17778 11350 2    60   BiDi ~ 0
Ref2
Text GLabel 17778 11250 2    60   BiDi ~ 0
SDM_testIN
NoConn ~ 17778 11150
NoConn ~ 17778 11050
NoConn ~ 17778 10950
NoConn ~ 17778 10850
Text GLabel 17778 10750 2    60   BiDi ~ 0
DAC_BufferX2_VREF
Text GLabel 17778 10650 2    60   BiDi ~ 0
CSA_VBIASN_16
Text GLabel 17778 10550 2    60   BiDi ~ 0
CSA_VBIASN_16
Text GLabel 17778 10450 2    60   BiDi ~ 0
CSA_VBIASP_16
Text GLabel 17778 10350 2    60   BiDi ~ 0
CSA_VBIASP_16
NoConn ~ 17778 10250
Text GLabel 17778 10150 2    60   BiDi ~ 0
AOUT1_CSA_16
Text GLabel 17778 10050 2    60   BiDi ~ 0
AGND
Text GLabel 17778 9950 2    60   BiDi ~ 0
AVDD
Text GLabel 17778 9850 2    60   BiDi ~ 0
AGND
Text GLabel 17778 9750 2    60   BiDi ~ 0
AVDD
$Comp
L C C160
U 1 1 59697F6B
P 16428 12650
F 0 "C160" H 16428 12730 50  0000 L CNN
F 1 "1u" H 16428 12550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 16358 12650 50  0001 C CNN
F 3 "" H 16428 12650 50  0001 C CNN
	1    16428 12650
	1    0    0    -1  
$EndComp
$Comp
L C C161
U 1 1 59697F6C
P 16928 12650
F 0 "C161" H 16928 12730 50  0000 L CNN
F 1 "1u" H 16928 12550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 16858 12650 50  0001 C CNN
F 3 "" H 16928 12650 50  0001 C CNN
	1    16928 12650
	1    0    0    -1  
$EndComp
$Comp
L C C162
U 1 1 59697F6D
P 17428 12650
F 0 "C162" H 17428 12730 50  0000 L CNN
F 1 "1u" H 17428 12550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 17358 12650 50  0001 C CNN
F 3 "" H 17428 12650 50  0001 C CNN
	1    17428 12650
	1    0    0    -1  
$EndComp
Text GLabel 16428 12800 0    60   BiDi ~ 0
DGND
Text GLabel 16428 12500 0    60   BiDi ~ 0
DVDD
Text GLabel 16928 12800 0    60   BiDi ~ 0
AGND
Text GLabel 16928 12500 0    60   BiDi ~ 0
AVDD
Text GLabel 17428 12800 0    60   BiDi ~ 0
AGND
Text GLabel 17428 12500 0    60   BiDi ~ 0
AVDD
$Comp
L TMS1mm U17
U 1 1 59697F6E
P 16928 7000
F 0 "U17" H 16878 8400 60  0000 C CNN
F 1 "TMS1mm" H 16928 5700 60  0000 C CNN
F 2 "Topmetal:TMS1mmAout1or2" H 16858 7000 50  0000 C CNN
F 3 "" H 16928 7000 50  0000 C CNN
	1    16928 7000
	1    0    0    -1  
$EndComp
Text GLabel 16078 5850 0    60   BiDi ~ 0
Gring
Text GLabel 16078 5950 0    60   BiDi ~ 0
AVDD
Text GLabel 16078 6050 0    60   BiDi ~ 0
AGND
Text GLabel 16078 6150 0    60   BiDi ~ 0
GND_NMOSI
Text GLabel 16078 6250 0    60   BiDi ~ 0
CSA_VREF_17
Text GLabel 16078 6350 0    60   BiDi ~ 0
CSA_VREF_17
Text GLabel 16078 6450 0    60   BiDi ~ 0
CSA_VDIS_17
Text GLabel 16078 6550 0    60   BiDi ~ 0
CSA_VDIS_17
Text GLabel 16078 6650 0    60   BiDi ~ 0
VCASN_17
Text GLabel 16078 6750 0    60   BiDi ~ 0
VCASN_17
Text GLabel 16078 6850 0    60   BiDi ~ 0
VCASP_17
Text GLabel 16078 6950 0    60   BiDi ~ 0
VCASP_17
Text GLabel 16078 7050 0    60   BiDi ~ 0
DVDD
Text GLabel 16078 7150 0    60   BiDi ~ 0
DGND
Text GLabel 16078 7250 0    60   BiDi ~ 0
LVDS_VREF
Text GLabel 16078 7350 0    60   BiDi ~ 0
RESET
Text GLabel 16078 7450 0    60   BiDi ~ 0
SDM_OUT2_17_P
Text GLabel 16078 7550 0    60   BiDi ~ 0
SDM_OUT2_17_N
Text GLabel 16078 7650 0    60   BiDi ~ 0
SDM_OUT1_17_N
Text GLabel 16078 7750 0    60   BiDi ~ 0
SDM_OUT1_17_P
Text GLabel 16078 7850 0    60   BiDi ~ 0
CLK_2_N
Text GLabel 16078 7950 0    60   BiDi ~ 0
CLK_2_P
Text GLabel 16078 8050 0    60   BiDi ~ 0
SCK_2
Text GLabel 16078 8150 0    60   BiDi ~ 0
SDO_16
Text GLabel 17778 8250 2    60   BiDi ~ 0
SDO_17
Text GLabel 17778 8150 2    60   BiDi ~ 0
SDM_VDD_Shield
Text GLabel 17778 8050 2    60   BiDi ~ 0
AVDD
Text GLabel 17778 7950 2    60   BiDi ~ 0
AGND
Text GLabel 17778 7850 2    60   BiDi ~ 0
SDM_BIAS_17
Text GLabel 17778 7750 2    60   BiDi ~ 0
SDM_BIAS_17
Text GLabel 17778 7650 2    60   BiDi ~ 0
GND_VREF
Text GLabel 17778 7550 2    60   BiDi ~ 0
Ref3
Text GLabel 17778 7450 2    60   BiDi ~ 0
Ref1
Text GLabel 17778 7350 2    60   BiDi ~ 0
Ref2
Text GLabel 17778 7250 2    60   BiDi ~ 0
SDM_testIN
NoConn ~ 17778 7150
NoConn ~ 17778 7050
NoConn ~ 17778 6950
NoConn ~ 17778 6850
Text GLabel 17778 6750 2    60   BiDi ~ 0
DAC_BufferX2_VREF
Text GLabel 17778 6650 2    60   BiDi ~ 0
CSA_VBIASN_17
Text GLabel 17778 6550 2    60   BiDi ~ 0
CSA_VBIASN_17
Text GLabel 17778 6450 2    60   BiDi ~ 0
CSA_VBIASP_17
Text GLabel 17778 6350 2    60   BiDi ~ 0
CSA_VBIASP_17
NoConn ~ 17778 6250
Text GLabel 17778 6150 2    60   BiDi ~ 0
AOUT1_CSA_17
Text GLabel 17778 6050 2    60   BiDi ~ 0
AGND
Text GLabel 17778 5950 2    60   BiDi ~ 0
AVDD
Text GLabel 17778 5850 2    60   BiDi ~ 0
AGND
Text GLabel 17778 5750 2    60   BiDi ~ 0
AVDD
$Comp
L C C170
U 1 1 59697F6F
P 16428 8650
F 0 "C170" H 16428 8730 50  0000 L CNN
F 1 "1u" H 16428 8550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 16358 8650 50  0001 C CNN
F 3 "" H 16428 8650 50  0001 C CNN
	1    16428 8650
	1    0    0    -1  
$EndComp
$Comp
L C C171
U 1 1 59697F70
P 16928 8650
F 0 "C171" H 16928 8730 50  0000 L CNN
F 1 "1u" H 16928 8550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 16858 8650 50  0001 C CNN
F 3 "" H 16928 8650 50  0001 C CNN
	1    16928 8650
	1    0    0    -1  
$EndComp
$Comp
L C C172
U 1 1 59697F71
P 17428 8650
F 0 "C172" H 17428 8730 50  0000 L CNN
F 1 "1u" H 17428 8550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 17358 8650 50  0001 C CNN
F 3 "" H 17428 8650 50  0001 C CNN
	1    17428 8650
	1    0    0    -1  
$EndComp
Text GLabel 16428 8800 0    60   BiDi ~ 0
DGND
Text GLabel 16428 8500 0    60   BiDi ~ 0
DVDD
Text GLabel 16928 8800 0    60   BiDi ~ 0
AGND
Text GLabel 16928 8500 0    60   BiDi ~ 0
AVDD
Text GLabel 17428 8800 0    60   BiDi ~ 0
AGND
Text GLabel 17428 8500 0    60   BiDi ~ 0
AVDD
$Comp
L TMS1mm U18
U 1 1 59697F72
P 13464 5000
F 0 "U18" H 13414 6400 60  0000 C CNN
F 1 "TMS1mm" H 13464 3700 60  0000 C CNN
F 2 "Topmetal:TMS1mmAout1or2" H 13394 5000 50  0000 C CNN
F 3 "" H 13464 5000 50  0000 C CNN
	1    13464 5000
	1    0    0    -1  
$EndComp
Text GLabel 12614 3850 0    60   BiDi ~ 0
Gring
Text GLabel 12614 3950 0    60   BiDi ~ 0
AVDD
Text GLabel 12614 4050 0    60   BiDi ~ 0
AGND
Text GLabel 12614 4150 0    60   BiDi ~ 0
GND_NMOSI
Text GLabel 12614 4250 0    60   BiDi ~ 0
CSA_VREF_18
Text GLabel 12614 4350 0    60   BiDi ~ 0
CSA_VREF_18
Text GLabel 12614 4450 0    60   BiDi ~ 0
CSA_VDIS_18
Text GLabel 12614 4550 0    60   BiDi ~ 0
CSA_VDIS_18
Text GLabel 12614 4650 0    60   BiDi ~ 0
VCASN_18
Text GLabel 12614 4750 0    60   BiDi ~ 0
VCASN_18
Text GLabel 12614 4850 0    60   BiDi ~ 0
VCASP_18
Text GLabel 12614 4950 0    60   BiDi ~ 0
VCASP_18
Text GLabel 12614 5050 0    60   BiDi ~ 0
DVDD
Text GLabel 12614 5150 0    60   BiDi ~ 0
DGND
Text GLabel 12614 5250 0    60   BiDi ~ 0
LVDS_VREF
Text GLabel 12614 5350 0    60   BiDi ~ 0
RESET
Text GLabel 12614 5450 0    60   BiDi ~ 0
SDM_OUT2_18_P
Text GLabel 12614 5550 0    60   BiDi ~ 0
SDM_OUT2_18_N
Text GLabel 12614 5650 0    60   BiDi ~ 0
SDM_OUT1_18_N
Text GLabel 12614 5750 0    60   BiDi ~ 0
SDM_OUT1_18_P
Text GLabel 12614 5850 0    60   BiDi ~ 0
CLK_1_N
Text GLabel 12614 5950 0    60   BiDi ~ 0
CLK_1_P
Text GLabel 12614 6050 0    60   BiDi ~ 0
SCK_1
Text GLabel 12614 6150 0    60   BiDi ~ 0
SDO_6
Text GLabel 14314 6250 2    60   BiDi ~ 0
SDO_18
Text GLabel 14314 6150 2    60   BiDi ~ 0
SDM_VDD_Shield
Text GLabel 14314 6050 2    60   BiDi ~ 0
AVDD
Text GLabel 14314 5950 2    60   BiDi ~ 0
AGND
Text GLabel 14314 5850 2    60   BiDi ~ 0
SDM_BIAS_18
Text GLabel 14314 5750 2    60   BiDi ~ 0
SDM_BIAS_18
Text GLabel 14314 5650 2    60   BiDi ~ 0
GND_VREF
Text GLabel 14314 5550 2    60   BiDi ~ 0
Ref3
Text GLabel 14314 5450 2    60   BiDi ~ 0
Ref1
Text GLabel 14314 5350 2    60   BiDi ~ 0
Ref2
Text GLabel 14314 5250 2    60   BiDi ~ 0
SDM_testIN
NoConn ~ 14314 5150
NoConn ~ 14314 5050
NoConn ~ 14314 4950
NoConn ~ 14314 4850
Text GLabel 14314 4750 2    60   BiDi ~ 0
DAC_BufferX2_VREF
Text GLabel 14314 4650 2    60   BiDi ~ 0
CSA_VBIASN_18
Text GLabel 14314 4550 2    60   BiDi ~ 0
CSA_VBIASN_18
Text GLabel 14314 4450 2    60   BiDi ~ 0
CSA_VBIASP_18
Text GLabel 14314 4350 2    60   BiDi ~ 0
CSA_VBIASP_18
NoConn ~ 14314 4250
Text GLabel 14314 4150 2    60   BiDi ~ 0
AOUT1_CSA_18
Text GLabel 14314 4050 2    60   BiDi ~ 0
AGND
Text GLabel 14314 3950 2    60   BiDi ~ 0
AVDD
Text GLabel 14314 3850 2    60   BiDi ~ 0
AGND
Text GLabel 14314 3750 2    60   BiDi ~ 0
AVDD
$Comp
L C C180
U 1 1 59697F73
P 12964 6650
F 0 "C180" H 12964 6730 50  0000 L CNN
F 1 "1u" H 12964 6550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 12894 6650 50  0001 C CNN
F 3 "" H 12964 6650 50  0001 C CNN
	1    12964 6650
	1    0    0    -1  
$EndComp
$Comp
L C C181
U 1 1 59697F74
P 13464 6650
F 0 "C181" H 13464 6730 50  0000 L CNN
F 1 "1u" H 13464 6550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 13394 6650 50  0001 C CNN
F 3 "" H 13464 6650 50  0001 C CNN
	1    13464 6650
	1    0    0    -1  
$EndComp
$Comp
L C C182
U 1 1 59697F75
P 13964 6650
F 0 "C182" H 13964 6730 50  0000 L CNN
F 1 "1u" H 13964 6550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 13894 6650 50  0001 C CNN
F 3 "" H 13964 6650 50  0001 C CNN
	1    13964 6650
	1    0    0    -1  
$EndComp
Text GLabel 12964 6800 0    60   BiDi ~ 0
DGND
Text GLabel 12964 6500 0    60   BiDi ~ 0
DVDD
Text GLabel 13464 6800 0    60   BiDi ~ 0
AGND
Text GLabel 13464 6500 0    60   BiDi ~ 0
AVDD
Text GLabel 13964 6800 0    60   BiDi ~ 0
AGND
Text GLabel 13964 6500 0    60   BiDi ~ 0
AVDD
$EndSCHEMATC
