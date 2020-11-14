import llvmlite.ir as llvmIR

class Constraint:
    """Constraint Class for adding Constraint to Constraint Generator.
    Every Constraints applied ConstraintGenerator have to extend from this class.
    """
    CONSTRAINTS = []
    def __init__(self):
        self.isConstraintClass = True
    #
    @staticmethod
    def applyConstraint(instruction: llvmIR.Instruction):
        pass
    @classmethod
    def dumpConstraint(cls) -> list:
        """Return Value is IMM. DON'T EDIT IT."""
        return cls.CONSTRAINTS

class FunctionConstraint(Constraint):
    pass

class GlobalVarConstraint(Constraint):
    pass