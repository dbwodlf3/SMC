from typing import List
import json

import llvmlite.binding as llvm
import llvmlite.ir as ir

from lib.util import readModule, giveName
from ConstraintGenerator.Objects.Constraint import *
from ConstraintGenerator.Objects.BasicConstraint import *

class ConstraintGenerator:
    """Constraint Generator Class.
    This class makes json file for cubicsolver.
    """
    DATA = {"ConstraintResult": []}
    
    def __init__(self, ll_file, binary_file):
        module = readModule(ll_file)
        ir_module = giveName(module)
        self.MODULE = module
        self.IR_MODULE = ir_module
        self.CONSTRAINTS: list = []
        self.CODE_SEGMENTS = getCodeSegment(binary_file)
        self.constraintRules: List[Constraint] = []
        self.functionConstraintRules: List[FunctionConstraint] = []
        self.moduleConstraintRules: List[ModuleConstraint] = []

    def addConstraint(self, constraint: Constraint):
        """Register Constraint Class. 
        
        Parameters:
            constraint (ModuleConstraint): LLVM Instruction Level Constraint.
        """
        constraint.MODULE = self.MODULE
        self.constraintRules.append(constraint)

    def addFunctionConstraint(self, constraint: FunctionConstraint):
        """Register Function Constraint Class. 
        
        Parameters:
            constraint (ModuleConstraint): Function Level Constraint.
        """
        self.functionConstraintRules.append(constraint)

    def addModuleConstraint(self, constraint: ModuleConstraint):
        """Register Module Constraint Class. 
        
        Parameters:
            constraint (ModuleConstraint): Module Level Constraint.
        """
        self.moduleConstraintRules.append(constraint)

    def run(self):
        #init
        self.initConstraint()

        # Module Constraints
        for constraint in self.moduleConstraintRules:
            constraint.applyConstraint(self.MODULE, self.CODE_SEGMENTS)

        # Function Constraints
        for function in self.MODULE.functions:
            # Function Constraints
            for constraint in self.functionConstraintRules:
                constraint.applyConstraint(function)

        # Instruction Constraints 
        for function in self.MODULE.functions:
            for block in function.blocks:
                for instruction in block.instructions:
                    for constraint in self.constraintRules:
                        constraint.applyConstraint(instruction)

        # INIT for Symbols..
        TokenInitConstraint.applyConstraint()

        # Save module constraints
        for constraintRule in self.moduleConstraintRules:
            constraint_results = constraintRule.dumpConstraint()
            if constraint_results:
                self.DATA['ConstraintResult'].append(constraint_results)

        # Save function constraints
        for constraintRule in self.functionConstraintRules:
            constraint_results = constraintRule.dumpConstraint()
            if constraint_results:
                self.DATA['ConstraintResult'].append(constraint_results)

        # Save instruction constraints
        for constraintRule in self.constraintRules:
            constraint_results = constraintRule.dumpConstraint()
            if(constraint_results):
                self.DATA['ConstraintResult'].append(constraint_results)

        # Save result
        constraint_results = TokenInitConstraint.dumpConstraint()
        self.DATA['ConstraintResult'].append(constraint_results)
        return

    def dumpJson(self):
        """Dump current json.
        """
        return json.dumps(self.DATA)

    def saveJson(self, filename: str, time: float = 0):
        """Save json as file.

        Parameters:
            filename (str): file name to be saved
            time (float): taken time to make constraints
        """
        self.DATA['time'] = time
        counts = 0
        for i in self.DATA['ConstraintResult']:
            counts += len(i)
        self.DATA['counts'] = counts
        
        with open(filename, 'w') as json_file:
            json.dump(self.DATA, json_file, indent=4)

    def initConstraint(self):
        # Extra Constraints Init
        self.addConstraint(DataConstraint)
        self.addConstraint(AddConstraint)

        # Module Constraints Init
        self.addModuleConstraint(AliasConstraint)

        # Function Constraints Init
        self.addFunctionConstraint(RetConstraint)
        self.addFunctionConstraint(FunctionCodeConstraint)

        # Instruction Constraints Init
        self.addConstraint(AllocaConstraint)
        self.addConstraint(IntToPtrConstraint)
        self.addConstraint(BitCastConstraint)
        self.addConstraint(PHIConstraint)
        self.addConstraint(SelectConstraint)
        self.addConstraint(ExtractvalueConstraint)
        self.addConstraint(StoreConstraint)
        self.addConstraint(LoadConstraint)
        self.addConstraint(GetElementPtrConstraint)
        self.addConstraint(CallConstraint)