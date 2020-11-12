from typing import List
from lib import util
from Objects.Constraint import Constraint

class ConstraintGenerator():
	constraints: List[Constraint] = []
	answer = {
		"Constraints":[],
		"Result":[]
	}
	#
	def __init__(self, irFile):
		self.MODULE = util.readModule(irFile)
	#
	# addConstraint it is not perfect loginc for applying constraints.
	# but it is very simple and easy way.
	def addConstraint(self, constraint: Constraint):
		self.constraints.append(constraint)
	#
	# run it is not perefct at performance. but it is very simple.
	# and anyway works.
	def run(self):
		for func in self.MODULE.functions:
			for block in func.blocks:
				for instruction in block.instructions:
					for constraint in self.constraints:
						constraint.applyConstraint(instruction)
		return;