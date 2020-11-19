#!/usr/bin/env python3
import argparse
import time
from bitarray import bitarray
from lib import util
from Objects.CubicSolver import CubicSolver

# @Todo eliminate cycle cycle.

start = time.time()

# Init
parser = argparse.ArgumentParser()
parser.add_argument('CONS', help='''Constraint Result File. json file.''')
parser.add_argument('RESULT_FILE', help='''filename to get result. json file.''')
# parser.add_argument('RESULT_FILE', help='''filename to get result.''')
args = parser.parse_args()

def main():
	data = util.readJson(args.CONS)
	cubic_solver = CubicSolver(data)
	cubic_solver.run()
	cubic_solver.saveJson(args.RESULT_FILE)





if __name__ == '__main__':
	main()
	end = time.time()
	print('실행시간: ', end-start)