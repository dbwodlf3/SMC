import os
import re
import json
import llvmlite.binding as llvm
import llvmlite.ir as ir
from lib.ffi import *

def readModule(filePath) -> llvm.ModuleRef:
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

def readJson(filename: str):
	with open(filename) as json_file:
		return json.load(json_file)

def giveName(module: llvm.ModuleRef) -> llvm.ModuleRef:
    return libc.giveName(module)

# VERY STRANGE WAY
# but... it works. then. and okay. haha...
def getFunctionByName(functionName:str, module:llvm.ModuleRef):
    for function in module.functions:
        if functionName == function.name:
            return function
    return None
    # raise Exception(f'''Can't find Function! {functionName}''')

def stripCallInstruction(instructionString: str):
    reg_obj = re.match(r'.*call [^@]*@[^(]*', instructionString)
    if reg_obj :
        start = reg_obj.span()[1]
        return instructionString[start: ]
    raise Exception(f''' Can't Strip call Instruction! {instructionString}''')

def getOperands(operand:llvm.ValueRef, localNamespace:str = ''):
    operand_str = str(operand).replace('"','')
    global_namespace = 'global!'
    if localNamespace:
        pass
    else:        
        local_namespace = operand.function.name + '!'

    global_var_operands = \
        [i.replace('@', '') for i in re.findall(r'@[a-zA-Z0-9_!]*', operand_str)]
    # print(global_var_operands, operand_str)
    local_var_operands = \
        [ i.split()[-1].replace('%','')
            for i in re.findall(r'%[a-zA-Z0-9_!.]*![a-zA-Z0-9_.]*', operand_str)]

    return global_var_operands + local_var_operands

def checkCallAsm(instruction: llvm.ValueRef):
    if instruction.name:
        return False
    return True

constantExpressions = [
    'getelementptr',
    'extractelement',
    'bitcast',
    'ptrtoint',
    'inttoptr',
    'extractvalue',
    'trunc',
    'zext',
    'sext',
    'fptrunc',
    'fpext',
    'fptoui',
    'fptosi',
    'uitofp',
    'sitofp',
    'addrspacecast',
    'select',
    'icmp',
    'fcmp',
    'insertelement',
    'shufflevector',
    'insertvalue',
    'OPCODE'
]