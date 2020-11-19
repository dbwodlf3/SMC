#!/usr/bin/env python3
import argparse
import llvmlite.ir as ir
import llvmlite.binding as llvm
from Detector.lib.util import readModule, giveName, readJson
from Detector.Objects.Detector import Detector
# from Objects.CriticalDetector import CriticalDetector

# Init
parser = argparse.ArgumentParser()
parser.add_argument('LLVM_IR', help='''LLVM IR File. bc or ll file.''')
parser.add_argument('VARIABLES', help='''file of CubicSolver. json file.''')
parser.add_argument('RESULT_FILE', help='''filename to get result.''')
args = parser.parse_args()

def main():
	module = readModule(args.LLVM_IR)
	ir_module = giveName(module)
	variables = readJson(args.VARIABLES)
	detector = Detector(module, ir_module, variables)
	detector.run()
	print(detector.criticalInstructions)
	# for var_name in detector.variables :
	# 	print(detector.variables[var_name])

if __name__ == '__main__':
	main()