from __future__ import print_function

import time

## Basic class describing a KiCad schematic
#
# Call get_sch() to get a string containing the entire schematic.
class KiSch(object):
    def __init__(self):
        self._kicad_version = "4.0.6"
        self._first_line = "EESchema Schematic File Version 2\n"
        self._libs = """LIBS:power
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
"""
        self.set_layers()
        self.set_descr()
        self._content = ""
        self.compString = ""

    def set_libs(self, libs):
        self._libs = libs

    def add_to_libs(self, alibs):
        self._libs += alibs

    def set_layers(self, l0=26, l1=0):
        self._layers = ("EELAYER %d %d\n" % (l0, l1)
                      + "EELAYER END\n"
                       )

    def set_descr(self, sheetid=1, sheettot=1, title="", date="", rev="0", comp="KiSch"):
        self._descr = ("$Descr USLedger 17000 11000\n"
                     + "encoding utf-8\n"
                     + "Sheet %d %d\n" % (sheetid, sheettot)
                     + "Title \"" + title + "\"\n"
                     + "Date \"" + date + "\"\n"
                     + "Rev \"" + rev + "\"\n"
                     + "Comp \"" + comp + "\"\n"
                     + "Comment1 \"\"\n"
                     + "Comment2 \"\"\n"
                     + "Comment3 \"\"\n"
                     + "Comment4 \"\"\n"
                     + "$EndDescr\n"
                      )

    def set_content(self, content):
        self._content = content

    ## @return A string that can be written to a .sch file
    def get_sch(self):
        self.compString = (self._first_line + self._libs + self._layers + self._descr
                           + self._content
                           + "$EndSCHEMATC\n")
        return self.compString

    def __str__(self):
        if len(self.compString) == 0:
            self.get_sch()
        return(self.compString)

## Text lable for marking nets
class KiSchLabel(object):
    ## @param [in] rot 0 - right, 1 - up, 2 - left, 3 - down
    def __init__(self, label="GND", loc=(0,0), rot=0):
        self.compString = ""
        self.label = label
        self.loc = loc
        self.rot = rot

    def get_comp(self):
        if len(self.label) > 0 :
            self.compString = (
                "Text Label {:d} {:d} {:d}    60   ~ 0\n".format(self.loc[0], self.loc[1], self.rot)
                + "{:s}\n".format(self.label)
            )
        else:
            self.compString = ("NoConn ~ {:d} {:d}\n".format(self.loc[0], self.loc[1]))
        return self.compString

    def __str__(self):
        if len(self.compString) == 0:
            self.get_comp()
        return(self.compString)
    
## Generic class describing a schematic component
#
class KiSchComp(object):
    ## Shared across all class objects to avoid duplicate time stamp.
    timeStamp = int(time.time())
    def __init__(self, npins=1):
        self.nPins = npins
        ## location to place the component
        self.loc = (0, 0)
        ## rotation, 'H' or 'V'
        self.rot = 'H'
        self.chipName = "R"
        self.refName = "R1"
        ## x,y offset and size, in mils
        self.refOffSize = (80, 0, 50)
        self.value = "DNL"
        self.valOffSize = (-100, 0, 50)
        self.footPrint = ""
        self.fpOffSize = (-70, 0, 50)
        self.compString = ""

    ## set x,y location
    def set_location(self, x, y):
        self.locX = x
        self.locY = y

    ## time stamp, hex format of seconds since 1970-01-01 00:00:00 UTC
    @staticmethod
    def get_timestamp():
        ts = "{:X}".format(KiSchComp.timeStamp)
        KiSchComp.timeStamp += 1
        return(ts)

    ## str(classobj) will return the representation string of the component
    def __str__(self):
        if len(self.compString) == 0:
            self.get_comp()
        return(self.compString)

## Schematic resistor
#
class KiSchCompR(KiSchComp):
    def __init__(self, ref="R1", loc=(0, 0), rot='H', val="DNL", fp="Resistors_SMD:R_0603_HandSoldering"):
        super(KiSchCompR, self).__init__(2)
        self.loc = loc
        self.rot = rot
        self.chipName = "R"
        self.refName = ref
        self.value = val
        self.footPrint = fp

    def get_comp(self):
        self.compString = """$Comp
L {:s} {:s}
U 1 1 {:s}
P {:d} {:d}
F 0 "{:s}" V {:d} {:d} {:d}  0000 C CNN
F 1 "{:s}" V {:d} {:d} {:d}  0000 C CNN
F 2 "{:s}" V {:d} {:d} {:d}  0001 C CNN
F 3 "" H {:d} {:d} {:d}  0001 C CNN
       1    {:d} {:d}
       {:s}
$EndComp
""".format(self.chipName, self.refName,
           self.get_timestamp(),
           self.loc[0], self.loc[1],
           self.refName, self.loc[0]+self.refOffSize[0], self.loc[1]+self.refOffSize[1], self.refOffSize[2],
           self.value, self.loc[0]+self.valOffSize[0], self.loc[1]+self.valOffSize[1], self.valOffSize[2],
           self.footPrint, self.loc[0]+self.fpOffSize[0], self.loc[1]+self.fpOffSize[1], self.fpOffSize[2],
           self.loc[0], self.loc[1], 50,
           self.loc[0], self.loc[1],
           ("0    -1   -1   0" if self.rot == 'H' else "1    0    0    -1")
)
        return(self.compString)

