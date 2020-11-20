import llvmlite.ir as ir
import llvmlite.binding as llvm
from ConstraintGenerator.Objects.Constraint import *
from ConstraintGenerator.lib.util import getOperands


# @Todo
# ConstraintExpr (Nested Value)
# Constant Value (Noname Value)

class AllocaConstraint(Constraint):
	"""
	`Instruction Syntax`: \<result> = alloca \<type> \n
	`Constraint Result`: result ∈ [[ result ]]
	"""
	CONSTRAINTS = []
	@classmethod
	def applyConstraint(cls, instruction: llvm.ValueRef):
		if instruction.opcode == 'alloca':
			result = instruction.name
			if result:
				cls.CONSTRAINTS.append([0, result])

class IntToPtrConstraint(Constraint):
	"""
	`Instruction Syntax`: \<result> = inttoptr \<ty> \<value> to \<ty2> \n
	`Constraint Result`: [[value]] ⊆ [[result]]
	"""
	CONSTRAINTS = []
	@classmethod
	def applyConstraint(cls, instruction: llvm.ValueRef):
		if instruction.opcode == 'inttoptr':
			result = instruction.name
			value = next(instruction.operands).name
			if value and result:
				cls.CONSTRAINTS.append([2, value, result])

class BitCastConstraint(Constraint):
	"""
	`Instruction Syntax`: \<result> = bitcast \<ty> \<value> to \<ty2> \n
	`Constraint Result`: [[value]] ⊆ [[result]]
	"""
	CONSTRAINTS = []
	@classmethod
	def applyConstraint(cls, instruction: llvm.ValueRef):
		if instruction.opcode == 'bitcast':
			# Todo something.
			result = instruction.name
			value = next(instruction.operands).name
			if result and value:
				cls.CONSTRAINTS.append([2, value, result])

class PHIConstraint(Constraint):
	"""
	`Instruction Syntax`: \<result> = phi \<ty> [\<val0>, \<label0>]*, ... \n
	`Constraint Result`: \<val0> ⊆ [[result]], \<val1> ⊆ [[result]], ...
	"""
	CONSTRAINTS = []
	@classmethod
	def applyConstraint(cls, instruction: llvm.ValueRef):
		if instruction.opcode == 'phi':
			result = instruction.name
			for operand in instruction.operands:
				val = operand.name
				if result and val:
					cls.CONSTRAINTS.append([2, val, result])

class SelectConstraint(Constraint):
	"""
	`Instruction Syntax`: \<result> = select selty \<cond>, \<ty> \<val1>,
		\<ty> \<val2> \n
	`Constraint Result`: [[val1]] ⊆ [[result]], [[val2]] ⊆ [[result]]
	"""
	CONSTRAINTS = []
	@classmethod
	def applyConstraint(cls, instruction: llvm.ValueRef):
		if instruction.opcode == 'select':
			result = instruction.name
			for operand in instruction.operands:
				val = operand.name
				if result and val:
					cls.CONSTRAINTS.append([2, val, result])

class ExtractvalueConstraint(Constraint):
	"""
	`Instruction Syntax`: \<result> = extractvalue \<aggregate type> \<val>,
		\<idx>{, \<idx>}* \n
	`Constraint Result`: [[val1]] ⊆ [[result]]
	"""
	CONSTRAINTS = []
	@classmethod
	def applyConstraint(cls, instruction: llvm.ValueRef):
		if instruction.opcode == 'extractvalue':
			result = instruction.name
			val = next(instruction.operands).name
			if result and val:
				cls.CONSTRAINTS.append([2, val, result])

class LoadConstraint(Constraint):
	"""
	`Instruction Syntax`:  \<result> = load [volatile] \<ty>,
		\<ty>* \<pointer>\n
	`Constraint Result`: ∀t ∈ [[pointer]] ⟶ [[t]] ⊆ [[result]]
	"""
	CONSTRAINTS = []
	@classmethod
	def applyConstraint(cls, instruction: llvm.ValueRef):
		if instruction.opcode == 'load':
			result = instruction.name
			pointer = next(instruction.operands).name
			if result and pointer:
				cls.CONSTRAINTS.append([3, pointer, result])

class GetElementPtrConstraint(Constraint):
	"""
	`Instruction Syntax`: \<result> = getelementptr \<ty>, \<ty>* \<ptrval>
		{, \<ty> idx}* \n
	`Constraint Result`: ∀t ∈ [[ptrval]] ⟶ [[t]] ⊆ [[result]]
	"""
	CONSTRAINTS = []
	@classmethod
	def applyConstraint(cls, instruction: llvm.ValueRef):
		if instruction.opcode == 'getelementptr':
			result = instruction.name
			ptrval = next(instruction.operands).name
			if result and ptrval:
				cls.CONSTRAINTS.append([3, ptrval, result])

# @Todo
# next function doesn't work properly for instruction.operands.
class StoreConstraint(Constraint):
	"""
	`Instruction Syntax`: store [volatile] \<ty> \<value>, \<ty>* \<pointer> \n
	`Constraint Result`: ∀t ∈ [[pointer]] ⟶ [[value]] ⊆ [[t]]
	"""
	CONSTRAINTS = []
	@classmethod
	def applyConstraint(cls, instruction: llvm.ValueRef):
		if instruction.opcode == 'store':
			for idx, operand in enumerate(instruction.operands):
				if(idx == 0):
					values = getOperands(operand)
				if(idx == 1):
					pointers = getOperands(operand)
			if values and pointers:
				for pointer in pointers:
					for value in values:
						cls.CONSTRAINTS.append([4, pointer, value])

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
			result = instruction.name
			# print(result)
			# for i in instruction.operands:
			# 	print(i.name)