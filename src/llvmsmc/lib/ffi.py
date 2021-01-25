# -*- coding: <utf-8> -*-

import ctypes
import sys, os

import llvmlite.binding as llvmlite

lib_path = os.path.join(os.path.dirname(os.path.dirname(__file__)), 'ffi')
util_so = os.path.join(lib_path, 'libutil.so')
_libc = ctypes.CDLL(util_so)

# =============================================================================
# Structures

class Answer(ctypes.Structure):
    _fields_ = [
        ('type', ctypes.c_int),
        ('pattern', ctypes.c_int),
        ('destName', ctypes.c_char_p)
    ]

class Stack(ctypes.Structure):
    _fields_ = [
        ('offset', ctypes.c_int)
    ]

class IntFail(ctypes.Structure):
    _fields_ = [
        ('value', ctypes.c_int),
        ('fail', ctypes.c_bool),
    ]

# =============================================================================
# Interfaces

class AliasIter:
    def __init__(self, moduleRef):
        self._iter = _libc.aliasIter(moduleRef)

    def __next__(self):
        next_item = _libc.aliasIterNext(self._iter)
        if next_item:
            return next_item
        else :
            raise StopIteration
    
    def __iter__(self):
        return self

class CustomAPI(object):
    @classmethod
    def giveName(cls, LLVMModuleRef):
        return _libc.giveName(LLVMModuleRef)

    @classmethod
    def getName(cls, LLVMValueRef):
        name = _libc.getName(LLVMValueRef)
        return name.decode('utf-8')

    @classmethod
    def getAliasIter(cls, ModuleRef):
        pass
    
    @classmethod
    def getConstantInt(cls, LLVMValueRef):
        return _libc.getConstantInt(LLVMValueRef)

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
    def isAlias(cls, LLVMValueRef):
        return _libc.isAlias(LLVMValueRef)
    
    @classmethod
    def wrapping(cls, LLVMValueRef):
        pass

    @classmethod
    def getStackOffset(cls, LLVMValueRef):
        return _libc.getStackOffset(LLVMValueRef)
class Detectors(object):
    @classmethod
    def StoreDetector(cls, LLVMModuleRef) -> Answer:
        return _libc.StoreDetector(LLVMModuleRef)
    @classmethod
    def CallDetector(cls, LLVMModuleRef) -> Answer:
        return _libc.CallDetector(LLVMModuleRef)
# =============================================================================
# Functions

def _make_opaque_ref(name):
    newcls = type(name, (ctypes.Structure,), {})
    return ctypes.POINTER(newcls)

# =============================================================================
# Obaque classes

LLVMAliasIterator = _make_opaque_ref("LLVMAliasIterator")


# =============================================================================
# Set function FFI

_libc.giveName.restype = llvmlite.ffi.LLVMModuleRef

_libc.getName.argtypes = [llvmlite.ffi.LLVMValueRef]
_libc.getName.restype = ctypes.c_char_p

_libc.aliasIter.argtypes = [llvmlite.ffi.LLVMModuleRef]
_libc.aliasIter.restype = LLVMAliasIterator

_libc.aliasIterNext.argtypes = [LLVMAliasIterator]
_libc.aliasIterNext.restype = llvmlite.ffi.LLVMValueRef

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

_libc.getConstantInt.argtypes = [llvmlite.ffi.LLVMValueRef]
_libc.getConstantInt.restype = IntFail

_libc.getStackOffset.argtypes = [llvmlite.ffi.LLVMValueRef]
_libc.getStackOffset.restype = ctypes.c_int

# =============================================================================
# Set Detectors FFI

_libc.StoreDetector.argtypes = [llvmlite.ffi.LLVMValueRef]
_libc.StoreDetector.restype = Answer

_libc.CallDetector.argtypes = [llvmlite.ffi.LLVMValueRef]
_libc.CallDetector.restype = Answer

# =============================================================================
# return libc
libc = CustomAPI()

test = _libc