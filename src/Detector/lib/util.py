import os
import json
import llvmlite.ir as ir
import llvmlite.binding as llvm


def readJson(filename: str):
	with open(filename) as json_file:
		return json.load(json_file)

def readModule(filePath):
	"""Return LLVM IR Module Object.
	Args:
		filePath (string): ll or bc file.
	"""
	#
	try:
		ll_file = open(filePath, "r")
	except:
		try:
			bc_file = open(filePath, "rb")
		except:
			pass
	finally:
		if(ll_file):
			return llvm.parse_assembly(ll_file.read())
		elif(bc_file):
			return llvm.parse_bitcode(bc_file.read())
		else:
			return print("CAN'T READ FILE!!")

def giveName(module: llvm.ModuleRef):
	ir_module = ir.Module(module)
	try:
		ir_module.get_named_metadata('SMC_ANALYSIS_NAMED')
		raise Exception("ALREAD HAVE NAMED")
	except KeyError:
		ir_module.add_named_metadata('SMC_ANALYSIS_NAMED', ['True'])
	# give namespace to globals
	namespace_global = 'global!'
	for global_var in module.global_variables:
		global_var.name = namespace_global + global_var.name

	# give names to things of function.
	for function in module.functions:
		namespace_local = function.name +'!'
		name_index = 0
		for parameter in function.arguments:
			if parameter.name:
				parameter.name = namespace_local + parameter.name
			else:
				parameter.name = namespace_local + str(name_index)
				name_index += 1
		for block in function.blocks:
			if block.name:
				block.name = namespace_local + block.name
			else:
				block.name = namespace_local + str(name_index)
				name_index += 1
			for instruction in block.instructions:
				if(instruction.type.__str__()=='void'):
					continue
				if instruction.name:
					instruction.name = namespace_local + instruction.name
				else:
					instruction.name = namespace_local + str(name_index)
					name_index +=1
	return ir_module