"""
Module을 Input 으로 받고.
결과로, function_name!stack!$offset 의 토큰 집합을 반환한다.
"""

import llvmlite.binding as llvm

from lib.util import CustomAPI, checkCodeArea
from lib.helper import getStoreValue, getStorePointer

# ==============================================================================
# Helper Functions
def getStoreValue(storeInstruction: llvm.ValueRef):
    for idx, operand in enumerate(storeInstruction.operands):
        if(idx == 0):
            return operand
# ==============================================================================
# Analysis 

"""function_name!variable -> function_name!stack!8 -> !code! -> smc
"""

def setToList(dict_data: dict):
    result = {}
    for key in dict_data:
        result[key] = list(dict_data[key])
    return result

def getStackVariableSet(valueRef: llvm.ValueRef):
    offset = CustomAPI.getStackOffset(valueRef)
    if offset != 0 :
        return f'''{valueRef.function.name}!stack!{offset}'''
    else :
        return False

def stackAnalysis(moduleRef: llvm.ModuleRef, binaryFile = None):
    result = dict()
    """result = { 
                    function_name!stack!offset!8 : {'!code!'},
                    function_name!stack!offset!16 : {}
                }
    """
    # Store Memory Address to Stack
    for function in moduleRef.functions:
        for block in function.blocks:
            for inst in block.instructions:
                offset = None

                if inst.opcode == 'inttoptr':
                    offset = CustomAPI.getStackOffset(inst)
                elif inst.opcode == 'store':
                    offset = CustomAPI.getStackOffset(getStorePointer(inst))

                if offset == None or offset == 0:
                    continue
                ptr_set = f'''{function.name}!stack!{offset}'''
                if(not result.get(ptr_set)):
                    result[ptr_set] = set()

                # Load Memory Address from Stack and Store there.
                for instruction in block.instructions:
                    if instruction.opcode == 'store':
                        dest = getStorePointer(instruction)
                        value = getStoreValue(instruction)
                        area = CustomAPI.getConstantInt(value)
                        CustomAPI.getStackOffset(dest)
                        if CustomAPI.getStackOffset(dest) == offset:
                            if not area.fail:
                                if(checkCodeArea(area.value, binaryFile)):
                                    
                                    result[ptr_set].add(area.value)
                                    result[ptr_set].add('!code!')
                            else:
                                result[ptr_set].add(value.name)
    return result