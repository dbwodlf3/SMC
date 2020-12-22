#!/usr/bin/env python3

import json
from lib import CFG_pb2
from google.protobuf.json_format import MessageToJson

with open('./test.cfg', 'rb') as f:
	data = f.read()

MODULE = CFG_pb2.Module()

cfg = MODULE.ParseFromString(data)

# print(MODULE)
jsonData = MessageToJson(MODULE)

with open('./test.cfg.json', 'w')  as json_file:
	json_file.write(jsonData)