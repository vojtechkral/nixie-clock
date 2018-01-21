EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:switches
LIBS:relays
LIBS:motors
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
LIBS:nodemcu
LIBS:rotary-encoder
LIBS:74hc141
LIBS:dc-dc
LIBS:zs-042
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "Nixie Clock"
Date "2018-01-19"
Rev "1.0"
Comp "Vojtěch Král"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L 74HC595 U3
U 1 1 5A60C8CA
P 7350 2200
F 0 "U3" H 7500 2800 50  0000 C CNN
F 1 "74HC595" H 7350 1600 50  0000 C CNN
F 2 "" H 7350 2200 50  0001 C CNN
F 3 "" H 7350 2200 50  0001 C CNN
	1    7350 2200
	1    0    0    -1  
$EndComp
$Comp
L 74HC595 U4
U 1 1 5A60CB4E
P 7350 3500
F 0 "U4" H 7500 4100 50  0000 C CNN
F 1 "74HC595" H 7350 2900 50  0000 C CNN
F 2 "" H 7350 3500 50  0001 C CNN
F 3 "" H 7350 3500 50  0001 C CNN
	1    7350 3500
	1    0    0    -1  
$EndComp
$Comp
L NodeMCU_0.9 U2
U 1 1 5A60CBF9
P 5500 2700
F 0 "U2" H 5500 3500 50  0000 C CNN
F 1 "NodeMCU_0.9" H 5500 1850 50  0000 C CNN
F 2 "" H 5750 2700 50  0000 C CNN
F 3 "" H 5750 2700 50  0000 C CNN
	1    5500 2700
	1    0    0    -1  
$EndComp
$Comp
L R R7
U 1 1 5A624AAF
P 8650 1850
F 0 "R7" V 8730 1850 50  0000 C CNN
F 1 "6k8" V 8650 1850 50  0000 C CNN
F 2 "" V 8580 1850 50  0001 C CNN
F 3 "" H 8650 1850 50  0001 C CNN
	1    8650 1850
	0    1    1    0   
$EndComp
$Comp
L Q_NPN_BCE Q3
U 1 1 5A624BA0
P 9000 1850
F 0 "Q3" H 9200 1900 50  0000 L CNN
F 1 "MPSA42" H 9200 1800 50  0000 L CNN
F 2 "" H 9200 1950 50  0001 C CNN
F 3 "" H 9000 1850 50  0001 C CNN
	1    9000 1850
	1    0    0    -1  
$EndComp
$Comp
L Q_PNP_BCE Q2
U 1 1 5A624BFD
P 9700 1650
F 0 "Q2" H 9900 1700 50  0000 L CNN
F 1 "MPSA92" H 9900 1600 50  0000 L CNN
F 2 "" H 9900 1750 50  0001 C CNN
F 3 "" H 9700 1650 50  0001 C CNN
	1    9700 1650
	1    0    0    -1  
$EndComp
$Comp
L R R10
U 1 1 5A624C68
P 9350 1650
F 0 "R10" V 9430 1650 50  0000 C CNN
F 1 "1M" V 9350 1650 50  0000 C CNN
F 2 "" V 9280 1650 50  0001 C CNN
F 3 "" H 9350 1650 50  0001 C CNN
	1    9350 1650
	0    1    1    0   
$EndComp
$Comp
L R R8
U 1 1 5A62520B
P 8800 2050
F 0 "R8" V 8880 2050 50  0000 C CNN
F 1 "10k" V 8800 2050 50  0000 C CNN
F 2 "" V 8730 2050 50  0001 C CNN
F 3 "" H 8800 2050 50  0001 C CNN
	1    8800 2050
	-1   0    0    1   
$EndComp
$Comp
L Earth #PWR?
U 1 1 5A625514
P 9100 2200
F 0 "#PWR?" H 9100 1950 50  0001 C CNN
F 1 "Earth" H 9100 2050 50  0001 C CNN
F 2 "" H 9100 2200 50  0001 C CNN
F 3 "" H 9100 2200 50  0001 C CNN
	1    9100 2200
	1    0    0    -1  
