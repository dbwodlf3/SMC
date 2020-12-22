#!/usr/bin/env python3
import os
from lib.ffi import *

testfile_dir = os.path.join(os.path.dirname(__file__), 'testfiles')
testfile = os.path.join(os.path.join(testfile_dir, 'clang_m64_smc1.ll'))

if __name__ == "__main__":
    libc.readFromLL(testfile)