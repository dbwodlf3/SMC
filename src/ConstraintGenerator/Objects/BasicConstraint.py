from Objects.Constraint import *
import llvmlite.ir as ir
import llvmlite.binding as llvm

# Type 0
# One.
class AllocaConstraint(Constraint):
	"""
	`Instruction Syntax`: \<result> = alloca \<type> \n
	`Constraint Result`: result ∈ [[ result ]]
	"""
	@staticmethod
	def applyConstraint(instruction: llvm.ValueRef):
		if instruction.opcode == 'alloca':
			print(instruction.name)
			for operand in instruction.operands:
				print(operand)

# Type 1
# Six.
class IntToPtrConstraint(Constraint):
	"""
	`Instruction Syntax`: \<result> = inttoptr \<ty> \<value> to \<ty2> \n
	`Constraint Result`: [[value]] ⊆ [[result]]
	"""
	@staticmethod
	def applyConstraint(instruction: llvm.ValueRef):
		if instruction.opcode == 'inttoptr':
			# Todo something.
			pass

class BitCastConstraint(Constraint):
	"""
	`Instruction Syntax`: \<result> = bitcast \<ty> \<value> to \<ty2> \n
	`Constraint Result`: [[value]] ⊆ [[result]]
	"""
	@staticmethod
	def applyConstraint(instruction: llvm.ValueRef):
		if instruction.opcode == 'bitcast':
			# Todo something.
			pass

class PHIConstraint(Constraint):
	"""
	`Instruction Syntax`: \<result> = phi \<ty> [\<val0>, \<label0>]*, ... \n
	`Constraint Result`: \<val0> ⊆ [[result]], \<val1> ⊆ [[result]], ...
	"""
	@staticmethod
	def applyConstraint(instruction: llvm.ValueRef):
		if instruction.opcode == 'phi':
			# Todo something.
			pass

class SelectConstraint(Constraint):
	"""
	`Instruction Syntax`: \<result> = select selty \<cond>, \<ty> \<val1>,
		\<ty> \<val2> \n
	`Constraint Result`: [[val1]] ⊆ [[result]], [[val2]] ⊆ [[result]]
	"""
	@staticmethod
	def applyConstraint(instruction: llvm.ValueRef):
		if instruction.opcode == 'select':
			# Todo something.
			pass

class ExtractvalueConstraint(Constraint):
	"""
	`Instruction Syntax`: \<result> = extractvalue \<aggregate type> \<val>,
		\<idx>{, \<idx>}* \n
	`Constraint Result`: [[val1]] ⊆ [[result]]
	"""
	@staticmethod
	def applyConstraint(instruction: llvm.ValueRef):
		if instruction.opcode == 'extractvalue':
			# Todo something.
			pass

# Type 2
# One.
class StoreConstraint(Constraint):
	"""
	`Instruction Syntax`: store [volatile] \<ty> \<value>, \<ty>* \<pointer> \n
	`Constraint Result`: ∀t ∈ [[pointer]] ⟶ [[value]] ⊆ [[t]]
	"""
	@staticmethod
	def applyConstraint(instruction: llvm.ValueRef):
		if instruction.opcode == 'store':
			# Todo something.
			pass

# Type 3
# Two.
class LoadConstraint(Constraint):
	"""
	`Instruction Syntax`:  \<result> = load [volatile] \<ty>,
		\<ty>* \<pointer>\n
	`Constraint Result`: ∀t ∈ [[pointer]] ⟶ [[t]] ⊆ [[result]]
	"""
	@staticmethod
	def applyConstraint(instruction: llvm.ValueRef):
		if instruction.opcode == 'load':
			# Todo something.
			pass

class GetElementPtrConstraint(Constraint):
	"""
	`Instruction Syntax`: \<result> = getelementptr \<ty>, \<ty>* \<ptrval>
		{, \<ty> idx}* \n
	`Constraint Result`: ∀t ∈ [[ptrval]] ⟶ [[t]] ⊆ [[result]]
	"""
	@staticmethod
	def applyConstraint(instruction: llvm.ValueRef):
		if instruction.opcode == 'getelementptr':
			# Todo something.
			pass

# Type 4
# Procedure Constraint.
# One.
class CallConstraint(Constraint):
	"""
	`Instruction Syntax`: \<result> = call \<ty> \<fnty> \<fnptrval>
		(\<function args>) \n
	`Constraint Result`: [[arg1]] ⊆ [[param1]], [[arg2]] ⊆ [[param2]], ...
		and, [[RETURN_VALUE]] ⊆ [[result]] \n
	It is some different other constraints. Let's is that fnptrval's formal args 
		are param, fnptrval's actual args are arg and fnptrval's
		return token 'RETURN_VALUE'.
	"""
	@staticmethod
	def applyConstraint(instruction: llvm.ValueRef):
		if instruction.opcode == 'call':
			pass