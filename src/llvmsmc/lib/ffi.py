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

    def dumpNameValues(self, LLVMModuleRef):
        return _libc.dumpNameValues(LLVMModuleRef)

    def isConstant(self, LLVMValueRef):
        return _libc.isConstant(LLVMValueRef)

    def isConstantExpr(self, LLVMValueRef):
        return _libc.isConstantExpr(LLVMValueRef)


# =============================================================================
# Set function FFI

_libc.giveName.restype = llvmlite.ffi.LLVMModuleRef

_libc.dumpModule.argtypes = [llvmlite.ffi.LLVMModuleRef]

_libc.dumpNameValues.argtypes = [llvmlite.ffi.LLVMModuleRef]

_libc.isConstant.argtypes = [llvmlite.ffi.LLVMValueRef]
_libc.isConstant.restype = ctypes.c_bool

_libc.isConstantExpr.argtypes = [llvmlite.ffi.LLVMValueRef]
_libc.isConstantExpr.restype = ctypes.c_bool

# =============================================================================
# return libc
libc = CustomAPI()