$EndComp
$Comp
L R R9
U 1 1 5A6258DD
P 9350 1450
F 0 "R9" V 9430 1450 50  0000 C CNN
F 1 "10k" V 9350 1450 50  0000 C CNN
F 2 "" V 9280 1450 50  0001 C CNN
F 3 "" H 9350 1450 50  0001 C CNN
	1    9350 1450
	0    -1   -1   0   
$EndComp
Text GLabel 9800 1100 1    60   Input ~ 0
170V
$Comp
L R R11
U 1 1 5A625DA2
P 9950 1950
F 0 "R11" V 10030 1950 50  0000 C CNN
F 1 "10k" V 9950 1950 50  0000 C CNN
F 2 "" V 9880 1950 50  0001 C CNN
F 3 "" H 9950 1950 50  0001 C CNN
	1    9950 1950
	0    -1   -1   0   
$EndComp
Text GLabel 10300 1950 2    60   Output ~ 0
Anode
Entry Wire Line
	8350 1750 8450 1850
$Comp
L 74HC141 U1
U 1 1 5A6250D6
P 9200 3400
F 0 "U1" H 9200 3500 50  0000 C CNN
F 1 "74HC141" H 9200 3350 50  0000 C CNN
F 2 "" H 9200 3400 50  0001 C CNN
F 3 "" H 9200 3400 50  0001 C CNN
	1    9200 3400
	1    0    0    -1  
$EndComp
Entry Wire Line
	9950 3000 10050 2900
Entry Wire Line
	9950 3100 10050 3000
Entry Wire Line
	9950 3200 10050 3100
Entry Wire Line
	9950 3300 10050 3200
Entry Wire Line
	9950 3400 10050 3300
Entry Wire Line
	9950 3500 10050 3400
Entry Wire Line
	9950 3600 10050 3500
Entry Wire Line
	9950 3700 10050 3600
Entry Wire Line
	9950 3800 10050 3700
Entry Wire Line
	9950 3900 10050 3800
Text GLabel 10200 2800 2    60   Output ~ 0
Cathodes
Entry Wire Line
	8100 2250 8200 2150
Entry Wire Line
	8100 2350 8200 2250
Entry Wire Line
	8100 2450 8200 2350
Entry Wire Line
	8100 2150 8200 2050
$Comp
L KY-040 SW1
U 1 1 5A6254A9
P 6200 4000
F 0 "SW1" H 6200 4260 50  0000 C CNN
F 1 "KY-040" H 6200 3740 50  0000 C CNN
F 2 "" H 6100 4160 50  0001 C CNN
F 3 "" H 6200 4260 50  0001 C CNN
	1    6200 4000
	0    1    1    0   
$EndComp
Text Notes 9250 2350 0    60   ~ 0
One per each anode
$Comp
L +12V #PWR?
U 1 1 5A627419
P 900 950
F 0 "#PWR?" H 900 800 50  0001 C CNN
F 1 "+12V" H 900 1090 50  0000 C CNN
F 2 "" H 900 950 50  0001 C CNN
F 3 "" H 900 950 50  0001 C CNN
	1    900  950 
	1    0    0    -1  
$EndComp
Text GLabel 8900 2850 1    60   Input ~ 0
5V
$Comp
L MC34063 U5
U 1 1 5A625912
P 1700 1700
F 0 "U5" H 1700 2150 50  0000 C CNN
F 1 "MC34063" H 1750 1250 50  0000 L CNN
F 2 "" H 2200 1700 50  0001 C CNN
F 3 "" H 2200 1700 50  0001 C CNN
	1    1700 1700
	1    0    0    -1  
