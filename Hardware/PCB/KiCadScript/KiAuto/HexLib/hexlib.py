#
# run the following before importing this module:
#
# cd KiAuto/hexlib/
# python setup.py build
# cd build
# ln -s lib.freebsd-11.0-STABLE-amd64-2.7/hexlib.so .
#
from __future__ import print_function
from ctypes import *
import os

## hexagonal grid coordinate handling
class Hex:
    soname = "./build/hexlib.so"

    def __init__(self):
        dirname = os.path.dirname(__file__)
        if len(dirname):
            dirname += "/"
        soname = dirname + self.soname
        self.hexLib = cdll.LoadLibrary(soname)

    ## Map axial coordinates (q,r) to Cartesian coordinates (x,y).
    # @param [in] p pitch
    # @param [in] qr (q, r)
    # @return xy (x, y)
    def qr2xy(self, p, qr):
        cfun = self.hexLib.hex_qr2xy
        x = c_double()
        y = c_double()
        cfun(c_double(p), c_int(qr[0]), c_int(qr[1]), byref(x), byref(y))
        return((x.value, y.value))

    ## Map axial coordinates (q,r) to spiral coordinates l.
    def qr2l(self, qr):
        cfun = self.hexLib.hex_qr2l
        l = cfun(c_int(qr[0]), c_int(qr[1]))
        return l

    ## Map spiral coordinate to axial coordinates (q,r)
    def l2qr(self, l):
        cfun = self.hexLib.hex_l2qr
        q = c_int()
        r = c_int()
        cfun(c_int(l), byref(q), byref(r))
        return((q.value, r.value))
    
    ## Map Cartesian coordinates (x,y) to hex axial coordinates (q,r).
    def xy2qr(self, p, xy):
        cfun = self.hexLib.hex_xy2qr
        q = c_int()
        r = c_int()
        cfun(c_double(p), c_double(xy[0]), c_double(xy[1]), byref(q), byref(r))
        return((q.value, r.value))

if __name__ == "__main__":
    p = 2.0
    q = 3
    r = 5
    hex = Hex()
    xy = hex.qr2xy(p, (q, r))
    print(xy)
    l = hex.qr2l((q, r))
    print(l)
    qr = hex.l2qr(l)
    print(qr)
    qr = hex.xy2qr(p, xy)
    print(qr)
