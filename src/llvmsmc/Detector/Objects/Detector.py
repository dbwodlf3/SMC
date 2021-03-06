import json
import llvmlite.ir as ir
import llvmlite.binding as llvm

from typing import List

from Detector.Objects.Variable import Variable
from Detector.Objects.CriticalDetector import CriticalDetector
from Detector.Objects.BasicDetector import *
from lib.util import readModule, giveName, readJson, getOperands
	
from StackAnalysis import StackAnalysis

class Detector:
	# instruction for checking smc
	writeInstruction = ['store', 'call']

	def __init__(self,  llvmFile : str, variableFile: str, binaryFile = None):
		# for init
		self.BINARY_FILE = binaryFile
		self.LL_FILE = llvmFile
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
		self.checkSMC(CallDetector)

	def saveJson(self, filename:str, time: float = 0):
		self.result['binaryFile'] = self.BINARY_FILE
		self.result['codeArea'] = getCodeSegment(self.BINARY_FILE)
		self.result['time'] = time
		self.result['criticalTokens'] = self.criticalTokens
		stack = StackAnalysis.stackAnalysis(self.MODULE_REF, self.BINARY_FILE)
		self.result['stack'] = StackAnalysis.setToList(stack)
		
		# self.result['criticalVariables'] = self.criticalVariables
		self.result['detect'] = []
		for criticalInstruction in self.criticalInstructions:
			count = 0
			instruction = criticalInstruction[0]
			for  j in instruction.block.instructions:
				count += 1
				if j==instruction:
					detect = {
						'Function':instruction.function.name,
						'Block':instruction.block.name,
						'Order':count,
						'LLVM Instruction':instruction.opcode,
						'Pattern':criticalInstruction[2],
						'CriticalOperand':criticalInstruction[1].name,
						'Str':f'''{criticalInstruction[0]}''',
						'Tokens':criticalInstruction[1].tokens
					}
					self.result['detect'].append(detect)

		with open(filename, 'w') as json_file:
			json.dump(self.result, json_file, indent=4)

	def __str__(self):
		pass