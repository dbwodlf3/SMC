#!/usr/bin/env python3
import sys, os, time, argparse
import subprocess
from multiprocessing import Process
from ConstraintGenerator.Objects.ConstraintGenerator import ConstraintGenerator

src_dir = os.path.dirname(os.path.abspath(__file__))
project_dir = os.path.dirname(src_dir)

def test():
    test_file_dir = os.path.join(project_dir, 'test', 'llvmIR')
    result_save_dir = os.path.join(project_dir, 'dest')
    test_files = [file for file in os.listdir(test_file_dir)]
    for test_file in test_files:
        test_file_abs = os.path.join(test_file_dir, test_file)
        save_file_abs = os.path.join(
            result_save_dir, test_file.replace('.ll','.json'))
        p = Process(target=constraintGeneratorRun,
            args=(test_file_abs, save_file_abs, ))
        p.start()

def constraintGeneratorRun(srcFile: str, destFile: str):
    start = time.time()
    constraint_generator = ConstraintGenerator(srcFile)
    constraint_generator.run()

    end = time.time()
    constraint_generator.saveJson(destFile, end-start)

def main():
    test()




















if __name__ == '__main__':
    main()