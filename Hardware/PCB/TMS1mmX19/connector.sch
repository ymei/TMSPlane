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
$Descr USLetter 11000 8500
encoding utf-8
Sheet 2 3
Title "Board-edge push-on connectors"
Date ""
Rev ""
Comp "LBNL"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L FSI-150-XX-X-S-X-XX J1
U 1 1 5969E04B
P 5150 6650
F 0 "J1" H 5206 9347 60  0000 C CNN
F 1 "FSI-150-XX-X-S-X-XX" H 5206 9241 60  0000 C CNN
F 2 "Topmetal:FSI-150-XX-X-S-X-AD-recv-Bot" H 5150 6650 60  0001 C CNN
F 3 "" H 5150 6650 60  0001 C CNN
	1    5150 6650
	0    1    -1   0   
$EndComp
$Comp
L FSI-150-XX-X-S-X-XX J2
U 1 1 5969E258
P 9050 3750
F 0 "J2" H 9106 6447 60  0000 C CNN
F 1 "FSI-150-XX-X-S-X-XX" H 9106 6341 60  0000 C CNN
F 2 "Topmetal:FSI-150-XX-X-S-X-AD-recv-Bot" H 9050 3750 60  0001 C CNN
F 3 "" H 9050 3750 60  0001 C CNN
	1    9050 3750
	-1   0    0    -1  
$EndComp
$Comp
L FSI-150-XX-X-S-X-XX J3
U 1 1 596FF5EA
P 5150 850
F 0 "J3" H 5206 3547 60  0000 C CNN
F 1 "FSI-150-XX-X-S-X-XX" H 5206 3441 60  0000 C CNN
F 2 "Topmetal:FSI-150-XX-X-S-X-AD-recv-Bot" H 5150 850 60  0001 C CNN
F 3 "" H 5150 850 60  0001 C CNN
	1    5150 850 
	0    -1   1    0   
$EndComp
$Comp
L FSI-150-XX-X-S-X-XX J4
U 1 1 596FF6CA
P 1050 3750
F 0 "J4" H 1106 6447 60  0000 C CNN
F 1 "FSI-150-XX-X-S-X-XX" H 1106 6341 60  0000 C CNN
F 2 "Topmetal:FSI-150-XX-X-S-X-AD-recv-Bot" H 1050 3750 60  0001 C CNN
F 3 "" H 1050 3750 60  0001 C CNN
	1    1050 3750
	1    0    0    1   
$EndComp
$Comp
L Screw_Terminal_1x01 S1
U 1 1 597004E7
P 10100 5400
F 0 "S1" H 10180 5642 50  0000 C CNN
F 1 "Mounting Hole" H 10180 5551 50  0000 C CNN
F 2 "Mounting_Holes:MountingHole_3.2mm_M3" H 10100 5275 50  0001 C CNN
F 3 "" H 10100 5300 50  0001 C CNN
	1    10100 5400
	1    0    0    -1  
$EndComp
$Comp
L Screw_Terminal_1x01 S2
U 1 1 597005AA
P 10100 5800
F 0 "S2" H 10180 6042 50  0000 C CNN
F 1 "Mounting Hole" H 10180 5951 50  0000 C CNN
F 2 "Mounting_Holes:MountingHole_3.2mm_M3" H 10100 5675 50  0001 C CNN
F 3 "" H 10100 5700 50  0001 C CNN
	1    10100 5800
	1    0    0    -1  
$EndComp
$Comp
L Screw_Terminal_1x01 S3
U 1 1 597005F0
P 10100 6200
F 0 "S3" H 10180 6442 50  0000 C CNN
F 1 "Mounting Hole" H 10180 6351 50  0000 C CNN
F 2 "Mounting_Holes:MountingHole_3.2mm_M3" H 10100 6075 50  0001 C CNN
F 3 "" H 10100 6100 50  0001 C CNN
	1    10100 6200
	1    0    0    -1  
$EndComp
$Comp
L Screw_Terminal_1x01 S4
U 1 1 5970061E
P 10100 6600
F 0 "S4" H 10180 6842 50  0000 C CNN
F 1 "Mounting Hole" H 10180 6751 50  0000 C CNN
F 2 "Mounting_Holes:MountingHole_3.2mm_M3" H 10100 6475 50  0001 C CNN
F 3 "" H 10100 6500 50  0001 C CNN
	1    10100 6600
	1    0    0    -1  
