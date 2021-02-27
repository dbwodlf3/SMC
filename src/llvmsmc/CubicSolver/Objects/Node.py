from bitarray import bitarray

class Node:
	TOKEN_COUNTS = 0
	def __init__(self, key, idx):
		self.key = key
		self.idx = idx
		self.tokens = bitarray(self.TOKEN_COUNTS)
		self.tokens.setall(False)
		# Condtion. (True, A) | (False, A) 
		# IF 0, then t => A
		# else
		# IF idx is true, then A => B
		self.conectCondtions = set()
		# edge 들에 대해서는 or 연산.
		self.edges = set()
		# condition 에 대해서 체크하고 edge 를 추가합니다..
	@classmethod
	def setTokenCount(cls, number):
		cls.TOKEN_COUNTS = number
	def __str__(self):
		return f'''Node key : {self.key}
Node index : {self.idx}
Node edges : {self.edges}
Node tokens : {self.tokens}
Connect condtions : {self.conectCondtions}
'''
