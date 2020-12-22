#!/usr/bin/env python3
import os
import llvmlite.binding as llvmlite
import llvmlite.ir as ir
from lib.util import readModule
from lib.ffi import *

testfile_dir = os.path.join(os.path.dirname(__file__), 'testfiles')
testfile = os.path.join(os.path.join(testfile_dir, 'clang_m64_smc1.ll'))

if __name__ == "__main__":
    moduleRef1 = readModule(testfile)
    moduleRef2 = libc.giveName(moduleRef1)
    libc.dumpModule(moduleRef2)