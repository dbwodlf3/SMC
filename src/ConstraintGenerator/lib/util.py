import llvmlite.binding as llvm
import os

def readModule(filePath):
	"""Return LLVM IR Module Object.
	
	Args:
		filePath (string): ll or bc file.
	"""
	
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