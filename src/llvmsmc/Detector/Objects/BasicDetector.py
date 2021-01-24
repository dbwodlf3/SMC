
import re
from typing import List
from llvmlite.binding import ValueRef

from lib import helper
from lib.util import *
from lib.ffi import *
from StackAnalysis import StackAnalysis
from Detector.Objects.CriticalDetector import CriticalDetector
from Detector.Objects.Variable import ConstantIntVariable

class StoreDetector(CriticalDetector):

	instructions: List[ValueRef] = []

	@classmethod
	def findInstructions(cls):
		for function in cls.detector.MODULE_REF.functions:
			# limit detect functions
			if re.match(r'.*_main', function.name) == None:
				if 'main' != function.name:
					continue
			
			for block in function.blocks:
				for instruction in block.instructions:
					if(instruction.opcode == 'store'):
						cls.instructions.append(instruction)

	@classmethod
	def run(cls):
		# init
		cls.findInstructions()
		stack = StackAnalysis.stackAnalysis(cls.detector.MODULE_REF, cls.detector.BINARY_FILE)

		# Detect
		for instruction in cls.instructions:
			answer = Detectors.StoreDetector(instruction)

			if answer.pattern == 1:
				# @data_[0-9]*
				dest_name = answer.destName.decode('utf-8')
				variable = cls.detector.variables.get(dest_name)
				if variable and '!code!' in variable.tokens:
					# limit alias
					if re.match(r'.*data_[0-9]*', dest_name):
						cls.detector.criticalInstructions.append([instruction,
							variable, 1.1])
			
			elif answer.pattern == 2:
				dest = helper.getStorePointer(instruction)

			# elif answer.pattern == 2:
			# 	dest_name = answer.destName.decode('utf-8')
			# 	variable = cls.detector.variables.get(dest_name)
			# 	if variable == None:
			# 		continue
			# 	elif ('!code!' in variable.tokens
			# 		and not '!data!' in variable.tokens):
			# 		# limit areas
			# 		if re.match(r'.*main!.*',str(instruction)):
			# 			print(instruction)
			# 			cls.detector.criticalInstructions.append([instruction,
			# 				variable, 1.2])	
			
			elif answer.pattern == 3:
				# ConstantInt
				dest_name = answer.destName.decode('utf-8')
				area = int(dest_name)
				if checkCodeArea(area, cls.detector.BINARY_FILE):
					variable = ConstantIntVariable(area)
					cls.detector.criticalInstructions.append([instruction,
						variable, 1.3])

			elif answer.pattern == 4:
				dest_name = answer.destName.decode('utf-8')
				variable = cls.detector.variables.get(dest_name)

				if variable and '!code!' in variable.tokens:
					if re.match(r'.*data_[0-9]*', dest_name):
						area = int(dest_name[11:], 16)
						if checkCodeArea(area, cls.detector.BINARY_FILE):
							cls.detector.criticalInstructions.append(
								[instruction, variable, 1.4])
							
			elif answer.pattern == 5:
				pass
		return 0

class CallDetector(CriticalDetector):
	instructions: List[ValueRef] = []

	@classmethod
	def findInstructions(cls):
		for function in cls.detector.MODULE_REF.functions:
			# limit detect functions
			if re.match(r'.*_main', function.name) == None:
				if 'main' != function.name:
					continue

			for block in function.blocks:
				for instruction in block.instructions:
					if(instruction.opcode == 'call'):
						cls.instructions.append(instruction)
		return 0

	@classmethod
	def run(cls):
		# init
		cls.findInstructions()

		# Detect
		for instruction in cls.instructions:
			answer = Detectors.CallDetector(instruction)
			if answer.pattern == 1:
				# Pattern 1
				# call void (...) %variable
				dest_name = answer.destName.decode('utf-8')
				variable = cls.detector.variables.get(dest_name)
				if variable and '!data!' in variable.tokens:
					cls.detector.criticalInstructions.append([instruction,
						variable, 2.1])

			elif answer.pattern == 2:
				# Pattern 2
          		# call void (...) bitcast (@global_variable)
				dest_name = answer.destName.decode('utf-8')
				variable = cls.detector.variables.get(dest_name)
				if variable:
					# print(instruction)
					cls.detector.criticalInstructions.append([instruction,
						variable, 2.2])
			elif answer.pattern == 3:
				# Pattern 3
				# call @__remill_function_call(____, %variable, ____)
				dest_name = answer.destName.decode('utf-8')
				variable = cls.detector.variables.get(dest_name)
				filter_function = lambda x: re.match(r'.*RBP', x)
				if variable:
					if ('!data!' in variable.tokens or
						len(list(filter(filter_function, variable.tokens))) > 0):
						cls.detector.criticalInstructions.append([instruction,
							variable, 2.3])

			elif answer.pattern == 4:
				# Pattern 4
				# call @__remill_function_call(____, ptrtoint ( @data_[0-9]* ), ____)
				dest_name = answer.destName.decode('utf-8')
				variable = cls.detector.variables.get(dest_name)
				if variable:
					if re.match(r'.*data', dest_name):			
						area = int(dest_name[11:], 16)
						if not checkCodeArea(area, cls.detector.BINARY_FILE):
							cls.detector.criticalInstructions.append([instruction,
								variable, 2.4])
		return 0
