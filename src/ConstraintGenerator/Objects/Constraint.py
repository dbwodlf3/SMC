import llvmlite.ir as llvmIR

class Constraint:
	"""Constraint Class for adding Constraint to Constraint Generator.
	Every Constraints applied ConstraintGenerator have to extend from this class.
	"""
	def __init__(self):
		self.isConstraintClass = True

class FunctionConstraint(Constraint):
	pass

class GlobalVarConstraint(Constraint):
	pass