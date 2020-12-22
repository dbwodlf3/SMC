import llvmlite.ir as ir
import llvmlite.binding as llvm
from ConstraintGenerator.Objects.Constraint import *
from lib.util import *


# @Todo
# Constant Value (Noname Value)

class RetConstraint(FunctionConstraint):
    """
    `Language Syntax`: \<ty> \<fnty> \<fnptrval> (\<function args>){
        ...ret <fnty> var }
    `Constraint Result`: var ⊆ [[ fnptrval!ret ]]
    """
    CONSTRAINTS = []
    @classmethod
    def applyConstraint(cls, function: llvm.ValueRef):
        for block in function.blocks:
            for instruction in block.instructions:
            	if instruction.opcode == 'ret':
                    variables = getOperands(instruction)
                    for var in variables:
                        cls.CONSTRAINTS.append([2, var,
                            f'''{instruction.function.name}!ret'''])

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
                cls.SYMBOLS.add(result)

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
            values = getOperands(next(instruction.operands))
            if values and result:
                for value in values:
                    cls.CONSTRAINTS.append([2, value, result])
                    cls.SYMBOLS.add(value)
                    cls.SYMBOLS.add(result)

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
            values = getOperands(next(instruction.operands))
            if result and values:
                for value in values:
                    cls.CONSTRAINTS.append([2, value, result])
                    cls.SYMBOLS.add(value)
                    cls.SYMBOLS.add(result)

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
                vals = getOperands(operand)
                if result and vals:
                    for val in vals:
                        cls.CONSTRAINTS.append([2, val, result])
                        cls.SYMBOLS.add(val)
                        cls.SYMBOLS.add(result)

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
                vals = getOperands(operand)
                if result and vals:
                    for val in vals:
                        cls.CONSTRAINTS.append([2, val, result])
                        cls.SYMBOLS.add(val)
                        cls.SYMBOLS.add(result)

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
            vals = getOperands(next(instruction.operands))
            if result and vals:
                for val in vals:
                    cls.CONSTRAINTS.append([2, val, result])
                    cls.SYMBOLS.add(val)
                    cls.SYMBOLS.add(result)

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
            pointers = getOperands(next(instruction.operands))
            if result and pointers:
                for pointer in pointers:
                    cls.CONSTRAINTS.append([3, pointer, result])
                    cls.SYMBOLS.add(pointer)
                    cls.SYMBOLS.add(result)

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
                cls.SYMBOLS.add(ptrval)
                cls.SYMBOLS.add(result)

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
                        cls.SYMBOLS.add(pointer)
                        cls.SYMBOLS.add(value)

# @Todo apply FUNCTION Constraint..

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
    @classmethod
    def applyConstraint(cls, instruction: llvm.ValueRef):
        if instruction.opcode == 'call':
            # skip about 'call asm'
            if checkCallAsm(instruction):
                return
            result = instruction.name
            args = []
            for i in instruction.operands:
                # variable
                if i.name:
                    args.append([i.name])
                #  constant
                else :
                    args.append(getOperands(i))
            call_function_name = args[-1][0]
            call_function_ref = getFunctionByName(call_function_name,
                cls.MODULE)
                
            if not call_function_ref:
                return
            for idx, parameter in enumerate(call_function_ref.arguments):
                if args[idx] and parameter.name:
                    for arg in args[idx]:
                        cls.CONSTRAINTS.append([2, arg, parameter.name])
                        cls.SYMBOLS.add(arg)
                        cls.SYMBOLS.add(parameter.name)

class TokenInitConstraint(Constraint):
    CONSTRAINTS = []
    @classmethod
    def applyConstraint(cls):
        for symbol in cls.SYMBOLS:
            cls.CONSTRAINTS.append([0, symbol])