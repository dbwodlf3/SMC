import os
import re
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

def giveName(module: llvm.ModuleRef):
    ir_module = ir.Module(module)
    try:
        ir_module.get_named_metadata('SMC_ANALYSIS_NAMED')
        raise Exception("ALREAD HAVE NAMED")
    except KeyError:
        ir_module.add_named_metadata('SMC_ANALYSIS_NAMED', ['True'])
    # give namespace to globals
    namespace_global = 'global!'
    for global_var in module.global_variables:
        global_var.name = namespace_global + global_var.name

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
    raise Exception('''Can't find Function!''')

def getOperands(operand:llvm.ValueRef):
    operand_str = str(operand).replace('"','')
    global_namespace = 'global!'
    local_namespace = operand.function.name + '!'
    glboal_var_operands = \
        [(global_namespace + i).replace('@', '') for i in re.findall(r'@[a-zA-Z0-9_!]*', operand_str)]
    local_var_operands = \
        [ i.replace('%','') for i in re.findall(r'%[a-zA-Z0-9_!]*', operand_str)]
    
    return glboal_var_operands + local_var_operands

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