from __future__ import print_function
import time, math

# Length unit in .kicad_mod is [mm]

## Base class of PCB footprint as a .kicad_mod file
#
class KiPcbFp(object):
    ## Shared across all class objects to avoid duplicate time stamp.
    timeStamp = int(time.time())
    def __init__(self, name="KiPcbFp", layer="F.Cu"):
        ## default line width
        self.linew = 0.15
        ## default font size
        self.fonts = (1,1)
        self.name = name
        self.layer = layer
        self.fpString= ""

    ## time stamp, hex format of seconds since 1970-01-01 00:00:00 UTC
    @staticmethod
    def get_timestamp():
        ts = "{:X}".format(KiPcbFp.timeStamp)
        KiPcbFp.timeStamp += 1
        return(ts)

    def add_text(self, field="reference", val="REF**", loc=(0,0), rot=90, layer="F.SilkS"):
        self.fpString += """  (fp_text {:s} {:s} (at {:g} {:g} {:d}) (layer {:s})
    (effects (font (size {:d} {:d}) (thickness {:g})))
  )
""".format(field, val, loc[0], loc[1], rot, layer, self.fonts[0], self.fonts[1], self.linew)
        return self.fpString

    def add_line(self, start=(0.0,0.0), end=(0.0,0.0), layer="F.SilkS", width=0.15):
        self.fpString += "  (fp_line (start {:g} {:g}) (end {:g} {:g}) (layer {:s}) (width {:g}))\n".format(start[0], start[1], end[0], end[1], layer, width)
        return(self.fpString)

    def add_pad(self, i=1, style="thru_hole", shape="rect", loc=(0,0), rot=0, size=(1,2), drill=0.8, layers="*.Cu *.Mask"):
        if style != "smd":
            self.fpString += "  (pad {:d} {:s} {:s} (at {:g} {:g} {:d}) (size {:g} {:g}) (drill {:g}) (layers {:s}))\n".format(i, style, shape, loc[0], loc[1], rot, size[0], size[1], drill, layers)
        else:
            self.fpString += "  (pad {:d} {:s} {:s} (at {:g} {:g} {:d}) (size {:g} {:g}) (layers {:s}))\n".format(i, style, shape, loc[0], loc[1], rot, size[0], size[1], layers)
        return(self.fpString)

    ## str(classobj) will return the representation string of the footprint
    def __str__(self):
        if len(self.fpString) == 0:
            self.get_footprint()
        self.fpString += ")\n"
        return(self.fpString)