$EndComp
$Comp
L Earth #PWR?
U 1 1 5A625B3E
P 1700 2400
F 0 "#PWR?" H 1700 2150 50  0001 C CNN
F 1 "Earth" H 1700 2250 50  0001 C CNN
F 2 "" H 1700 2400 50  0001 C CNN
F 3 "" H 1700 2400 50  0001 C CNN
	1    1700 2400
	1    0    0    -1  
$EndComp
$Comp
L C_Small C1
U 1 1 5A625CBB
P 1500 2300
F 0 "C1" H 1510 2370 50  0000 L CNN
F 1 "1n0" H 1510 2220 50  0000 L CNN
F 2 "" H 1500 2300 50  0001 C CNN
F 3 "" H 1500 2300 50  0001 C CNN
	1    1500 2300
	0    1    1    0   
$EndComp
$Comp
L L L1
U 1 1 5A6265DA
P 2550 1150
F 0 "L1" V 2500 1150 50  0000 C CNN
F 1 "330u" V 2625 1150 50  0000 C CNN
F 2 "" H 2550 1150 50  0001 C CNN
F 3 "" H 2550 1150 50  0001 C CNN
	1    2550 1150
	0    -1   -1   0   
$EndComp
$Comp
L IRF3205 Q1
U 1 1 5A6267F3
P 2600 1700
F 0 "Q1" H 2850 1775 50  0000 L CNN
F 1 "IRF830" H 2850 1700 50  0000 L CNN
F 2 "TO_SOT_Packages_THT:TO-220_Vertical" H 2850 1625 50  0001 L CIN
F 3 "" H 2600 1700 50  0001 L CNN
	1    2600 1700
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 5A626F42
P 2300 1350
F 0 "R1" V 2380 1350 50  0000 C CNN
F 1 "1R0" V 2300 1350 50  0000 C CNN
F 2 "" V 2230 1350 50  0001 C CNN
F 3 "" H 2300 1350 50  0001 C CNN
	1    2300 1350
	1    0    0    -1  
$EndComp
$Comp
L D D1
U 1 1 5A6271F1
P 2950 1350
F 0 "D1" H 2950 1450 50  0000 C CNN
F 1 "MUR1100" H 2950 1250 50  0000 C CNN
F 2 "" H 2950 1350 50  0001 C CNN
F 3 "" H 2950 1350 50  0001 C CNN
	1    2950 1350
	-1   0    0    1   
$EndComp
Text GLabel 3850 1350 2    60   Output ~ 0
170V
$Comp
L R R4
U 1 1 5A627AC2
P 3200 1650
F 0 "R4" V 3280 1650 50  0000 C CNN
F 1 "R" V 3200 1650 50  0000 C CNN
F 2 "" V 3130 1650 50  0001 C CNN
F 3 "" H 3200 1650 50  0001 C CNN
	1    3200 1650
	1    0    0    -1  
$EndComp
$Comp
L POT_TRIM 250k
U 1 1 5A627D7C
P 3200 2000
F 0 "250k" V 3025 2000 50  0000 C CNN
F 1 "R5" V 3100 2000 50  0000 C CNN
F 2 "" H 3200 2000 50  0001 C CNN
F 3 "" H 3200 2000 50  0001 C CNN
	1    3200 2000
	-1   0    0    1   
$EndComp
$Comp
L R R2
U 1 1 5A628073
P 2200 2150
F 0 "R2" V 2280 2150 50  0000 C CNN
F 1 "10k" V 2200 2150 50  0000 C CNN
F 2 "" V 2130 2150 50  0001 C CNN
F 3 "" H 2200 2150 50  0001 C CNN
	1    2200 2150
	1    0    0    -1  
$EndComp
$Comp
L R R3
U 1 1 5A62874F
P 2500 2150
F 0 "R3" V 2580 2150 50  0000 C CNN
F 1 "1k0" V 2500 2150 50  0000 C CNN
F 2 "" V 2430 2150 50  0001 C CNN
F 3 "" H 2500 2150 50  0001 C CNN
	1    2500 2150
	0    1    1    0   
