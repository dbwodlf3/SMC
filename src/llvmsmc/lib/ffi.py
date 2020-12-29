# -*- coding: <utf-8> -*-

import ctypes
import sys, os

import llvmlite.binding as llvmlite

lib_path = os.path.join(os.path.dirname(os.path.dirname(__file__)), 'ffi')
util_so = os.path.join(lib_path, 'libutil.so')
_libc = ctypes.CDLL(util_so)

class Answer(ctypes.Structure):
    _fields_ = [
        ('type', ctypes.c_int),
        ('pattern', ctypes.c_int),
        ('destName', ctypes.c_char_p)
    ]

class CustomAPI(object):
    @classmethod
    def giveName(cls, LLVMModuleRef):
        return _libc.giveName(LLVMModuleRef)

    @classmethod
    def dumpModule(cls, LLVMModuleRef):
        return _libc.dumpModule(LLVMModuleRef)

    @classmethod
    def testPrint(cls):
        return _libc.testPrint()

    @classmethod
    def dumpNameValues(cls, LLVMModuleRef):
        return _libc.dumpNameValues(LLVMModuleRef)

    @classmethod
    def isConstant(cls, LLVMValueRef):
        return _libc.isConstant(LLVMValueRef)

    @classmethod
    def isConstantExpr(cls, LLVMValueRef):
        return _libc.isConstantExpr(LLVMValueRef)

    @classmethod
    def isConstantExpr(cls, LLVMValueRef, instruction):
        pass

    @classmethod
    def isAlias(cls, LLVMValueRef):
        return _libc.isAlias(LLVMValueRef)
    
    @classmethod
    def wrapping(cls, LLVMValueRef):
        pass

class Detectors(object):
    @classmethod
    def StoreDetector(cls, LLVMModuleRef) -> Answer:
        return _libc.StoreDetector(LLVMModuleRef)
# =============================================================================
# Set function FFI

_libc.giveName.restype = llvmlite.ffi.LLVMModuleRef

_libc.dumpModule.argtypes = [llvmlite.ffi.LLVMModuleRef]

_libc.dumpNameValues.argtypes = [llvmlite.ffi.LLVMModuleRef]

_libc.isConstant.argtypes = [llvmlite.ffi.LLVMValueRef]
_libc.isConstant.restype = ctypes.c_bool

_libc.isConstantExpr.argtypes = [llvmlite.ffi.LLVMValueRef]
_libc.isConstantExpr.restype = ctypes.c_bool

_libc.isConstantExpr.argtypes = [llvmlite.ffi.LLVMValueRef, ctypes.c_char_p]
_libc.isConstantExpr.restype = ctypes.c_bool

_libc.isAlias.argtypes = [llvmlite.ffi.LLVMValueRef]
_libc.isAlias.restype = ctypes.c_bool

_libc.StoreDetector.argtypes = [llvmlite.ffi.LLVMValueRef]
_libc.StoreDetector.restype = Answer

# =============================================================================
# return libc
libc = CustomAPI()

test = _libc