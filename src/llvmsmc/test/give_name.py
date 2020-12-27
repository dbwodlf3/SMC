#!/usr/bin/env python3
import os
import llvmlite.binding as llvmlite
import llvmlite.ir as ir
from lib.util import readModule
from lib.ffi import *

testfile_dir = os.path.join(os.path.dirname(__file__), 'testfiles')
testfile = os.path.join(os.path.join(testfile_dir, 'x86_smc6.out.ll'))

if __name__ == "__main__":
    moduleRef = readModule(testfile)
    libc.giveName(moduleRef)
    # libc.dumpModule(moduleRef1)
    libc.dumpNameValues(moduleRef)