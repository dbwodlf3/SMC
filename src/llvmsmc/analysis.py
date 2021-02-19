#!/usr/bin/env python3
import sys, os, time, argparse
import time

from ConstraintGenerator.Objects.ConstraintGenerator import ConstraintGenerator
from CubicSolver.Objects.CubicSolver import CubicSolver
from Detector.Objects.Detector import Detector

# CLI args Init
cli = argparse.ArgumentParser()
cli.add_argument('--ir', required=True, help="llvm ir file")
cli.add_argument('--bin', required=True, help="binary file of the ir file")
# cli.add_argument('--output', required=True, help="filename of the analysis result")
cli_args = cli.parse_args()

# User input
ir_file = cli_args.ir
bin_file = cli_args.bin

# generated files
cg_file = os.path.basename(cli_args.bin + '.cg')
cs_file = os.path.basename(cli_args.bin + '.cs')
de_file = os.path.basename(cli_args.bin + '.de')

def generate_constraint():
    start = time.time()

    # Read LL File and init
    constraint_generator = ConstraintGenerator(ir_file, bin_file)
    
    # Run
    constraint_generator.run()

    # save
    end = time.time()
    constraint_generator.saveJson(cg_file, end-start)

def cubicSolver():
    start = time.time()

    # Read Constraint File and init
    cubic_solver = CubicSolver(cg_file)
    
    # Run
    cubic_solver.run()

    # save
    end = time.time()
    cubic_solver.saveJson(cs_file)

def detect():
    start = time.time()

    # Read ir, cs, bin file and init
    detector = Detector(ir_file, cs_file, bin_file)

    # Run
    detector.run()

    # save
    end = time.time()
    detector.saveJson(de_file, end - start)


generate_constraint()
cubicSolver()
detect()