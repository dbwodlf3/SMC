import json
import llvmlite.ir as ir
import llvmlite.binding as llvm
from Detector.Objects.Variable import Variable
from lib.util import readModule, giveName, readJson, getOperands, \
	stripCallInstruction

class Detector:
	# for variables.
	criticalTokens = []
	# for constant values.
	criticalValues = []
	criticalInstructions = []
	# instruction for checking smc
	writeInstruction = ['store', 'call']
	writeFunction = []
	result = {}

	def __init__(self, llvmFile : str, variableFile: str):

		module = readModule(llvmFile)
		ir_module = giveName(module)
		variables = readJson(variableFile)

		self.MODULE = module
		self.IR_MODULE = ir_module
		self.variables = {}

		variables_raw = variables['variables']
		if variables_raw:
			for var_name in variables_raw:
				var = Variable(var_name, variables_raw[var_name])
				self.variables[var_name] = var

	def run(self):
		self.functionCritical()
		for function in self.MODULE.functions:
			for block in function.blocks:
				for instruction in block.instructions:
					if instruction.opcode in self.writeInstruction:
						if instruction.opcode == 'call':
							strip_str = stripCallInstruction(str(instruction))
							namespace = instruction.function.name + '!'
							ins_ops = getOperands(strip_str, namespace)
						else:
							ins_ops = getOperands(instruction)
						for op in ins_ops:
							if op in self.criticalTokens:
								Detector.criticalInstructions.append(
									[instruction, op])

	def saveJson(self, filename:str, time: float = 0):
		self.result['time'] = time
		self.result['criticalTokens'] = self.criticalTokens
		self.result['detect'] = []
		for criticalInstruction in Detector.criticalInstructions:
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

	def functionCritical(self):
		for function in self.MODULE.functions:
			self.criticalTokens.append(function.name)
	def __str__(self):
		pass