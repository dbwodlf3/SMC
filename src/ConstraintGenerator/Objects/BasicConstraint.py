from Objects.Constraint import *
import llvmlite.ir as llvmIR
import llvmlite.binding as llvm

# Type 0
# One.
class AllocaConstraint(Constraint):
	@staticmethod
	def applyConstraint(instruction: llvm.ValueRef):
		if instruction.opcode == 'alloca':
			for i in instruction.operands:
				pass

# Type 1
# Six.
class IntToPtrConstraint(Constraint):
	@staticmethod
	def applyConstraint(instruction: llvm.ValueRef):
		if instruction.opcode == 'inttoptr':
			# Todo something.
			pass

class BitCastConstraint(Constraint):
	@staticmethod
	def applyConstraint(instruction: llvm.ValueRef):
		if instruction.opcode == 'bitcast':
			# Todo something.
			pass

class PHIConstraint(Constraint):
	@staticmethod
	def applyConstraint(instruction: llvm.ValueRef):
		if instruction.opcode == 'phi':
			# Todo something.
			pass

class SelectConstraint(Constraint):
	@staticmethod
	def applyConstraint(instruction: llvm.ValueRef):
		if instruction.opcode == 'select':
			# Todo something.
			pass

class ExtractvalueConstraint(Constraint):
	@staticmethod
	def applyConstraint(instruction: llvm.ValueRef):
		if instruction.opcode == 'extractvalue':
			# Todo something.
			pass

# Type 2
# One.
class StoreConstraint(Constraint):
	@staticmethod
	def applyConstraint(instruction: llvm.ValueRef):
		if instruction.opcode == 'store':
			# Todo something.
			pass

# Type 3
# Two.
class LoadConstraint(Constraint):
	@staticmethod
	def applyConstraint(instruction: llvm.ValueRef):
		if instruction.opcode == 'load':
			# Todo something.
			pass

class GetElementPtrConstraint(Constraint):
	@staticmethod
	def applyConstraint(instruction: llvm.ValueRef):
		if instruction.opcode == 'getelementptr':
			# Todo something.
			pass

# Type 4
# Procedure Constraint.
# One.
class CallConstraint(Constraint):
	@staticmethod
	def applyConstraint(instruction: llvm.ValueRef):
		if instruction.opcode == 'call':
			pass