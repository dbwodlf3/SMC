# -*- coding: <utf-8> -*-

import ctypes
import sys, os

import llvmlite.binding as llvmlite

lib_path = os.path.join(os.path.dirname(os.path.dirname(__file__)), 'ffi')
util_so = os.path.join(lib_path, 'libutil.so')
_libc = ctypes.CDLL(util_so)

def make_opaque_ref(name):
    newcls = type(name, (ctypes.Structure,), {})
    return ctypes.POINTER(newcls)

class CustomAPI(object):
    def giveName(self, LLVMModuleRef):
        return _libc.giveName(LLVMModuleRef)
    def dumpModule(self, LLVMModuleRef):
        return _libc.dumpModule(LLVMModuleRef)
    def testPrint(self):
        return _libc.testPrint()

# =============================================================================
# Set function FFI

_libc.giveName.restype = llvmlite.ffi.LLVMModuleRef

_libc.dumpModule.argtypes = [llvmlite.ffi.LLVMModuleRef]

# =============================================================================
# return libc
libc = CustomAPI()