import json
from typing import List
from lib import util
from CubicSolver.Objects.Node import Node

# @Todo make more faster CubicSolver...
class CubicSolver:
    """Class for get the solution from andersen algorithm.
    """
    result = {
        'variables':{}
    }

    def __init__(self, filename: str):

        # read constraint json file.
        data = util.readJson(filename)
        
        # Constraints
        self.constraints = []

        # Tokens
        self.tokens = []
        self.tokenLength = 0

        # Node List
        self.nodes :List[Node] = []

        # mapped list. 
        # it is for being used to map a bit to key, and key to a bit.
        self.indexMap = {}
        self.keyMap = {}

        # Inner condtion flag.
        self._continueCondition = 2

        # symbol is just characters existing in constraints
        symbol_set = set()
        for constraints in data['ConstraintResult']:
            for constraint in constraints:
                self.constraints.append(constraint)

                for i in range (1, len(constraint)):
                    symbol_set.add(constraint[i])
            
        self.tokens = list(symbol_set)
        self.tokens.sort()
        self.tokenLength = len(self.tokens)
        
        # map bits to token.
        for idx, key in enumerate(self.tokens):
            self.indexMap[idx] = key
            self.keyMap[key] = idx
        
        # set bitarray of Node
        Node.setTokenCount(self.tokenLength)

        # make nodes from token.
        for i in self.indexMap:
            node = Node(self.indexMap[i], i)
            self.nodes.append(node)
    
    def applyConstraint(self, rule):
        rule_type = rule[0]
        if rule_type == 0:
            self.addToken(rule[1], rule[1])
        elif rule_type == 1:
            self.addToken(rule[1], rule[2])
        elif rule_type == 2:
            self.addEdge(rule[1], rule[2])
        elif rule_type == 3:
            self.addCondition(rule[1], rule[2], True)
        elif rule_type == 4:
            self.addCondition(rule[1], rule[2], False)
        elif rule_type == 5:
            self.addToken('!code!', rule[1])
        elif rule_type == 6:
            self.addToken('!data!', rule[1])
    
    def addEdge(self, source: str, dest: str):
        source_idx = self.keyMap[source]
        dest_idx = self.keyMap[dest]
        self.nodes[source_idx].edges.add(dest_idx)
    
    def addToken(self, source: str, dest: str):
        source_idx = self.keyMap[source]
        dest_idx = self.keyMap[dest]
        self.nodes[dest_idx].tokens[source_idx] = True
    
    # @Todo Condtion Update per bitvector.
    def addCondition(self, source: str, operand: str, type: bool):
        source_idx = self.keyMap[source]
        operand_idx = self.keyMap[operand]
        self.nodes[source_idx].conectCondtions.add((type, operand_idx))
   
    def run(self):
        # init for run
        for i in self.constraints:
            self.applyConstraint(i)
        #
        #
        # update Edge
        while(self.checkContinue()):
            self.updateEdge()
            # check condition
            self.checkCondition()
        # update result
        self.updateResult()
   
    def updateEdge(self):
        for node in self.nodes:
            for destNodeIdx in node.edges:
                self.nodes[destNodeIdx].tokens = self.nodes[destNodeIdx].tokens\
                    | node.tokens
   
    # @Todo It need to more comments.. and refactoring for ez code.
    def checkCondition(self):
        for node in self.nodes:
            for connectCondition in node.conectCondtions:
                for tokenIdx, tokenVal in enumerate(node.tokens):
                    if tokenVal:
                        if connectCondition[0]:
                            if connectCondition[1] in self.nodes[tokenIdx].edges:
                                continue
                            else:
                                self.nodes[tokenIdx].edges.add(connectCondition[1])
                                self.changedEdge()
                        else:
                            if tokenIdx in self.nodes[connectCondition[1]].edges:
                                continue
                            else:
                                self.nodes[connectCondition[1]].edges.add(tokenIdx)
                                self.changedEdge()
   
    def changedEdge(self):
        self._continueCondition = 2
   
    def checkContinue(self):
        if self._continueCondition < 0:
            return False
        else:
            self._continueCondition -= 1
            return True
    
    def saveJson(self, filename:str, time: float = 0):
        CubicSolver.result['time'] = time
        CubicSolver.result['counts'] = len(self.result['variables'])
        with open(filename, 'w') as json_file:
            json.dump(self.result, json_file, indent=4)
    
    def updateResult(self):
        for node in self.nodes:
            var = {node.key : []}
            for idx, condition in enumerate(node.tokens):
                if condition:
                    var[node.key].append(self.nodes[idx].key)
            CubicSolver.result['variables'].update(var)
    
    def __str__(self):
        name = f'''
cubicSolver: {repr(self)}
tokenLength: {self.tokenLength}
        '''
        return name