$EndComp
NoConn ~ 10300 5400
NoConn ~ 10300 5800
NoConn ~ 10300 6200
NoConn ~ 10300 6600
Text GLabel 1200 1500 2    60   BiDi ~ 0
GND_NMOSI
Text GLabel 1200 1600 2    60   BiDi ~ 0
GND_NMOSI
Text GLabel 1200 1300 2    60   BiDi ~ 0
Gring
Text GLabel 1200 1400 2    60   BiDi ~ 0
Gring
Text GLabel 8900 1500 0    60   BiDi ~ 0
SDM_VDD_Shield
Text GLabel 8900 1600 0    60   BiDi ~ 0
SDM_VDD_Shield
Text GLabel 8900 1300 0    60   BiDi ~ 0
LVDS_VREF
Text GLabel 8900 1400 0    60   BiDi ~ 0
LVDS_VREF
Text GLabel 1200 5900 2    60   BiDi ~ 0
DAC_BufferX2_VREF
Text GLabel 1200 6000 2    60   BiDi ~ 0
DAC_BufferX2_VREF
Text GLabel 1200 6100 2    60   BiDi ~ 0
Ref3
Text GLabel 1200 6200 2    60   BiDi ~ 0
Ref3
Text GLabel 8900 5900 0    60   BiDi ~ 0
GND_VREF
Text GLabel 8900 6000 0    60   BiDi ~ 0
GND_VREF
Text GLabel 8900 6100 0    60   BiDi ~ 0
Ref1
Text GLabel 8900 6200 0    60   BiDi ~ 0
Ref1
Text GLabel 8900 5800 0    60   BiDi ~ 0
AGND
Text GLabel 8900 1700 0    60   BiDi ~ 0
AVDD
Text GLabel 1200 1700 2    60   BiDi ~ 0
AGND
Text GLabel 5800 1000 3    60   BiDi ~ 0
CLK_0_P
Text GLabel 5700 1000 3    60   BiDi ~ 0
CLK_0_N
Text GLabel 8900 3300 0    60   BiDi ~ 0
AOUT1_CSA_5
Text GLabel 8900 3100 0    60   BiDi ~ 0
AOUT1_CSA_0
Text GLabel 8900 2900 0    60   BiDi ~ 0
AOUT1_CSA_16
Text GLabel 8900 4100 0    60   BiDi ~ 0
AOUT1_CSA_13
Text GLabel 8900 3900 0    60   BiDi ~ 0
AOUT1_CSA_14
Text GLabel 8900 3700 0    60   BiDi ~ 0
AOUT1_CSA_4
Text GLabel 8900 3500 0    60   BiDi ~ 0
AOUT1_CSA_15
Text GLabel 8900 2700 0    60   BiDi ~ 0
AOUT1_CSA_6
Text GLabel 8900 2500 0    60   BiDi ~ 0
AOUT1_CSA_1
Text GLabel 8900 2300 0    60   BiDi ~ 0
AOUT1_CSA_17
Text GLabel 8900 2100 0    60   BiDi ~ 0
AOUT1_CSA_18
Text GLabel 8900 1900 0    60   BiDi ~ 0
AOUT1_CSA_7
Text GLabel 1200 2500 2    60   BiDi ~ 0
AOUT1_CSA_10
Text GLabel 1200 2300 2    60   BiDi ~ 0
AOUT1_CSA_9
Text GLabel 1200 1900 2    60   BiDi ~ 0
AOUT1_CSA_8
Text GLabel 1200 2100 2    60   BiDi ~ 0
AOUT1_CSA_2
Text GLabel 1200 2700 2    60   BiDi ~ 0
AOUT1_CSA_11
Text GLabel 1200 2900 2    60   BiDi ~ 0
AOUT1_CSA_3
Text GLabel 1200 3100 2    60   BiDi ~ 0
AOUT1_CSA_12
Text GLabel 1200 4000 2    60   Input ~ 0
SDO_7
Text GLabel 1200 4600 2    60   Output ~ 0
SDO_26
Text GLabel 1200 4500 2    60   Output ~ 0
SCK_-2
Text GLabel 1200 4700 2    60   Output ~ 0
SCK_-1
Text GLabel 1200 4800 2    60   Output ~ 0
SDO_27
Text GLabel 1200 4900 2    60   Output ~ 0
SCK_0
Text GLabel 1200 5000 2    60   Output ~ 0
SDO_28
Text GLabel 1200 4100 2    60   Input ~ 0
SDO_8
Text GLabel 1200 4200 2    60   Input ~ 0
SDO_9
Text GLabel 8900 1800 0    60   BiDi ~ 0
AVDD
Text GLabel 8900 2000 0    60   BiDi ~ 0
AGND
Text GLabel 8900 2200 0    60   BiDi ~ 0
AGND
Text GLabel 8900 2400 0    60   BiDi ~ 0
AGND
Text GLabel 8900 2600 0    60   BiDi ~ 0
AGND
Text GLabel 8900 2800 0    60   BiDi ~ 0
AGND
Text GLabel 8900 3000 0    60   BiDi ~ 0
AGND
Text GLabel 8900 3200 0    60   BiDi ~ 0
AGND
Text GLabel 8900 3400 0    60   BiDi ~ 0
AGND
Text GLabel 8900 3600 0    60   BiDi ~ 0
AGND
Text GLabel 8900 3800 0    60   BiDi ~ 0
AGND
Text GLabel 8900 4000 0    60   BiDi ~ 0
AGND
Text GLabel 8900 5700 0    60   BiDi ~ 0
AGND
Text GLabel 1200 5100 2    60   Output ~ 0
SCK_1
Text GLabel 1200 5300 2    60   Output ~ 0
SCK_2
Text GLabel 1200 5200 2    60   Output ~ 0
SDO_29
Text GLabel 1200 5400 2    60   Output ~ 0
SDO_30
Text GLabel 1200 4400 2    60   BiDi ~ 0
DGND
Text GLabel 1200 3900 2    60   Input ~ 0
SDO_18
Text GLabel 1200 3800 2    60   Input ~ 0
SDO_17
Text GLabel 1200 1800 2    60   BiDi ~ 0
AGND
Text GLabel 1200 4300 2    60   BiDi ~ 0
DGND
Text GLabel 1200 2000 2    60   BiDi ~ 0
AGND
Text GLabel 1200 2200 2    60   BiDi ~ 0
AGND
Text GLabel 1200 2400 2    60   BiDi ~ 0
AGND
Text GLabel 1200 2600 2    60   BiDi ~ 0
AGND
Text GLabel 1200 2800 2    60   BiDi ~ 0
AGND
Text GLabel 1200 3000 2    60   BiDi ~ 0
AGND
Text GLabel 1200 3200 2    60   BiDi ~ 0
AGND
Text GLabel 1200 5700 2    60   BiDi ~ 0
AVDD
Text GLabel 1200 5800 2    60   BiDi ~ 0
AVDD
Text GLabel 5600 1000 3    60   BiDi ~ 0
SDM_OUT2_7_P
Text GLabel 5500 1000 3    60   BiDi ~ 0
SDM_OUT2_7_N
Text GLabel 5400 1000 3    60   BiDi ~ 0
SDM_OUT1_7_N
Text GLabel 5300 1000 3    60   BiDi ~ 0
SDM_OUT1_7_P
Text GLabel 5200 1000 3    60   BiDi ~ 0
SDM_OUT2_1_P
Text GLabel 5100 1000 3    60   BiDi ~ 0
SDM_OUT2_1_N
Text GLabel 5000 1000 3    60   BiDi ~ 0
SDM_OUT1_1_N
Text GLabel 4900 1000 3    60   BiDi ~ 0
SDM_OUT1_1_P
Text GLabel 4800 1000 3    60   BiDi ~ 0
SDM_OUT2_0_P
Text GLabel 4700 1000 3    60   BiDi ~ 0
SDM_OUT2_0_N
Text GLabel 4600 1000 3    60   BiDi ~ 0
SDM_OUT1_0_N
Text GLabel 4500 1000 3    60   BiDi ~ 0
SDM_OUT1_0_P
Text GLabel 4200 1000 3    60   BiDi ~ 0
SDM_OUT2_8_P
Text GLabel 4100 1000 3    60   BiDi ~ 0
SDM_OUT2_8_N
Text GLabel 4000 1000 3    60   BiDi ~ 0
SDM_OUT1_8_N
Text GLabel 3900 1000 3    60   BiDi ~ 0
SDM_OUT1_8_P
Text GLabel 3800 1000 3    60   BiDi ~ 0
SDM_OUT2_2_P
Text GLabel 3700 1000 3    60   BiDi ~ 0
SDM_OUT2_2_N
Text GLabel 3600 1000 3    60   BiDi ~ 0
SDM_OUT1_2_N
Text GLabel 3500 1000 3    60   BiDi ~ 0
SDM_OUT1_2_P
Text GLabel 7200 1000 3    60   BiDi ~ 0
SDM_OUT2_17_P
Text GLabel 7100 1000 3    60   BiDi ~ 0
SDM_OUT2_17_N
Text GLabel 7000 1000 3    60   BiDi ~ 0
SDM_OUT1_17_N
Text GLabel 6900 1000 3    60   BiDi ~ 0
SDM_OUT1_17_P
Text GLabel 4400 1000 3    60   BiDi ~ 0
CLK_-1_P
Text GLabel 4300 1000 3    60   BiDi ~ 0
CLK_-1_N
Text GLabel 3400 1000 3    60   BiDi ~ 0
CLK_-2_P
Text GLabel 3300 1000 3    60   BiDi ~ 0
CLK_-2_N
Text GLabel 6200 1000 3    60   BiDi ~ 0
SDM_OUT2_6_P
Text GLabel 6100 1000 3    60   BiDi ~ 0
SDM_OUT2_6_N
Text GLabel 6000 1000 3    60   BiDi ~ 0
SDM_OUT1_6_N
Text GLabel 5900 1000 3    60   BiDi ~ 0
SDM_OUT1_6_P
Text GLabel 6600 1000 3    60   BiDi ~ 0
SDM_OUT2_18_P
Text GLabel 6500 1000 3    60   BiDi ~ 0
SDM_OUT2_18_N
Text GLabel 6400 1000 3    60   BiDi ~ 0
SDM_OUT1_18_N
Text GLabel 6300 1000 3    60   BiDi ~ 0
SDM_OUT1_18_P
Text GLabel 6700 1000 3    60   BiDi ~ 0
CLK_1_N
Text GLabel 6800 1000 3    60   BiDi ~ 0
CLK_1_P
Text GLabel 7300 1000 3    60   BiDi ~ 0
CLK_2_N
Text GLabel 7400 1000 3    60   BiDi ~ 0
CLK_2_P
Text GLabel 3200 1000 3    60   BiDi ~ 0
SDM_OUT2_9_P
Text GLabel 3100 1000 3    60   BiDi ~ 0
SDM_OUT2_9_N
Text GLabel 3000 1000 3    60   BiDi ~ 0
SDM_OUT1_9_N
Text GLabel 2900 1000 3    60   BiDi ~ 0
SDM_OUT1_9_P
Text GLabel 2700 1000 3    60   BiDi ~ 0
DGND
Text GLabel 2800 1000 3    60   BiDi ~ 0
DGND
Text GLabel 7500 1000 3    60   BiDi ~ 0
DVDD
Text GLabel 7600 1000 3    60   BiDi ~ 0
DVDD
Text GLabel 3000 6500 1    60   BiDi ~ 0
SDM_OUT2_10_N
Text GLabel 2900 6500 1    60   BiDi ~ 0
SDM_OUT2_10_P
Text GLabel 2800 6500 1    60   BiDi ~ 0
SDM_OUT1_10_P
Text GLabel 2700 6500 1    60   BiDi ~ 0
SDM_OUT1_10_N
Text GLabel 3400 6500 1    60   BiDi ~ 0
SDM_OUT2_11_N
Text GLabel 3300 6500 1    60   BiDi ~ 0
SDM_OUT2_11_P
Text GLabel 3200 6500 1    60   BiDi ~ 0
SDM_OUT1_11_P
Text GLabel 3100 6500 1    60   BiDi ~ 0
SDM_OUT1_11_N
Text GLabel 4000 6500 1    60   BiDi ~ 0
SDM_OUT2_3_N
Text GLabel 3900 6500 1    60   BiDi ~ 0
SDM_OUT2_3_P
Text GLabel 3800 6500 1    60   BiDi ~ 0
SDM_OUT1_3_P
Text GLabel 3700 6500 1    60   BiDi ~ 0
SDM_OUT1_3_N
Text GLabel 4400 6500 1    60   BiDi ~ 0
SDM_OUT2_12_N
Text GLabel 4300 6500 1    60   BiDi ~ 0
SDM_OUT2_12_P
Text GLabel 4200 6500 1    60   BiDi ~ 0
SDM_OUT1_12_P
Text GLabel 4100 6500 1    60   BiDi ~ 0
SDM_OUT1_12_N
Text GLabel 5000 6500 1    60   BiDi ~ 0
SDM_OUT2_4_N
Text GLabel 4900 6500 1    60   BiDi ~ 0
SDM_OUT2_4_P
Text GLabel 4800 6500 1    60   BiDi ~ 0
SDM_OUT1_4_P
Text GLabel 4700 6500 1    60   BiDi ~ 0
SDM_OUT1_4_N
Text GLabel 5400 6500 1    60   BiDi ~ 0
SDM_OUT2_13_N
Text GLabel 5300 6500 1    60   BiDi ~ 0
SDM_OUT2_13_P
Text GLabel 5200 6500 1    60   BiDi ~ 0
SDM_OUT1_13_P
Text GLabel 5100 6500 1    60   BiDi ~ 0
SDM_OUT1_13_N
Text GLabel 6000 6500 1    60   BiDi ~ 0
SDM_OUT2_5_N
Text GLabel 5900 6500 1    60   BiDi ~ 0
SDM_OUT2_5_P
Text GLabel 5800 6500 1    60   BiDi ~ 0
SDM_OUT1_5_P
Text GLabel 5700 6500 1    60   BiDi ~ 0
SDM_OUT1_5_N
Text GLabel 6400 6500 1    60   BiDi ~ 0
SDM_OUT2_14_N
Text GLabel 6300 6500 1    60   BiDi ~ 0
SDM_OUT2_14_P
Text GLabel 6200 6500 1    60   BiDi ~ 0
SDM_OUT1_14_P
Text GLabel 6100 6500 1    60   BiDi ~ 0
SDM_OUT1_14_N
Text GLabel 7000 6500 1    60   BiDi ~ 0
SDM_OUT2_16_N
Text GLabel 6900 6500 1    60   BiDi ~ 0
SDM_OUT2_16_P
Text GLabel 6800 6500 1    60   BiDi ~ 0
SDM_OUT1_16_P
Text GLabel 6700 6500 1    60   BiDi ~ 0
SDM_OUT1_16_N
Text GLabel 7400 6500 1    60   BiDi ~ 0
SDM_OUT2_15_N
Text GLabel 7300 6500 1    60   BiDi ~ 0
SDM_OUT2_15_P
Text GLabel 7200 6500 1    60   BiDi ~ 0
SDM_OUT1_15_P
Text GLabel 7100 6500 1    60   BiDi ~ 0
SDM_OUT1_15_N
$Comp
L R R_C-2
U 1 1 5981D8E3
P 3350 2450
F 0 "R_C-2" V 3143 2450 50  0000 C CNN
F 1 "100" V 3234 2450 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 3280 2450 50  0001 C CNN
F 3 "" H 3350 2450 50  0001 C CNN
	1    3350 2450
	0    1    1    0   
