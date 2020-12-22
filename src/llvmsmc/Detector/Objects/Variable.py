from json import JSONEncoder

class Variable:
	def __init__(self, variableName: str, tokens: []):
		self.name = variableName
		self.tokens = tokens
	def __name__(self):
		return self.name
	def __str__(self):
		return self.name
	def __repr__(self):
		return self.name