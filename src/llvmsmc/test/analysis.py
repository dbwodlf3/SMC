#!/usr/bin/env python3
import sys, os, time, argparse
from multiprocessing import Process
from ConstraintGenerator.Objects.ConstraintGenerator import ConstraintGenerator
from CubicSolver.Objects.CubicSolver import CubicSolver
from Detector.Objects.Detector import Detector

cmd = argparse.ArgumentParser()
cmd.add_argument('BINARY_FILE', help='''filename of binary''')
cmd.add_argument('LLVM_IR', help='''LLVM IR File. bc or ll file.''')
cmd.add_argument('RESULT_FILE', help='''filename to get result.''')
args = cmd.parse_args()

def constraintGenerator(irFIle, binaryFile):
    cg = ConstraintGenerator(irFIle, binaryFile)
    
    start = time.time()
    cg.run()
    end = time.time()

    cg.saveJson('./test.cg.json', end - start)

def andersen():
    cs = CubicSolver('./test.cg.json')
    
    start = time.time()
    cs.run()
    end = time.time()

    cs.saveJson('./test.cs.json', end - start)

def detect():
    de = Detector(args.LLVM_IR, './test.cs.json', args.BINARY_FILE)

    start = time.time()
    de.run()
    end = time.time()
    de.saveJson('./test.de.json', end-start)

def main():
    constraintGenerator()
    andersen()
    detect()