$EndComp
$Comp
L R R_C-1
U 1 1 5981DC5B
P 4350 2450
F 0 "R_C-1" V 4143 2450 50  0000 C CNN
F 1 "100" V 4234 2450 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 4280 2450 50  0001 C CNN
F 3 "" H 4350 2450 50  0001 C CNN
	1    4350 2450
	0    1    1    0   
$EndComp
$Comp
L R R_C0
U 1 1 5981DCAD
P 5750 2450
F 0 "R_C0" V 5543 2450 50  0000 C CNN
F 1 "100" V 5634 2450 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 5680 2450 50  0001 C CNN
F 3 "" H 5750 2450 50  0001 C CNN
	1    5750 2450
	0    1    1    0   
$EndComp
$Comp
L R R_C1
U 1 1 5981DCFD
P 6750 2450
F 0 "R_C1" V 6543 2450 50  0000 C CNN
F 1 "100" V 6634 2450 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 6680 2450 50  0001 C CNN
F 3 "" H 6750 2450 50  0001 C CNN
	1    6750 2450
	0    1    1    0   
$EndComp
$Comp
L R R_C2
U 1 1 5981DD3F
P 7350 2450
F 0 "R_C2" V 7143 2450 50  0000 C CNN
F 1 "100" V 7234 2450 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 7280 2450 50  0001 C CNN
F 3 "" H 7350 2450 50  0001 C CNN
	1    7350 2450
	0    1    1    0   
