from typing import List
import json
import llvmlite.binding as llvm
import llvmlite.ir as ir
from Objects.Constraint import Constraint

class ConstraintGenerator:
    DATA = {"ConstraintResult": []}
    #
    def __init__(self, module: llvm.ModuleRef, irModule: ir.Module):
        self.MODULE = module
        self.IR_MODULE = irModule
        self.CONSTRAINTS: list = []
        self.constraintRules: List[Constraint] = []
    #
    # addConstraint it is not perfect loginc for applying constraints.
    # but it is very simple and easy way.
    def addConstraint(self, constraint: Constraint):
        self.constraintRules.append(constraint)
    #
    # run it is not perefct at performance. but it is very simple.
    # and anyway works.
    def run(self):
        for func in self.MODULE.functions:
            for block in func.blocks:
                for instruction in block.instructions:
                    for constraint in self.constraintRules:
                        constraint.applyConstraint(instruction)
        for constraintRule in self.constraintRules:
            constraint_results = constraintRule.dumpConstraint()
            if(constraint_results):
                self.DATA['ConstraintResult'].append(constraint_results)
        return;
    def dumpJson(self):
        return json.dumps(self.DATA)
    def saveJson(self, filename: str):
        with open(filename, 'w') as json_file:
            json.dump(self.DATA, json_file)