$EndComp
$Comp
L C_Small C3
U 1 1 5A628C98
P 3700 1900
F 0 "C3" H 3710 1970 50  0000 L CNN
F 1 "100n" H 3710 1820 50  0000 L CNN
F 2 "" H 3700 1900 50  0001 C CNN
F 3 "" H 3700 1900 50  0001 C CNN
	1    3700 1900
	1    0    0    -1  
$EndComp
$Comp
L CP_Small C2
U 1 1 5A628DC5
P 3500 1900
F 0 "C2" H 3510 1970 50  0000 L CNN
F 1 "4u7" H 3510 1820 50  0000 L CNN
F 2 "" H 3500 1900 50  0001 C CNN
F 3 "" H 3500 1900 50  0001 C CNN
	1    3500 1900
	1    0    0    -1  
$EndComp
$Comp
L +12V #PWR?
U 1 1 5A629D01
P 950 3150
F 0 "#PWR?" H 950 3000 50  0001 C CNN
F 1 "+12V" H 950 3290 50  0000 C CNN
F 2 "" H 950 3150 50  0001 C CNN
F 3 "" H 950 3150 50  0001 C CNN
	1    950  3150
	1    0    0    -1  
$EndComp
$Comp
L L7805 U6
U 1 1 5A629D69
P 1450 3300
F 0 "U6" H 1300 3425 50  0000 C CNN
F 1 "7805" H 1450 3425 50  0000 L CNN
F 2 "" H 1475 3150 50  0001 L CIN
F 3 "" H 1450 3250 50  0001 C CNN
	1    1450 3300
	1    0    0    -1  
$EndComp
$Comp
L Earth #PWR?
U 1 1 5A629EE7
P 1600 4050
F 0 "#PWR?" H 1600 3800 50  0001 C CNN
F 1 "Earth" H 1600 3900 50  0001 C CNN
F 2 "" H 1600 4050 50  0001 C CNN
F 3 "" H 1600 4050 50  0001 C CNN
	1    1600 4050
	1    0    0    -1  
$EndComp
$Comp
L LF33_TO220 U7
U 1 1 5A629F2D
P 2550 3500
F 0 "U7" H 2400 3625 50  0000 C CNN
F 1 "LF33ABV" H 2550 3625 50  0000 L CNN
F 2 "TO_SOT_Packages_THT:TO-220_Vertical" H 2550 3725 50  0001 C CIN
F 3 "" H 2550 3450 50  0001 C CNN
	1    2550 3500
	1    0    0    -1  
$EndComp
Text GLabel 1950 3050 2    60   Output ~ 0
5V
$Comp
L C_Small C4
U 1 1 5A62A6BA
P 1100 3700
F 0 "C4" H 1110 3770 50  0000 L CNN
F 1 "100n" H 1110 3620 50  0000 L CNN
F 2 "" H 1100 3700 50  0001 C CNN
F 3 "" H 1100 3700 50  0001 C CNN
	1    1100 3700
	1    0    0    -1  
$EndComp
$Comp
L C_Small C5
U 1 1 5A62ABEF
P 1800 3750
F 0 "C5" H 1810 3820 50  0000 L CNN
F 1 "100n" H 1810 3670 50  0000 L CNN
F 2 "" H 1800 3750 50  0001 C CNN
F 3 "" H 1800 3750 50  0001 C CNN
	1    1800 3750
	1    0    0    -1  
$EndComp
$Comp
L C_Small C7
U 1 1 5A62AE84
P 2950 3750
F 0 "C7" H 2960 3820 50  0000 L CNN
F 1 "100n" H 2960 3670 50  0000 L CNN
F 2 "" H 2950 3750 50  0001 C CNN
F 3 "" H 2950 3750 50  0001 C CNN
	1    2950 3750
	1    0    0    -1  