$EndComp
Text GLabel 3500 2450 3    60   BiDi ~ 0
CLK_-2_P
Text GLabel 3200 2450 3    60   BiDi ~ 0
CLK_-2_N
Text GLabel 4500 2450 3    60   BiDi ~ 0
CLK_-1_P
Text GLabel 4200 2450 3    60   BiDi ~ 0
CLK_-1_N
Text GLabel 5900 2450 3    60   BiDi ~ 0
CLK_0_P
Text GLabel 5600 2450 3    60   BiDi ~ 0
CLK_0_N
Text GLabel 6600 2450 3    60   BiDi ~ 0
CLK_1_N
Text GLabel 6900 2450 3    60   BiDi ~ 0
CLK_1_P
Text GLabel 7200 2450 3    60   BiDi ~ 0
CLK_2_N
Text GLabel 7500 2450 3    60   BiDi ~ 0
CLK_2_P
Text GLabel 1200 3600 2    60   Output ~ 0
RESET
Text GLabel 1200 3300 2    60   Output ~ 0
SDM_testIN
Text GLabel 3500 6500 1    60   BiDi ~ 0
DGND
Text GLabel 3600 6500 1    60   BiDi ~ 0
DGND
Text GLabel 4500 6500 1    60   BiDi ~ 0
DGND
Text GLabel 4600 6500 1    60   BiDi ~ 0
DGND
Text GLabel 7500 6500 1    60   BiDi ~ 0
DVDD
Text GLabel 7600 6500 1    60   BiDi ~ 0
DVDD
Text GLabel 6500 6500 1    60   BiDi ~ 0
DVDD
Text GLabel 6600 6500 1    60   BiDi ~ 0
DVDD
Text GLabel 5500 6500 1    60   BiDi ~ 0
DGND
Text GLabel 5600 6500 1    60   BiDi ~ 0
DGND
Text GLabel 1200 3400 2    60   BiDi ~ 0
AGND
Text GLabel 1200 3500 2    60   BiDi ~ 0
AGND
Text GLabel 1200 3700 2    60   BiDi ~ 0
AGND
Text GLabel 1200 5500 2    60   BiDi ~ 0
AVDD
Text GLabel 1200 5600 2    60   BiDi ~ 0
AVDD
Text GLabel 8900 5600 0    60   BiDi ~ 0
Ref2
Text GLabel 8900 5500 0    60   BiDi ~ 0
Ref2
Text GLabel 8900 5400 0    60   BiDi ~ 0
AVDD
Text GLabel 8900 5300 0    60   BiDi ~ 0
AVDD
Text GLabel 8900 4200 0    60   BiDi ~ 0
AGND
Text GLabel 8900 4300 0    60   BiDi ~ 0
AGND
Text GLabel 8900 4400 0    60   BiDi ~ 0
AGND
Text GLabel 8900 4500 0    60   BiDi ~ 0
AGND
Text GLabel 8900 4600 0    60   BiDi ~ 0
AGND
Text GLabel 8900 4700 0    60   BiDi ~ 0
AGND
Text GLabel 8900 4800 0    60   BiDi ~ 0
AGND
Text GLabel 8900 4900 0    60   BiDi ~ 0
AGND
Text GLabel 8900 5000 0    60   BiDi ~ 0
AGND
Text GLabel 8900 5200 0    60   BiDi ~ 0
AVDD
Text GLabel 8900 5100 0    60   BiDi ~ 0
AVDD
$EndSCHEMATC
