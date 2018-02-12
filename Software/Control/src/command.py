from __future__ import print_function
from __future__ import division
from ctypes import *
import socket

class Cmd(object):
    soname = "./build/command.so"
    nmax = 20000

    def __init__(self):
        self.cmdGen = cdll.LoadLibrary(self.soname)
        self.buf = create_string_buffer(self.nmax)

    def send_pulse(self, mask):
        cfun = self.cmdGen.cmd_send_pulse
        buf = addressof(self.buf)
        n = cfun(byref(c_void_p(buf)), c_uint(mask))
        return self.buf.raw[0:n]

    def read_status(self, addr):
        cfun = self.cmdGen.cmd_read_status
        buf = addressof(self.buf)
        n = cfun(byref(c_void_p(buf)), c_uint(addr))
        return self.buf.raw[0:n]

    def write_memory(self, addr, aval):
        cfun = self.cmdGen.cmd_write_memory
        buf = addressof(self.buf)
        nval = len(aval)
        n = cfun(byref(c_void_p(buf)), c_uint(addr), (c_uint32 * nval)(*aval), c_size_t(nval))
        return self.buf.raw[0:n]

    def write_file_to_memory(self, fName):
        cfun = self.cmdGen.cmd_write_file_to_memory
        buf = addressof(self.buf)
        n = cfun(byref(c_void_p(buf)), c_char_p(fName))
        return self.buf.raw[0:n]

    def read_memory(self, addr, val):
        cfun = self.cmdGen.cmd_read_memory
        buf = addressof(self.buf)
        n = cfun(byref(c_void_p(buf)), c_uint(addr), c_uint(val))
        return self.buf.raw[0:n]

    def write_register(self, addr, val):
        cfun = self.cmdGen.cmd_write_register
        buf = addressof(self.buf)
        n = cfun(byref(c_void_p(buf)), c_uint(addr), c_uint(val))
        return self.buf.raw[0:n]

    def read_register(self, addr):
        cfun = self.cmdGen.cmd_read_register
        buf = addressof(self.buf)
        n = cfun(byref(c_void_p(buf)), c_uint(addr))
        return self.buf.raw[0:n]

    ## Generate command for reading data from datafifo
    # @param[in] val number of 32-bit words (val+1) to read
    #
    def read_datafifo(self, val):
        cfun = self.cmdGen.cmd_read_datafifo
        buf = addressof(self.buf)
        n = cfun(byref(c_void_p(buf)), c_uint(val))
        return self.buf.raw[0:n]

    ## Acquire data from datafifo
    # @param[in] s an established socket for IO
    # @param[in] nWords number of 32-bit words to read
    # @param[in] buf a bytearray.  If buf is given, recv_into() this buf is used and buf is returned
    #
    def acquire_from_datafifo(self, s, nWords, buf=None, recvFlags=socket.MSG_WAITALL):
        nWordsBatchMax = 65536
        if nWords < 1:
            return []
        nRounds    = int(nWords / nWordsBatchMax)
        nRemainder = nWords % nWordsBatchMax
        if buf:
            mv = memoryview(buf)
        ret = ""
        for iBatch in range(nRounds):
            cmdStr = self.read_datafifo(nWordsBatchMax-1)
            s.sendall(cmdStr)
            toRead = nWordsBatchMax * 4
            if buf:
                while toRead:
                    nBytes = s.recv_into(mv, toRead)
                    mv = mv[nBytes:]
                    toRead -= nBytes
            else:
                ret = ret + s.recv(toRead, recvFlags)
        #
        if nRemainder == 0:
            if buf:
                return buf
            else:
                return ret
        # else
        cmdStr = self.read_datafifo(nRemainder-1)
        s.sendall(cmdStr)
        toRead = nRemainder * 4
        if buf:
            while toRead:
                nBytes = s.recv_into(mv, toRead)
                mv = mv[nBytes:]
                toRead -= nBytes
            return buf
        else:
            ret = ret + s.recv(toRead, recvFlags)
            return ret

if __name__ == "__main__":
    cmd = Cmd()
    ret = cmd.write_register(1, 0x5a5a)
    print([hex(ord(s)) for s in ret])
