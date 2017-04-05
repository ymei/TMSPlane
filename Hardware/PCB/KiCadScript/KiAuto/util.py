## \file
# Utility routines.
#

import pcbnew
## 1nm is the smallest dimension in KiCAD
_SCALE = 1000000.0

## convert x in [mm] to native scale
def mm(x):
    return int(_SCALE * x)
   #return pcbnew.FromMM(x)

## convert x in [mil] to native scale
def mil(x):
    return int(_SCALE * 25.4 * x / 1000.0)
   #return pcbnew.FromMils(x)
