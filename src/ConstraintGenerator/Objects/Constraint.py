import llvmlite.ir as llvmIR

class Constraint:
    """Constraint Class for adding Constraint to Constraint Generator.
    Every Constraints applied ConstraintGenerator have to extend from this class.
    """
    CONSTRAINTS = []
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
    @staticmethod
    def resolveConstantExpr(operand):
        print(operand.name)

class FunctionConstraint(Constraint):
    """
    """
    @staticmethod
    def applyConstraint(function: llvmIR.Function):
        print('do something')

class GlobalVarConstraint(Constraint):
    pass