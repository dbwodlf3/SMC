import llvmlite.ir as llvmIR
import llvmlite.binding as llvm

class Constraint:
    """Constraint Class for adding Constraint to Constraint Generator.
    Every Constraints applied ConstraintGenerator have to extend from this class.
    """
    CONSTRAINTS = []
    SYMBOLS = set()
    def __init__(self):
        self.isConstraintClass = True
    #
    @classmethod
    def applyConstraint(cls, instruction: llvmIR.Instruction):
        pass
    @classmethod
    def dumpConstraint(cls):
        """Return Value is IMM. DON'T EDIT IT."""
        return cls.CONSTRAINTS

class FunctionConstraint(Constraint):
    """FunctionConstraint Class is for constraint for function. like parameters
        or ret instruction.
    """
    CONSTRAINTS = []
    def __init__(self):
        self.isConstraintClass = True
    #
    @classmethod
    def applyConstraint(cls, function: llvm.ValueRef):
        pass

class GlobalVarConstraint(Constraint):
    pass