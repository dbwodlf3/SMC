import re
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

		# Detect
		for instruction in cls.instructions:
			answer = Detectors.StoreDetector(instruction)

			if answer.pattern == 1:
				# @data_[0-9]*
				dest_name = answer.destName.decode('utf-8')
				variable = cls.detector.variables.get(dest_name)
				if variable and 'critical!' in variable.tokens:
					# limit alias
					if re.match(r'.*data_[0-9]*', dest_name):
						cls.detector.criticalInstructions.append([instruction,
							variable.name, 1.1])
			elif answer.pattern == 2:
				dest_name = answer.destName.decode('utf-8')
				# print(dest_name)
			# elif answer.pattern == 2:
			# 	# 오탐이 너무 많다.
			# 	# 왜 오탐이 많을까? => 시간 순서가 없어서. 너무 포괄적이다.
			# 	# 후의 명령어가, 처음의 명령어에 영향을 주어서.
			# 	# 너무 포괄적이다.
			# 	# %variable
			# 	dest_name = answer.destName.decode('utf-8')
			# 	variable = cls.detector.variables.get(dest_name)
			# 	if variable == None:
			# 		continue
			# 	elif 'critical!' in variable.tokens:
			# 		# limit areas
			# 		if re.match(r'.*main!.*',str(instruction)):
			# 			print(instruction)
			# 			cls.detector.criticalInstructions.append([instruction,
			# 				variable.name])	
			elif answer.pattern == 3:
				# ConstantInt
				dest_name = answer.destName.decode('utf-8')
				variable = cls.detector.variables.get(dest_name)

				if variable and 'critical!' in variable.tokens:
					if re.match(r'.*data_[0-9]*', dest_name):
						# print(instruction)
						cls.detector.criticalInstructions.append([instruction,
							variable.name, 1.3])

			elif answer.pattern == 4:
				dest_name = answer.destName.decode('utf-8')
				variable = cls.detector.variables.get(dest_name)

				if variable and 'critical!' in variable.tokens:
					if re.match(r'.*data_[0-9]*', dest_name):
						# print(instruction)
						cls.detector.criticalInstructions.append([instruction,
							variable.name, 1.4])
							
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
				dest_name = answer.destName.decode('utf-8')
				variable = cls.detector.variables.get(dest_name)
				if variable and 'data!' in variable.tokens:
					cls.detector.criticalInstructions.append([instruction,
						variable.name, 2.1])
			elif answer.pattern == 2:
				dest_name = answer.destName.decode('utf-8')
				variable = cls.detector.variables.get(dest_name)
				if variable:
					# print(instruction)
					cls.detector.criticalInstructions.append([instruction,
						variable.name, 2.2])
			elif answer.pattern == 3:
				# Pattern 3
				# call @__remill_function_call(____, %variable, ____)
				dest_name = answer.destName.decode('utf-8')
				variable = cls.detector.variables.get(dest_name)

				if variable and 'data!' in variable.tokens:
					cls.detector.criticalInstructions.append([instruction,
						variable.name, 2.3])
		return 0
