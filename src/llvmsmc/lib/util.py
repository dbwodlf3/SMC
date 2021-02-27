import os
import re
import json
import llvmlite.binding as llvm
import llvmlite.ir as ir
from lib.ffi import *
from elftools.elf.elffile import ELFFile

def readModule(filePath) -> llvm.ModuleRef:
    """This function for getting llvm Module Referecne from ll or bc file.

    Parameters:
        filePath (str): llvm ir file.

    Returns:
        llvmlite.binding.ModuleRef
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
    """This function return dict object from json file.

    Parameters:
        filename (str): json file path.
    
    ReturnsL:
        dict object base on json file.
    """
    with open(filename) as json_file:
        return json.load(json_file)

def giveName(module: llvm.ModuleRef) -> llvm.ModuleRef:
    """This function give name to IR instructions on llvm module.
    
    Parameters:
        module (llvmlite.binding.ModuleRef): Module Reference.
    
    Returns:
        llvmlite.binding.ModuleRef
    """
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
    

def getFunctionByName(functionName:str, module:llvm.ModuleRef):
    """This function for get function Reference by function name.

    Parameters:
        functionName (str): function name.
        module (llvmlite.binding.ModuleRef): Module Reference.

    Returns:
        llvmlite.binding.ValueRef
    """
    for function in module.functions:
        if functionName == function.name:
            return function
    return None
    # raise Exception(f'''Can't find Function! {functionName}''')

def getCodeSegment(binary_file):
    """Get executable segments area from binary file.

    Parameters:
        binary_file (str): binary file including path.
    
    Returns:
        [(int, int)]
    """
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
    """Function for check memory address is in executable area.
    if memory_address is in executable then return True else False.

    Parameters:
        memory_address (int): memory address.
        binary_file (str): binary file for get sections.
    
    Returns:
        bool: True if in codearea, False otherwise.
    """
    codes = getCodeSegment(binary_file)
    for code in codes:
        start = code[0]
        end = code[1]

        if memory_address >= start and memory_address <= end:
            return True
    
    return False


def stripCallInstruction(instructionString: str):
    """Legacy Code.
    """
    reg_obj = re.match(r'.*call [^@]*@[^(]*', instructionString)
    if reg_obj :
        start = reg_obj.span()[1]
        return instructionString[start: ]
    raise Exception(f''' Can't Strip call Instruction! {instructionString}''')

def getOperands(operand:llvm.ValueRef, localNamespace:str = ''):
    """Legacy Code.
    """
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
    """Legacy Code. It is for check "call asm" instructions.
    """
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