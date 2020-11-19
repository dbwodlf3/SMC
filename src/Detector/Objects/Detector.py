import json
import llvmlite.ir as ir
import llvmlite.binding as llvm
from Objects.Variable import Variable

class Detector:
	criticalTokens = []
	criticalVariables = []
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
	def __str__(self):
		pass