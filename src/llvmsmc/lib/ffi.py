import ctypes
import os

lib_path = os.path.join(os.path.dirname(os.path.dirname(__file__)), 'ffi')
util_so = os.path.join(lib_path, 'libutil.so')
_libc = ctypes.CDLL(util_so)

def make_opaque_ref(name):
    newcls = type(name, (ctypes.Structure,), {})
    return ctypes.POINTER(newcls)

class CustomAPI(object):
    def giveName(self, LLVMModuleRef):
        return _libc.giveName(LLVMModuleRef)
    def readFromLL(self, filename):
        return _libc.readFromLL(filename.encode('utf-8'))

# =============================================================================
# Set function FFI

LLVMModuleRef = make_opaque_ref('LLVMModule')

_libc.readFromLL.argtypes = [LLVMModuleRef]
_libc.readFromLL.argtypes = [ctypes.c_char_p]

# =============================================================================
# return libc
libc = CustomAPI()