$EndComp
$Comp
L CP_Small C6
U 1 1 5A62B0C6
P 2100 3750
F 0 "C6" H 2110 3820 50  0000 L CNN
F 1 "0u22" H 2110 3670 50  0000 L CNN
F 2 "" H 2100 3750 50  0001 C CNN
F 3 "" H 2100 3750 50  0001 C CNN
	1    2100 3750
	1    0    0    -1  
$EndComp
Text GLabel 3250 3500 2    60   Output ~ 0
3V
$Comp
L LED D2
U 1 1 5A62BC1E
P 7700 4850
F 0 "D2" H 7700 4950 50  0000 C CNN
F 1 " " H 7700 4750 50  0000 C CNN
F 2 "" H 7700 4850 50  0001 C CNN
F 3 "" H 7700 4850 50  0001 C CNN
	1    7700 4850
	0    -1   -1   0   
$EndComp
$Comp
L LED D3
U 1 1 5A62BDC0
P 7900 4850
F 0 "D3" H 7900 4950 50  0000 C CNN
F 1 " " H 7900 4750 50  0000 C CNN
F 2 "" H 7900 4850 50  0001 C CNN
F 3 "" H 7900 4850 50  0001 C CNN
	1    7900 4850
	0    -1   -1   0   
$EndComp
$Comp
L Earth #PWR?
U 1 1 5A62D0B2
P 7800 5150
F 0 "#PWR?" H 7800 4900 50  0001 C CNN
F 1 "Earth" H 7800 5000 50  0001 C CNN
F 2 "" H 7800 5150 50  0001 C CNN
F 3 "" H 7800 5150 50  0001 C CNN
	1    7800 5150
	1    0    0    -1  
$EndComp
Text Notes 7500 5400 0    60   ~ 0
Hr set LEDs
$Comp
L LED D4
U 1 1 5A62DF4A
P 8600 4850
F 0 "D4" H 8600 4950 50  0000 C CNN
F 1 " " H 8600 4750 50  0000 C CNN
F 2 "" H 8600 4850 50  0001 C CNN
F 3 "" H 8600 4850 50  0001 C CNN
	1    8600 4850
	0    -1   -1   0   
$EndComp
$Comp
L LED D5
U 1 1 5A62DF50
P 8800 4850
F 0 "D5" H 8800 4950 50  0000 C CNN
F 1 " " H 8800 4750 50  0000 C CNN
F 2 "" H 8800 4850 50  0001 C CNN
F 3 "" H 8800 4850 50  0001 C CNN
	1    8800 4850
	0    -1   -1   0   
$EndComp
$Comp
L Earth #PWR?
U 1 1 5A62DF56
P 8700 5150
F 0 "#PWR?" H 8700 4900 50  0001 C CNN
F 1 "Earth" H 8700 5000 50  0001 C CNN
F 2 "" H 8700 5150 50  0001 C CNN
F 3 "" H 8700 5150 50  0001 C CNN
	1    8700 5150
	1    0    0    -1  
$EndComp
Text Notes 8400 5400 0    60   ~ 0
Min set LEDs
$Comp
L LED D6
U 1 1 5A62E8DE
P 9500 4850
F 0 "D6" H 9500 4950 50  0000 C CNN
F 1 " " H 9500 4750 50  0000 C CNN
F 2 "" H 9500 4850 50  0001 C CNN
F 3 "" H 9500 4850 50  0001 C CNN
	1    9500 4850
	0    -1   -1   0   
$EndComp
$Comp
L LED D7
U 1 1 5A62E8E4
P 9700 4850
F 0 "D7" H 9700 4950 50  0000 C CNN
F 1 " " H 9700 4750 50  0000 C CNN
F 2 "" H 9700 4850 50  0001 C CNN
F 3 "" H 9700 4850 50  0001 C CNN
	1    9700 4850
	0    -1   -1   0   
