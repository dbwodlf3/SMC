#!/usr/bin/python3.8
import time
import argparse
import llvmlite.ir as ir
from pprint import pprint
from ConstraintGenerator.Objects.ConstraintGenerator import ConstraintGenerator

# Init
parser = argparse.ArgumentParser()
parser.add_argument('LLVM_IR', help='''LLVM IR File. bc or ll file.''')
parser.add_argument('RESULT_FILE', help='''filename to get result.''')
args = parser.parse_args()

def main():
    start = time.time()
    # Read LL File and init
    constraint_generator = ConstraintGenerator(args.LLVM_IR)

    # Run
    constraint_generator.run()

    # Save result
    end = time.time()
    
    constraint_generator.saveJson(args.RESULT_FILE, end-start)







if __name__ == '__main__':
    main()