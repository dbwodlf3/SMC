#!/usr/bin/env python3
import os

from setuptools import find_packages, setup, Command

class entry(Command):
    description = 'execute scripts with module path'
    user_options = [
        ('script=', None, 'script name'),
    ]

    def initialize_options(self):
        self.script = None
        return 0

    def finalize_options(self):
        return 0

    def run(self):
        os.system('echo ' + os.getcwd())

requires = []

setup(name='llvmsmc',
      version='0.1',
      description='smc solver',
      author='Ryu JaeIL',
      packages=find_packages(),
      cmdclass={'entry': entry},
      )

# NOT Yet...