$EndComp
$Comp
L Earth #PWR?
U 1 1 5A62E8EA
P 9600 5150
F 0 "#PWR?" H 9600 4900 50  0001 C CNN
F 1 "Earth" H 9600 5000 50  0001 C CNN
F 2 "" H 9600 5150 50  0001 C CNN
F 3 "" H 9600 5150 50  0001 C CNN
	1    9600 5150
	1    0    0    -1  
$EndComp
Text Notes 9350 5400 0    60   ~ 0
Colon LEDs
$Comp
L R_Small R6
U 1 1 5A62F34D
P 9600 4400
F 0 "R6" H 9630 4420 50  0000 L CNN
F 1 "110R" H 9630 4360 50  0000 L CNN
F 2 "" H 9600 4400 50  0001 C CNN
F 3 "" H 9600 4400 50  0001 C CNN
	1    9600 4400
	1    0    0    -1  
$EndComp
$Comp
L ZS-042 U8
U 1 1 5A6305CC
P 6200 950
F 0 "U8" H 6150 1150 50  0000 C CNN
F 1 "ZS-042" H 6200 1050 50  0000 C CNN
F 2 "" H 6200 1100 50  0001 C CNN
F 3 "" H 6200 1100 50  0001 C CNN
	1    6200 950 
	0    -1   -1   0   
$EndComp
Text GLabel 9600 4250 1    60   Input ~ 0
3V
Wire Wire Line
	5950 2300 6350 2300
Wire Wire Line
	6350 2300 6350 1750
Wire Wire Line
	6350 1750 6650 1750
Wire Wire Line
	5950 2100 6450 2100
Wire Wire Line
	6450 2100 6450 1950
Wire Wire Line
	6450 1950 6650 1950
Wire Wire Line
	5950 2200 6450 2200
Wire Wire Line
	6450 2200 6450 2250
Wire Wire Line
	6450 2250 6650 2250
Connection ~ 6500 1950
Wire Wire Line
	6500 1950 6500 3250
Wire Wire Line
	6500 3250 6650 3250
Wire Wire Line
	8050 2650 8050 2850
Wire Wire Line
	8050 2850 6650 2850
Wire Wire Line
	6650 2850 6650 3050
Wire Wire Line
	5950 3200 6300 3200
Wire Wire Line
	5950 2800 6100 2800
Wire Wire Line
	5950 2900 6200 2900
Wire Wire Line
	9100 1650 9200 1650
Wire Wire Line
	9100 2200 9100 2050
Wire Wire Line
	8800 1850 8800 1900
Wire Wire Line
	8800 2200 9100 2200
Wire Wire Line
	9200 1450 9100 1450
Wire Wire Line
	9100 1450 9100 1650
Wire Wire Line
	9500 1450 9800 1450
Wire Wire Line
	9800 1850 9800 1950
Wire Wire Line
	8450 1850 8500 1850
Wire Wire Line
	8050 3750 8350 3750
Wire Wire Line
	8350 3750 8350 3100
Wire Wire Line
	8350 3100 8500 3100
Wire Wire Line
	8050 3650 8400 3650
Wire Wire Line
	8400 3650 8400 3400
Wire Wire Line
	8400 3400 8500 3400
Wire Wire Line
	8050 3550 8300 3550
Wire Wire Line
	8300 3550 8300 3200
Wire Wire Line
	8300 3200 8500 3200
Wire Wire Line
	8050 3450 8250 3450
Wire Wire Line
	9900 3000 9950 3000
Wire Wire Line
	9900 3100 9950 3100
Wire Wire Line
	9900 3200 9950 3200
Wire Wire Line
	9900 3300 9950 3300
Wire Wire Line
	9900 3400 9950 3400
Wire Wire Line
	9900 3500 9950 3500
Wire Wire Line
	9900 3600 9950 3600
Wire Wire Line
	9900 3700 9950 3700
Wire Wire Line
	9900 3800 9950 3800
Wire Wire Line
	9900 3900 9950 3900
Wire Bus Line
	10050 2800 10050 3800
Wire Bus Line
	10050 2800 10200 2800
