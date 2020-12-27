#!/usr/bin/env python3
import sys, os
import subprocess

from setuptools import find_packages, setup, Command

src_dir = os.path.abspath(os.path.dirname(__file__))
llvmsmc_dir = os.path.join(src_dir, 'llvmsmc')

class run(Command):
    description = 'execute main test'
    user_options = []

    def initialize_options(self):
        return 0
    
    def finalize_options(self):
        return 0
    
    def run(self):
        os.chdir(llvmsmc_dir)
        subprocess.call(['python3', 'test.py'], stdout=sys.__stdout__)

class test(Command):
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
        if not self.script:
            return print('select test script file!')
        os.chdir(llvmsmc_dir)
        subprocess.call(['python3', '-m', 'test.'+self.script],
            stdout=sys.__stdout__)

requires = []

setup(name='llvmsmc',
      version='0.1',
      description='smc solver',
      author='Ryu JaeIL',
      packages=find_packages(),
      cmdclass={'run': run, 'test': test},
      )