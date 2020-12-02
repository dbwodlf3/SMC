from typing import List
from llvmlite.binding import ValueRef

from lib.util import *
from Detector.Objects.CriticalDetector import CriticalDetector

class StoreDetector(CriticalDetector):
	instructions: List[ValueRef] = []
	@classmethod
	def findInstructions(cls):
		for function in cls.detector.MODULE.functions:
			for block in function.blocks:
				for instruction in block.instructions:
					if(instruction.opcode == 'store'):
						cls.instructions.append(instruction)
	@classmethod
	def run(cls):
		cls.findInstructions()
		
		for instruction in cls.instructions:
			op_iter = instruction.operands
			op_iter.next()
			pointer = op_iter.next()
			operands = getOperands(pointer)
			
			if pointer.name:
				pass
			else:
				raise Exception('No Name Operand!!')

			if pointer.name in cls.detector.criticalTokens:
				pass
				cls.detector.criticalInstructions.append([instruction,
					pointer.name])
			else :
				for criticalVariable in cls.detector.criticalVariables:
					if pointer.name == criticalVariable.name:
						cls.detector.criticalInstructions.append([instruction,
							pointer.name])

		return 0

class MemcpyDetector(CriticalDetector):
	instructions: List[ValueRef] = []

	@classmethod
	def findInstructions(cls):
		for function in cls.detector.MODULE.functions:
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