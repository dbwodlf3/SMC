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
    """This structure class is for detector.
    """
    _fields_ = [
        ('type', ctypes.c_int),
        ('pattern', ctypes.c_int),
        ('destName', ctypes.c_char_p)
    ]

class Stack(ctypes.Structure):
    """This structure class is for stack analysis.
    """
    _fields_ = [
        ('offset', ctypes.c_int)
    ]

class IntFail(ctypes.Structure):
    """This structure class is for ConstantInt
    """
    _fields_ = [
        ('value', ctypes.c_int),
        ('fail', ctypes.c_bool),
    ]

# =============================================================================
# Interfaces

class AliasIter:
    """This class is iterator for alias.
    """
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
    """Static class for FFI Interface.
    """

    @classmethod
    def giveName(cls, LLVMModuleRef):
        """Give name to LLVM IR.

        Parameters:
            LLVMModuleRef (llvmlite.ffi.ModuleRef)
        
        Returns:
            llvmlite.ffi.LLVMModuleRef
        """
        return _libc.giveName(LLVMModuleRef)

    @classmethod
    def getName(cls, LLVMValueRef):
        """Get name from wraped llvm ir value.

        Parameters:
            LLVMValueRef (llvmlite.ffi.LLVMValueRef)
        """
        name = _libc.getName(LLVMValueRef)
        return name.decode('utf-8')

    @classmethod
    def getAliasIter(cls, ModuleRef):
        pass
    
    @classmethod
    def getConstantInt(cls, LLVMValueRef):
        """Get if LLVMValueRef is ConstantInt then get structure including 
        integer value.

        Parameters:
            LLVMValueRef (llvmlite.ffi.LLVMValueRef)

        Returns:
            IntFail
        """
        return _libc.getConstantInt(LLVMValueRef)

    @classmethod
    def dumpModule(cls, LLVMModuleRef):
        """print module into stdout.

        Parameters:
            LLVMModuleRef (llvmlite.ffi.LLVMModuleRef)

        Returns:
            void
        """
        return _libc.dumpModule(LLVMModuleRef)

    @classmethod
    def isConstant(cls, LLVMValueRef):
        """If LLVMValueRef is Constant then return True else False.
        """
        return _libc.isConstant(LLVMValueRef)

    @classmethod
    def isConstantExpr(cls, LLVMValueRef):
        """If LLVMValueRef is ConstantExpr then return True else False.
        """
        return _libc.isConstantExpr(LLVMValueRef)

    @classmethod
    def isAlias(cls, LLVMValueRef):
        """If LLVMValueRef is Alias then return True else False.
        """
        return _libc.isAlias(LLVMValueRef)

    @classmethod
    def getStackOffset(cls, LLVMValueRef):
        """Return offset if LLVMValueRef is stack variable. or return 0.

        Parameters:
            LLVMValueRef (llvmlite.ffi.LLVMValueRef)
        Returns:
            int
        """
        return (cls._getStackOffset(LLVMValueRef) or 
                cls.getStackOffset2(LLVMValueRef) or
                cls.getStackOffset3(LLVMValueRef))

    @classmethod
    def _getStackOffset(cls, LLVMValueRef):
        """Inner function for getStackOffset
        """
        return _libc.getStackOffset(LLVMValueRef)

    @classmethod
    def getStackOffset2(cls, LLVMValueRef):
        """Inner function for getStackOffset
        """
        return _libc.getStackOffset2(LLVMValueRef)

    @classmethod
    def getStackOffset3(cls, LLVMValueRef):
        """Inner function for getStackOffset
        """
        return _libc.getStackOffset3(LLVMValueRef)

    @classmethod
    def testPrint(cls):
        return _libc.testPrint()

    @classmethod
    def dumpNameValues(cls, LLVMModuleRef):
        return _libc.dumpNameValues(LLVMModuleRef)

    @classmethod
    def wrapping(cls, LLVMValueRef):
        pass

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

_libc.getStackOffset2.argtypes = [llvmlite.ffi.LLVMValueRef]
_libc.getStackOffset2.restype = ctypes.c_int

_libc.getStackOffset3.argtypes = [llvmlite.ffi.LLVMValueRef]
_libc.getStackOffset3.restype = ctypes.c_int

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