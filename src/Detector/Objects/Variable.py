class Variable:
	def __init__(self, variableName: str, tokens: []):
		self.variableName = variableName
		self.tokens = tokens
	def __str__(self):
		return f'''Var Name: {self.variableName}
Tokens: {self.tokens}'''