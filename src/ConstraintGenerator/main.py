#!/usr/bin/python3.8
import sys
import argparse
import llvmlite.ir as ir
from pprint import pprint
from lib.util import readModule, giveName
from Objects.ConstraintGenerator import ConstraintGenerator
from Objects.BasicConstraint import *

# Init
parser = argparse.ArgumentParser()
parser.add_argument('LLVM_IR', help='''LLVM IR File. bc or ll file.''')
parser.add_argument('RESULT_FILE', help='''filename to get result.''')
args = parser.parse_args()

def main():
    # Read LL File and init
    module = readModule(args.LLVM_IR)
    ir_module = giveName(module)
    constraint_generator = ConstraintGenerator(module, ir_module)

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
    # constraint_generator.addConstraint(CallConstraint)

    # Run
    constraint_generator.run()

    # Save result
    constraint_generator.saveJson(args.RESULT_FILE)








if __name__ == '__main__':
    main()