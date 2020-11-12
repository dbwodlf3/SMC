#!/usr/bin/python3.8
import os, sys, argparse
import llvmlite.binding as llvm
from Objects.ConstraintGenerator import ConstraintGenerator
from Objects.BasicConstraint import *

# Init
parser = argparse.ArgumentParser()
parser.add_argument('LLVM_IR', help='''LLVM IR File. bc or ll file.''')
args = parser.parse_args()

def main():
	# Read LL File
	constraint_generator = ConstraintGenerator(args.LLVM_IR)
	# Add Constraint
	constraint_generator.addConstraint(AllocaConstraint)
	constraint_generator.addConstraint(IntToPtrConstraint)
	constraint_generator.addConstraint(BitCastConstraint)
	constraint_generator.addConstraint(PHIConstraint)
	constraint_generator.addConstraint(SelectConstraint)
	constraint_generator.addConstraint(ExtractvalueConstraint)
	constraint_generator.addConstraint(StoreConstraint)
	constraint_generator.addConstraint(LoadConstraint)
	constraint_generator.addConstraint(GetElementPtrConstraint)
	constraint_generator.addConstraint(CallConstraint)
	
	constraint_generator.run()
	# Print Constraints result
	pass













if __name__ == '__main__':
	main()