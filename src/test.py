#!/usr/bin/env python3
import sys, os, time, argparse
import subprocess
from multiprocessing import Process
from ConstraintGenerator.Objects.ConstraintGenerator import ConstraintGenerator
from CubicSolver.Objects.CubicSolver import CubicSolver
from Detector.Objects.Detector import Detector

src_dir = os.path.dirname(os.path.abspath(__file__))
project_dir = os.path.dirname(src_dir)
dest_dir = os.path.join(project_dir, 'dest')
os.makedirs(dest_dir, exist_ok=True)

def constraintGeneratorTest():
    test_file_dir = os.path.join(project_dir, 'test', 'llvmIR')
    result_save_dir = os.path.join(project_dir, 'dest', 'cg')
    os.makedirs(result_save_dir, exist_ok=True)
    test_files = [file for file in os.listdir(test_file_dir)]
    for test_file in test_files:
        test_file_abs = os.path.join(test_file_dir, test_file)
        save_file_abs = os.path.join(
            result_save_dir, test_file.replace('.ll','.json'))
        p = Process(target=constraintGeneratorRun,
            args=(test_file_abs, save_file_abs, ))
        p.start()

def cubicSolverTest():
    test_file_dir = os.path.join(project_dir, 'dest', 'cg')
    result_save_dir = os.path.join(project_dir, 'dest', 'cs')
    os.makedirs(result_save_dir, exist_ok=True)
    test_files = [file for file in os.listdir(test_file_dir)]
    for test_file in test_files:
        test_file_abs = os.path.join(test_file_dir, test_file)
        save_file_abs = os.path.join(
            result_save_dir, test_file.replace('.json','.cs.json'))
        p = Process(target=cubicSolverRun,
            args=(test_file_abs, save_file_abs, ))
        p.start()

def detectorTest():
    pass

def constraintGeneratorRun(srcFile: str, destFile: str):
    start = time.time()
    constraint_generator = ConstraintGenerator(srcFile)
    constraint_generator.run()

    end = time.time()
    constraint_generator.saveJson(destFile, end - start)

def cubicSolverRun(srcFile: str, destFile: str):
    start = time.time()
    cubic_solver = CubicSolver(srcFile)
    cubic_solver.run()

    end = time.time()
    cubic_solver.saveJson(destFile, end - start)

def detectorRun(llvmFile: str, variableFile: str, resultFile: str):
    start = time.time()
    detector = Detector()

    detector.run()
    end = time.time()
    detector.saveJson(resultFile, end - start)

def main():
    constraintGeneratorTest()
    cubicSolverTest()
    detectorTest()



















if __name__ == '__main__':
    main()