#!/usr/bin/env python3

import os, sys
import argparse

# config
disassemble = 'mcsema-disass-3.8 --disassembler /opt/ida-7.1/idat64'
lifting = 'mcsema-lift-9.0'

disassemble_options = {
	"arch": "x86",
	"os": "linux",
	"entrypoint": "main",
	"binary": "",
	"output": "",
	"log_file": ""
}

liftiong_options = {
	"arch": "x86",
	"os": "linux",
	"cfg": "",
	"output": "",
	"log": ""
}

parser = argparse.ArgumentParser()
parser.add_argument('command', help='disassemble or lifting')
parser.add_argument('')