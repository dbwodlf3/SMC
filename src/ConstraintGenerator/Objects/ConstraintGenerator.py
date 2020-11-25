from typing import List
import json
import llvmlite.binding as llvm
import llvmlite.ir as ir
from lib.util import readModule, giveName
from ConstraintGenerator.Objects.Constraint import *
from ConstraintGenerator.Objects.BasicConstraint import *

class ConstraintGenerator:
    DATA = {"ConstraintResult": []}
    
    def __init__(self, filename):
        module = readModule(filename)
        ir_module = giveName(module)
        self.MODULE = module
        self.IR_MODULE = ir_module
        self.CONSTRAINTS: list = []
        self.constraintRules: List[Constraint] = []
        self.functionConstraintRules: List[FunctionConstraint] = []

    def addConstraint(self, constraint: Constraint):
        constraint.MODULE = self.MODULE
        self.constraintRules.append(constraint)

    def addFunctionConstraint(self, constraint: FunctionConstraint):
        self.functionConstraintRules.append(constraint)

    def run(self):
        self.initConstraint()
        for function in self.MODULE.functions:
            # apply 
            for constraint in self.functionConstraintRules:
                constraint.applyConstraint(function)
            # apply constraints    
            for block in function.blocks:
                for instruction in block.instructions:
                    for constraint in self.constraintRules:
                        constraint.applyConstraint(instruction)

        for constraintRule in self.functionConstraintRules:
            constraint_results = constraintRule.dumpConstraint()
            if constraint_results:
                self.DATA['ConstraintResult'].append(constraint_results)
        for constraintRule in self.constraintRules:
            constraint_results = constraintRule.dumpConstraint()
            if(constraint_results):
                self.DATA['ConstraintResult'].append(constraint_results)
        return

    def dumpJson(self):
        return json.dumps(self.DATA)

    def saveJson(self, filename: str, time: float = 0):
        self.DATA['time'] = time
        counts = 0
        for i in self.DATA['ConstraintResult']:
            counts += len(i)
        self.DATA['counts'] = counts
        
        with open(filename, 'w') as json_file:
            json.dump(self.DATA, json_file, indent=4)

    def initConstraint(self):
        self.addFunctionConstraint(RetConstraint)

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