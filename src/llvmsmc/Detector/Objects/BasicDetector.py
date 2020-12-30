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
		# Detect
		for instruction in cls.instructions:
			answer = Detectors.StoreDetector(instruction)

			if answer.pattern == 1:
				print('pattern 1!')
				print(answer.destName)
			elif answer.pattern == 2:
				print('pattern 2!')
				print(answer.destName)
			elif answer.pattern == 3:
				print('pattern 3!')
				print(answer.destName)
			elif answer.pattern == 4:
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
		for instruction in cls.instructions:
			answer = Detectors.CallDetector(instruction)
			if answer.pattern == 1:
				pass
			elif answer.pattern == 2:
				pass
			elif answer.pattern == 3:
				pass

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
		# cls.findInstructions()
		
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