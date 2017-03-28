## Basic class describing a KiCad schematic
#
# Call getSch() to get a string containing the entire schematic.
class KiSch:
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
        self.setLayers()
        self.setDescr()
        self._content = ""

    def setLibs(self, libs):
        self._libs = libs

    def setLayers(self, l0=25, l1=0):
        self._layers = ("EELAYER %d %d\n" % (l0, l1)
                      + "EELAYER END\n"
                       )

    def setDescr(self, sheetid=1, sheettot=1, title="", date="", rev="0", comp="KiSch"):
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

    def getSch(self):
        return (self._first_line + self._libs + self._layers + self._descr
                + self._content
                + "$EndSCHEMATC\n")