Wire Bus Line
	8200 1750 8200 2350
Wire Bus Line
	8200 1750 8350 1750
Wire Wire Line
	8050 2150 8100 2150
Wire Wire Line
	8050 2250 8100 2250
Wire Wire Line
	8050 2350 8100 2350
Wire Wire Line
	8050 2450 8100 2450
Wire Wire Line
	6100 2800 6100 3600
Wire Wire Line
	6200 2900 6200 3600
Wire Wire Line
	6300 3200 6300 3600
Wire Notes Line
	8350 1250 8350 2350
Wire Notes Line
	8350 1250 10200 1250
Wire Notes Line
	10200 1250 10200 2350
Wire Notes Line
	10200 2350 8350 2350
Wire Wire Line
	10100 1950 10300 1950
Wire Wire Line
	9800 1450 9800 1100
Connection ~ 8800 1850
Connection ~ 9100 2200
Connection ~ 9100 1650
Connection ~ 9800 1450
Wire Wire Line
	8900 2850 8900 2950
Wire Wire Line
	1700 2200 1700 2400
Connection ~ 1700 2300
Wire Wire Line
	1300 2000 1300 2300
Wire Wire Line
	1300 2300 1400 2300
Wire Wire Line
	1300 1400 1250 1400
Wire Wire Line
	1250 1400 1250 1150
Wire Wire Line
	2150 1600 2100 1600
Wire Wire Line
	2100 1400 2150 1400
Connection ~ 2150 1400
Wire Wire Line
	2150 1500 2300 1500
Connection ~ 2150 1500
Wire Wire Line
	2300 1200 2300 1150
Connection ~ 2300 1150
Wire Wire Line
	2800 1350 2700 1350
Connection ~ 2700 1350
Wire Wire Line
	3100 1350 3850 1350
Wire Wire Line
	2100 2000 3050 2000
Connection ~ 3000 2000
Wire Wire Line
	3200 2150 3000 2150
Wire Wire Line
	3000 2150 3000 2000
Connection ~ 2200 2000
Wire Wire Line
	1600 2300 3700 2300
Connection ~ 2200 2300
Wire Wire Line
	2700 2150 2650 2150
Wire Wire Line
	3200 1850 3200 1800
Wire Wire Line
	3200 1350 3200 1500
Connection ~ 3200 1350
Wire Wire Line
	3500 1350 3500 1800
Connection ~ 3500 1350
Wire Wire Line
	3700 1350 3700 1800
Connection ~ 3700 1350
Wire Wire Line
	1300 1600 1150 1600
Wire Wire Line
	1150 1600 1150 1050
Wire Wire Line
	900  1050 2150 1050
Wire Wire Line
	2150 1050 2150 1600
Wire Wire Line
	900  950  900  1050
Wire Wire Line
	950  3300 1150 3300
Wire Wire Line
	950  3300 950  3150
Wire Wire Line
	1450 3600 1450 4050
Connection ~ 1600 4050
Wire Wire Line
	1950 3050 1800 3050
Wire Wire Line
	1800 3050 1800 3650
Wire Wire Line
	1800 3300 1750 3300
Connection ~ 1800 3300
Wire Wire Line
	1800 3500 2250 3500
Wire Wire Line
	2550 4050 2550 3800
Wire Wire Line
	1100 4050 2950 4050
Wire Wire Line
	1100 3300 1100 3600
Connection ~ 1100 3300
Connection ~ 1450 4050
Wire Wire Line
	1100 3800 1100 4050
Connection ~ 1800 3500
Wire Wire Line
	1800 3850 1800 4050
Connection ~ 1800 4050
Wire Wire Line
	2100 3650 2100 3500
Connection ~ 2100 3500
Wire Wire Line
	2100 3850 2100 4050
Connection ~ 2100 4050
Wire Wire Line
	2850 3500 3250 3500
Wire Wire Line
	2950 3650 2950 3500
