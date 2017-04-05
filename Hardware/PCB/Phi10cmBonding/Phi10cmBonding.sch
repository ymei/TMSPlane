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
Title "Python generated schematic with two resistors"
Date ""
Rev "0"
Comp "KiSch"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L R R1
U 1 1 58E4B144
P 8000 5000
F 0 "R1" V 8080 5000 50  0000 C CNN
F 1 "100" V 7900 5000 50  0000 C CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" V 7930 5000 50  0001 C CNN
F 3 "" H 8000 5000 50  0001 C CNN
        1    8000 5000
        0    -1   -1   0
$EndComp
$Comp
L R R2
U 1 1 58E4B145
P 8000 5500
F 0 "R2" V 8080 5500 50  0000 C CNN
F 1 "1k" V 7900 5500 50  0000 C CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" V 7930 5500 50  0001 C CNN
F 3 "" H 8000 5500 50  0001 C CNN
        1    8000 5500
        0    -1   -1   0
$EndComp
Text Label 7850 5000 2    60   ~ 0
VDD
Text Label 8150 5000 0    60   ~ 0
R12
Text Label 7850 5500 2    60   ~ 0
R12
Text Label 8150 5500 0    60   ~ 0
GND
$EndSCHEMATC
