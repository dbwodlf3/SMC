import json

def readJson(filename: str):
	with open(filename) as json_file:
		return json.load(json_file)