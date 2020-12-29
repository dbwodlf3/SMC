from typing import List
from llvmlite.binding import ValueRef

from lib.util import *
from lib.ffi import *
from Detector.Objects.CriticalDetector import CriticalDetector

class StoreDetector(CriticalDetector):
	instructions: List[ValueRef] = []

	@classmethod
	def findInstructions(cls):
		for function in cls.detector.MODULE_REF.functions:
			for block in function.blocks:
				for instruction in block.instructions:
					if(instruction.opcode == 'store'):
						cls.instructions.append(instruction)
	@classmethod
	def run(cls):
		# init
		cls.findInstructions()

		for instruction in cls.instructions:
			op_iter = instruction.operands
			op_dest = op_iter.next()

			# pattern 1
			# store ____, @data_[0-9]*
			if libc.isAlias(op_dest) :
				pass
			# pattern 2
			# store ____, bitcast(@data_[0-9]*)
			elif libc.isConstantExprIns(op_dest, 'bitcast') :
				pass
			# pattern 3
			# store ____, inttoptr (ConstantInt)
			elif libc.isConstantExprIns(op_dest, 'inttoptr') :
				pass
			# pattern 4
			# store ____, %variable
			else :
				pass

		return 0

class CallDetector(CriticalDetector):
	instructions: List[ValueRef] = []

	@classmethod
	def findInstructions(cls):
		for function in cls.detector.MODULE_REF.functions:
			for block in function.blocks:
				for instruction in block.instructions:
					if(instruction.opcode == 'call'):
						cls.instructions.append(instruction)
		return 0

	@classmethod
	def run(cls):
		# init
		cls.findInstructions()

		for instruction in cls.instructions:
			op_iter = instruction.operands
			function = op_iter.next()

			# pattern 1
			# call void (...) %variable
			if function.name:
				pass
			# pattern 2
			# call void (...) bitcast ( @global_variable)
			elif libc.isConstantExprIns(function, 'bitcast'):
				pass
			# pattern 3
			# call @__remill_function_call(____, %variable, ____)
			elif function:
				pass
			cls.detector.criticalInstructions.append([instruction,
				dest.name])
		return 0

# legacy code
class MemcpyDetector(CriticalDetector):
	instructions: List[ValueRef] = []

	@classmethod
	def findInstructions(cls):
		for function in cls.detector.MODULE_REF.functions:
			for block in function.blocks:
				for instruction in block.instructions:
					if(instruction.opcode == 'call'):
						if(str(instruction).find('llvm.memcpy') != -1):
							cls.instructions.append(instruction)
		return 0

	@classmethod
	def run(cls):
		cls.findInstructions()
		
		for instruction in cls.instructions:
			op_iter = instruction.operands
			dest = op_iter.next()
			if dest.name in cls.detector.criticalTokens:
				print(dest.name)
			else :
				for criticalVariable in cls.detector.criticalVariables:
					if dest.name == criticalVariable.name:
						cls.detector.criticalInstructions.append([instruction,
							dest.name])
		return 0 