## Schematic Topmetal-S 1mm version
#
class KiSchCompTMS1mm(KiSchComp):
    ## @param[in] labels netname labels for every pin.
    def __init__(self, ref="U?", loc=(0, 0), rot='H', val="TMS1mm", fp="",
                 labels=["a{}".format(i+1) for i in xrange(50)]):
        super(KiSchCompTMS1mm, self).__init__(50)
        self.loc = loc
        self.rot = rot
        self.chipName = "TMS1mm"
        self.refName = ref
        self.value = val
        self.footPrint = fp
        self.labels = labels
        self.label_l0 = (-850, -1150)
        self.label_ldy = 100
        self.label_r0 = (850, 1250)
        self.label_rdy = -100

    def get_comp(self):
        self.refOffSize = (-50, 1400, 60)
        self.valOffSize = (0, -1300, 60)
        self.compString = """$Comp
L {:s} {:s}
U 1 1 {:s}
P {:d} {:d}
F 0 "{:s}" H {:d} {:d} {:d}  0000 C CNN
F 1 "{:s}" H {:d} {:d} {:d}  0000 C CNN
F 2 "{:s}" H {:d} {:d} {:d}  0000 C CNN
F 3 "" H {:d} {:d} {:d}  0000 C CNN
       0    {:d} {:d}
       {:s}
$EndComp
""".format(self.chipName, self.refName,
           self.get_timestamp(),
           self.loc[0], self.loc[1],
           self.refName, self.loc[0]+self.refOffSize[0], self.loc[1]+self.refOffSize[1], self.refOffSize[2],
           self.value, self.loc[0]+self.valOffSize[0], self.loc[1]+self.valOffSize[1], self.valOffSize[2],
           self.footPrint, self.loc[0]+self.fpOffSize[0], self.loc[1]+self.fpOffSize[1], self.fpOffSize[2],
           self.loc[0], self.loc[1], 50,
           self.loc[0], self.loc[1],
           ("0    -1   -1   0" if self.rot == 'V' else "1    0    0    -1")
)
        i = 0
        for l in self.labels[:24]:
            tl = KiSchLabel(l, (self.loc[0]+self.label_l0[0],
                                self.loc[1]+self.label_l0[1]+self.label_ldy*i), 2)
            i = i + 1
            self.compString += str(tl)
        i = 0
        for l in self.labels[24:]:
            tl = KiSchLabel(l, (self.loc[0]+self.label_r0[0],
                                self.loc[1]+self.label_r0[1]+self.label_rdy*i), 0)
            i = i + 1
            self.compString += str(tl)
        return(self.compString)

## Demo, two resistors and explicit net names, and a Topmetal-S
if __name__ == "__main__":
    import sys
    
    sch = KiSch()
    sch.set_descr(title="Python generated schematic with two resistors")
    sch.add_to_libs("LIBS:TMSch\n")

    R1loc = (8000, 5000)
    R2loc = (8000, 5500)
    R1 = KiSchCompR("R1", R1loc, val="100")
    R2 = KiSchCompR("R2", R2loc, val="1k")

    T1 = KiSchLabel("VDD", (R1loc[0]-150, R1loc[1]), 2)
    T2 = KiSchLabel("R12", (R1loc[0]+150, R1loc[1]), 0)
    T3 = KiSchLabel("R12", (R2loc[0]-150, R2loc[1]), 2)
    T4 = KiSchLabel("GND", (R2loc[0]+150, R2loc[1]), 0)

    U1 = KiSchCompTMS1mm("U1", (4650,4350), val="TMS1mm", fp="Topmetal:TMS1mm")
    sch.set_content(str(R1) + str(R2) + str(T1) + str(T2) + str(T3) + str(T4) + str(U1))

    with open(sys.argv[1], "w") as ofile:
        ofile.write(str(sch))
