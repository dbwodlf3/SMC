import os
import re
import json
import llvmlite.binding as llvm
import llvmlite.ir as ir
from lib.ffi import *
from elftools.elf.elffile import ELFFile

def readModule(filePath) -> llvm.ModuleRef:
    """Return LLVM IR Module Object.
    Args:
        filePath (string): ll or bc file.
    """
    #
    try:
        ll_file = False
        ll_file = open(filePath, "r")
    except:
        try:
            bc_file = False
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

def getAlias(module: llvm.ModuleRef):
    pass

class AliasIterator:
    def __init__(self, ModuleRef):
        pass
    
    def __iter__(self):
        return self
    
    def __next__(self):
        raise StopIteration
    

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

def getCodeSegment(binary_file):
    result = []
    if binary_file :
        with open(binary_file, 'rb') as f:
            elffile = ELFFile(f)
            
            for segment in elffile.iter_segments():
                if(segment['p_flags'] & 0b1):
                    start = segment['p_vaddr']
                    end = start + segment['p_memsz']
                    result.append((start, end))

        return result
    else :
        return result

def checkCodeArea(memory_address, binary_file):
    codes = getCodeSegment(binary_file)
    for code in codes:
        start = code[0]
        end = code[1]

        if memory_address >= start and memory_address <= end:
            return True
    
    return False

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