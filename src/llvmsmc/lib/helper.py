"""Helper Functions
"""
import llvmlite.binding as llvm

def getStoreValue(storeInstruction: llvm.ValueRef):
    """Return Value Operand of Store Instruction.
    """
    for idx, operand in enumerate(storeInstruction.operands):
        if(idx == 0):
            return operand

def getStorePointer(storeInstruction: llvm.ValueRef):
    """Return Pointer Operand of Store Instruction.
    """
    for idx, operand in enumerate(storeInstruction.operands):
        if(idx == 1):
            return operand