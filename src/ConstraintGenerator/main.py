#!/usr/bin/python3.8
import os, sys, argparse
from Objects.ConstraintGenerator import ConstraintGenerator
import llvmlite.binding as llvm
# from lib import util

a = ConstraintGenerator('./simple.ll')

# Init
parser = argparse.ArgumentParser()
parser.add_argument('LLVM_IR', help='''
	LLVM IR File. bc or ll file.''')
args = parser.parse_args()

def main():
	pass













if __name__ == '__main__':
	main()