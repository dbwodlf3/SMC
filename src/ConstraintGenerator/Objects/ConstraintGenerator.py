from typing import List
import json
import llvmlite.binding as llvm
import llvmlite.ir as ir
from lib.util import readModule, giveName
from Objects.Constraint import Constraint
from Objects.BasicConstraint import *

class ConstraintGenerator:
    DATA = {"ConstraintResult": []}
    #
    def __init__(self, filename):
        module = readModule(filename)
        ir_module = giveName(module)
        self.MODULE = module
        self.IR_MODULE = ir_module
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
        self.initConstraint()
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
    def saveJson(self, filename: str, time: float = 0):
        self.DATA['time'] = time
        with open(filename, 'w') as json_file:
            json.dump(self.DATA, json_file, indent=4)
    def initConstraint(self):
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