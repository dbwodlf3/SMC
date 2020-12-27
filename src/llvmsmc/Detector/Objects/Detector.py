import json
import llvmlite.ir as ir
import llvmlite.binding as llvm

from typing import List

from Detector.Objects.Variable import Variable
from Detector.Objects.CriticalDetector import CriticalDetector
from Detector.Objects.BasicDetector import *
from lib.util import readModule, giveName, readJson, getOperands, \
	stripCallInstruction

class Detector:
	# instruction for checking smc
	writeInstruction = ['store', 'call']

	def __init__(self, llvmFile : str, variableFile: str):
		# for init
		self.MODULE_REF = readModule(llvmFile)
		self.MODULE_IR = ir.Module()
		self.variables = {}
		self.criticalTokens = []
		self.criticalVariables: List[Variable] = []
		self.criticalValues = []
		self.criticalInstructions = []
		self.result = {}

		variables = readJson(variableFile)['variables']
		for var_name in variables:
			var = Variable(var_name, variables[var_name])
			self.variables[var_name] = var

		giveName(self.MODULE_REF)

	def initCriticalToken(self):
		for function in self.MODULE_IR.functions:
			self.criticalTokens.append(function.name)

	def initCriticalVariable(self):
		for var_name in self.variables :
			for critical_token in self.criticalTokens:
				if critical_token in self.variables[var_name].tokens:
					self.criticalVariables.append(self.variables[var_name])
		# print(self.criticalTokens)
		# print(self.criticalVariables)
		# for i in self.criticalVariables:
		# 	print(i)
		
	def checkSMC(self, detector: CriticalDetector):
		detector.init(self)
		detector.run()

	def run(self):
		self.initCriticalToken()
		self.initCriticalVariable()
		self.checkSMC(StoreDetector)
		self.checkSMC(MemcpyDetector)

	def saveJson(self, filename:str, time: float = 0):
		self.result['time'] = time
		self.result['criticalTokens'] = self.criticalTokens
		# self.result['criticalVariables'] = self.criticalVariables
		self.result['detect'] = []
		for criticalInstruction in self.criticalInstructions:
			count = 0
			instruction = criticalInstruction[0]
			for j in instruction.block.instructions:
				count += 1
				if j==instruction:
					detect = {
						'function':instruction.function.name,
						'block':instruction.block.name,
						'order':count,
						'instruction':instruction.opcode,
						'criticalOperand':criticalInstruction[1],
						'str':f'''{criticalInstruction[0]}'''
					}
					self.result['detect'].append(detect)

		with open(filename, 'w') as json_file:
			json.dump(self.result, json_file, indent=4)

	def __str__(self):
		pass