Connection ~ 2950 3500
Wire Wire Line
	2950 4050 2950 3850
Connection ~ 2550 4050
Wire Wire Line
	8500 3300 8250 3300
Wire Wire Line
	8250 3300 8250 3450
Wire Wire Line
	7700 4700 7700 4650
Wire Wire Line
	7900 4650 7900 4700
Wire Wire Line
	7700 5000 7700 5100
Wire Wire Line
	7700 5100 7900 5100
Wire Wire Line
	7900 5100 7900 5000
Wire Wire Line
	7700 4650 7900 4650
Wire Wire Line
	7800 5150 7800 5100
Connection ~ 7800 5100
Connection ~ 7800 4650
Wire Notes Line
	7500 4550 7500 5400
Wire Notes Line
	7500 4550 8050 4550
Wire Notes Line
	7500 5400 8050 5400
Wire Wire Line
	8600 4700 8600 4650
Wire Wire Line
	8800 4650 8800 4700
Wire Wire Line
	8600 5000 8600 5100
Wire Wire Line
	8600 5100 8800 5100
Wire Wire Line
	8800 5100 8800 5000
Wire Wire Line
	8600 4650 8800 4650
Wire Wire Line
	8700 5150 8700 5100
Connection ~ 8700 5100
Connection ~ 8700 4650
Wire Notes Line
	8400 4550 8400 5400
Wire Notes Line
	8400 4550 9000 4550
Wire Notes Line
	8400 5400 9000 5400
Wire Notes Line
	8050 5400 8050 4550
Wire Notes Line
	9000 5400 9000 4550
Wire Wire Line
	9500 4700 9500 4650
Wire Wire Line
	9700 4650 9700 4700
Wire Wire Line
	9500 5000 9500 5100
Wire Wire Line
	9500 5100 9700 5100
Wire Wire Line
	9700 5100 9700 5000
Wire Wire Line
	9500 4650 9700 4650
Wire Wire Line
	9600 5150 9600 5100
Connection ~ 9600 5100
Connection ~ 9600 4650
Wire Notes Line
	9300 4550 9300 5400
Wire Notes Line
	9300 4550 9900 4550
Wire Notes Line
	9300 5400 9900 5400
Wire Notes Line
	9900 5400 9900 4550
Wire Wire Line
	8050 3250 8200 3250
Wire Wire Line
	8200 3250 8200 4400
Wire Wire Line
	8200 4400 8700 4400
Wire Wire Line
	8700 4400 8700 4650
Wire Wire Line
	8050 3350 8150 3350
Wire Wire Line
	8150 3350 8150 4400
Wire Wire Line
	8150 4400 7800 4400
Wire Wire Line
	7800 4400 7800 4650
Wire Wire Line
	9600 4500 9600 4650
Wire Wire Line
	9600 4250 9600 4300
Wire Wire Line
	6100 1650 6100 2700
Wire Wire Line
	6100 2700 5950 2700
Wire Wire Line
	6200 1650 6200 2400
Wire Wire Line
	6200 2400 5950 2400
Connection ~ 1150 1050
Wire Wire Line
	6650 3550 6600 3550
Wire Wire Line
	6600 3550 6600 2250
Connection ~ 6600 2250
Wire Wire Line
	1250 1150 2400 1150
Wire Wire Line
	2700 1150 2700 1500
Wire Wire Line
	2400 1700 2250 1700
Wire Wire Line
	2250 1700 2250 1800
Wire Wire Line
	2250 1800 2100 1800
Wire Wire Line
	3700 2300 3700 2000
Wire Wire Line
	3500 2000 3500 2300
Connection ~ 3500 2300
Wire Wire Line
	2350 2150 2350 2300
Connection ~ 2350 2300
Wire Wire Line
	2700 2150 2700 1900
Text Notes 1100 4400 0    60   ~ 0
All ICs and modules are powered by 3V3\nunless otherwise noted.
$EndSCHEMATC