## Topmetal-S 1mm version bonding footprint
class TMS1mmFP(KiPcbFp):
    def __init__(self):
        super(TMS1mmFP, self).__init__(name="TMS1mm")
        ## Topmetal chip width and height
        self.tmdim = (1.92, 2.92)
        ## Topmetal chip bonding pad dimension (w, h)
        self.tmbpdim = (0.116, 0.072)
        ## Topmetal electrode diameter
        self.tmdia = 1.0
        ## Topmetal electrode center, using chip's horizontal lower-left as (0,0)
        self.tmcenter = (0.627175, 0.978525)
        ## size of unit cell = pitch between adjacent chips [mm]
        self.ucelld = 8.0
        ## unit cell border [mm]
        self.ucellb = 0.1
        ## bonding pcb pad dimension [mm]
        self.bpdim = (4 * 0.0254, 10 * 0.0254)
        ## separation from chip
        self.bpsep = 1.4
        ## pitch between pads
        self.bpp = 9.2 * 0.0254
        ## pitch between rows
        self.bprp = 26 * 0.0254
        ## via size
        self.viasize = (14 * 0.0254, 14 * 0.0254)
        ## via drill
        self.viadrill = 8 * 0.0254
        ## via pitch
        self.viap = 24 * 0.0254
        ## via separation between rows
        self.viasep = 25 * 0.0254

    def draw_chip_bonding_pads(self, lw=0.01):
        self.padsLoc = [
            [136.6   , 85  ],
            [238.65  , 85  ],
            [339.45  , 85  ],
            [448.75  , 85  ],
            [558.05  , 85  ],
            [658.85  , 85  ],
            [759.65  , 85  ],
            [860.45  , 85  ],
            [1039.65 , 85  ],
            [1140.45 , 85  ],
            [1241.25 , 85  ],
            [1342.05 , 85  ],
            [1453.00 , 85  ],
            [1553.8  , 85  ],
            [1654.6  , 85  ],
            [1833.8  , 85  ],
            [1979.4  , 85  ],
            [2090.2  , 85  ],
            [2191.0  , 85  ],
            [2301.8  , 85  ],
            [2447.4  , 85  ],
            [2558.2  , 85  ],
            [2692.6  , 85  ],
            [2793.4  , 85  ],
            [2793.4  , 1835],
            [2684.1  , 1835],
            [2577.5  , 1835],
            [2470.9  , 1835],
            [2361.6  , 1835],
            [2260.8  , 1835],
            [2151.5  , 1835],
            [2042.2  , 1835],
            [1941.4  , 1835],
            [1840.6  , 1835],
            [1739.8  , 1835],
            [1639    , 1835],
            [1538.2  , 1835],
            [1349    , 1835],
            [1248.2  , 1835],
            [1157.4  , 1835],
            [1056.6  , 1835],
            [955.8   , 1835],
            [855     , 1835],
            [754.2   , 1835],
            [653.4   , 1835],
            [552.6   , 1835],
            [443.3   , 1835],
            [336.7   , 1835],
            [227.4   , 1835],
            [126.6   , 1835]
        ]
        for xy in self.padsLoc:
            # in KiCad, y axis grows downwards
            # x and y are swapped to draw the chip vertically
            x = xy[1]/1000.0 - self.tmcenter[1] # self.tmdim[0]/2.0
            y = xy[0]/1000.0 - self.tmcenter[0] # self.tmdim[1]/2.0

            self.add_line((x - self.tmbpdim[0]/2.0, y - self.tmbpdim[1]/2.0),
                          (x + self.tmbpdim[0]/2.0, y - self.tmbpdim[1]/2.0), width=lw)
            self.add_line((x + self.tmbpdim[0]/2.0, y - self.tmbpdim[1]/2.0),
                          (x + self.tmbpdim[0]/2.0, y + self.tmbpdim[1]/2.0), width=lw)
            self.add_line((x + self.tmbpdim[0]/2.0, y + self.tmbpdim[1]/2.0),
                          (x - self.tmbpdim[0]/2.0, y + self.tmbpdim[1]/2.0), width=lw)
            self.add_line((x - self.tmbpdim[0]/2.0, y + self.tmbpdim[1]/2.0),
                          (x - self.tmbpdim[0]/2.0, y - self.tmbpdim[1]/2.0), width=lw)
        # draw topmetal electrode
        corners = [[ math.sqrt(3.0)/4.0, 0.25], [0, 0.5], [-math.sqrt(3.0)/4.0, 0.25],
                   [-math.sqrt(3.0)/4.0,-0.25], [0,-0.5], [ math.sqrt(3.0)/4.0,-0.25],
                   [ math.sqrt(3.0)/4.0, 0.25]]
        for i in xrange(len(corners)-1):
            self.add_line(corners[i], corners[i+1], width=lw*2)
        # draw chip outline
        corners = [[-self.tmcenter[1],-self.tmcenter[0]],
                   [-self.tmcenter[1]+self.tmdim[0], -self.tmcenter[0]],
                   [-self.tmcenter[1]+self.tmdim[0], -self.tmcenter[0]+self.tmdim[1]],
                   [-self.tmcenter[1], -self.tmcenter[0]+self.tmdim[1]],
                   [-self.tmcenter[1],-self.tmcenter[0]]]
        for i in xrange(len(corners)-1):
            self.add_line(corners[i], corners[i+1], width=0.1)

        return self.fpString

    def get_footprint(self):
        self.fpString = "(module {:s} (layer {:s}) (tedit {:s})\n".format(
            self.name, self.layer, self.get_timestamp())
        # add ref
        self.add_text(loc=(0,3.4), rot=0)
        # add val to fab
        self.add_text("value", "TMS1mm", loc=(0,0), rot=0, layer="F.Fab")
        # draw chip with bonding pads
        self.draw_chip_bonding_pads()
        # draw hexagonal unit cell outline
        corners = [[ 1.0/math.sqrt(3.0),0], [ 0.5/math.sqrt(3.0), 0.5], [-0.5/math.sqrt(3.0), 0.5],
                   [-1.0/math.sqrt(3.0),0], [-0.5/math.sqrt(3.0),-0.5], [ 0.5/math.sqrt(3.0),-0.5],
                   [ 1.0/math.sqrt(3.0),0]]
        for i in xrange(len(corners)-1):
            self.add_line([x*(self.ucelld-self.ucellb) for x in corners[i]],
                          [x*(self.ucelld-self.ucellb) for x in corners[i+1]], "F.SilkS", 0.05)
            # "F.CrtYd"
        # bonding pads
        loc0 = (-self.tmdim[0]/2.0 - self.bpsep, - self.tmcenter[0])
        for i in xrange(24):
            if i % 2 == 0:
                loc = (loc0[0], loc0[1] + self.bpp * i/2.0)
            else:
                loc = (loc0[0] - self.bprp, loc0[1] + self.bpp * i/2.0)
            self.add_pad(i+1, style="smd", loc=loc, rot=90, size=self.bpdim,layers="F.Cu F.Mask")

        loc0 = (self.tmdim[0]/2.0 + self.bpsep, - self.tmcenter[0])
        for i in xrange(26):
            if i % 2 == 0:
                loc = (loc0[0], loc0[1] + self.bpp * i/2.0)
            else:
                loc = (loc0[0] + self.bprp, loc0[1] + self.bpp * i/2.0)
            self.add_pad(50-i, style="smd", loc=loc, rot=90, size=self.bpdim,layers="F.Cu F.Mask")
        # via pads
        padIdList = [2, 16, 14, 4, 35, 27, 1, 3, 13, 32, 33, 34, 17, 18, 21, 22, 23, 24, 25, 19, 20, 48]
        loc0 = (-self.viasep/2.0, -3.0)
        loc1 = (self.viasep/2.0,  -3.0)
        for i in xrange(len(padIdList)):
            if i%2 == 0:
                loc = (loc0[0], loc0[1] + self.viap * i/2)
            else:
                loc = (loc1[0], loc1[1] + self.viap * int(i/2))
            self.add_pad(padIdList[i], shape="circle", loc=loc, size=self.viasize,
                         drill=self.viadrill, layers="*.Cu")

# Example
if __name__ == '__main__':
    tms1mmfp = TMS1mmFP()
    print(str(tms1mmfp))
