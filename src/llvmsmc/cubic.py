#!/usr/bin/env python3
import argparse
import time
from bitarray import bitarray
from CubicSolver.Objects.CubicSolver import CubicSolver

# @Todo eliminate cycle cycle.

start = time.time()

# Init
parser = argparse.ArgumentParser()
parser.add_argument('CONS', help='''Constraint Result File. json file.''')
parser.add_argument('RESULT_FILE', help='''filename to get result. json file.''')
# parser.add_argument('RESULT_FILE', help='''filename to get result.''')
args = parser.parse_args()

def main():
	cubic_solver = CubicSolver(args.CONS)
	cubic_solver.run()
	end = time.time()
	cubic_solver.saveJson(args.RESULT_FILE, end-start)





if __name__ == '__main__':
	main()
	end = time.time()
	print('실행시간: ', end-start)