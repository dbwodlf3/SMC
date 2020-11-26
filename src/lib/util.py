import os
import re
import json
import llvmlite.binding as llvm
import llvmlite.ir as ir

def readModule(filePath):
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

def giveName(module: llvm.ModuleRef):
    ir_module = ir.Module(module)
    try:
        ir_module.get_named_metadata('SMC_ANALYSIS_NAMED')
        raise Exception("ALREAD HAVE NAMED")
    except KeyError:
        ir_module.add_named_metadata('SMC_ANALYSIS_NAMED', ['True'])
    # give namespace to globals
    namespace_global = 'global!'
    index = 0
    for global_var in module.global_variables:
        if global_var.name:
            global_var.name = namespace_global + global_var.name
        else:
            global_var.name = namespace_global + str(index)
            index += 1

    # give names to things of function.
    for function in module.functions:
        namespace_local = function.name +'!'
        name_index = 0
        for parameter in function.arguments:
            if parameter.name:
                parameter.name = namespace_local + parameter.name
            else:
                parameter.name = namespace_local + str(name_index)
                name_index += 1
        for block in function.blocks:
            if block.name:
                block.name = namespace_local + block.name
            else:
                block.name = namespace_local + str(name_index)
                name_index += 1
            for instruction in block.instructions:
                if(instruction.type.__str__()=='void'):
                    continue
                if instruction.name:
                    instruction.name = namespace_local + instruction.name
                else:
                    instruction.name = namespace_local + str(name_index)
                    name_index +=1
    return ir_module

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