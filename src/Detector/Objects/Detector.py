import json
import llvmlite.ir as ir
import llvmlite.binding as llvm
from Detector.Objects.Variable import Variable

class Detector:
	criticalTokens = []
	criticalValues = []
	criticalInstructions = []
	writeInstruction = ['store', 'call']
	writeFunction = []
	result = []

	def __init__(self, module :llvm.ModuleRef, irModule: ir.Module,
		variables = {} ):
		self.MODULE = module
		self.IR_MODULE = irModule
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
						ins_ops = self.getOperands(instruction)
						for op in ins_ops:
							if op in self.criticalTokens:
								self.criticalInstruction.append(instruction)

	def saveJson(self, filename:str, time: float = 0):
		self.result['time'] = time
		with open(filename, 'w') as json_file:
			json.dump(self.result, json_file, indent=4)

	def functionCritical(self):
		for function in self.MODULE.functions:
			self.criticalTokens.append(function.name)
	def __str__(self):
		pass