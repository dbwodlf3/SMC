#!/usr/bin/env python3
import sys, os, time, argparse
from multiprocessing import Process
from ConstraintGenerator.Objects.ConstraintGenerator import ConstraintGenerator
from CubicSolver.Objects.CubicSolver import CubicSolver
from Detector.Objects.Detector import Detector

src_dir = os.path.dirname(os.path.abspath(__file__))
project_dir = os.path.dirname(os.path.dirname(src_dir))
dest_dir = os.path.join(project_dir, 'dest')
os.makedirs(dest_dir, exist_ok=True)

processing_jobs = []

def constraintGeneratorTest():
    result_save_dir = os.path.join(project_dir, 'dest', 'cg')
    os.makedirs(result_save_dir, exist_ok=True)
    
    ll_test_file_dir = os.path.join(project_dir, 'test', 'llvmIR')
    binary_test_file_dir = os.path.join(project_dir, 'test', 'binary')

    ll_test_files = [file for file in os.listdir(ll_test_file_dir)]
    binary_test_files = [file for file in os.listdir(binary_test_file_dir)]

    ll_test_files.sort()
    binary_test_files.sort()

    process_list = []

    for test_file, binary_file in zip(ll_test_files, binary_test_files):
        test_file_abs = os.path.join(ll_test_file_dir, test_file)
        binary_file_abs = os.path.join(binary_test_file_dir, binary_file)
        save_file_abs = os.path.join(
            result_save_dir, test_file.replace('.ll','.json'))

        p = Process(target=constraintGeneratorRun,
            args=(test_file_abs, binary_file_abs, save_file_abs, ))
        process_list.append(p)
        p.start()
    
    for process in process_list:
        process.join()

def constraintGeneratorTestClang():
    result_save_dir = os.path.join(project_dir, 'dest', 'cg')
    os.makedirs(result_save_dir, exist_ok=True)

    ll_test_file_dir = os.path.join(project_dir, 'test', 'clang')

    ll_test_files = [file for file in os.listdir(ll_test_file_dir)]

    process_list = []

    for test_file in ll_test_files:
        test_file_abs = os.path.join(ll_test_file_dir, test_file)
        binary_file_abs = None
        save_file_abs = os.path.join(
            result_save_dir, test_file.replace('.ll','.json'))
        
        p = Process(target=constraintGeneratorRun,
            args=(test_file_abs, binary_file_abs, save_file_abs, ))
        process_list.append(p)
        p.start()
    
    for process in process_list:
        process.join()

def cubicSolverTest():
    result_save_dir = os.path.join(project_dir, 'dest', 'cs')
    os.makedirs(result_save_dir, exist_ok=True)
    test_file_dir = os.path.join(project_dir, 'dest', 'cg')
    test_files = [file for file in os.listdir(test_file_dir)]
    process_list = []

    for test_file in test_files:
        test_file_abs = os.path.join(test_file_dir, test_file)
        save_file_abs = os.path.join(
            result_save_dir, test_file.replace('.json','.cs.json'))
        p = Process(target=cubicSolverRun,
            args=(test_file_abs, save_file_abs, ))

        process_list.append(p)
        p.start()
    
    for process in process_list:
        process.join()

def detectorTest():
    result_save_dir = os.path.join(project_dir, 'dest', 'de')
    os.makedirs(result_save_dir, exist_ok=True)
    llvm_ir_dir = os.path.join(project_dir, 'test', 'llvmIR')
    cs_file_dir = os.path.join(project_dir, 'dest', 'cs')
    llvm_ir_files = [file for file in os.listdir(llvm_ir_dir)]
    cs_files = [file for file in os.listdir(cs_file_dir)]
    process_list = []

    llvm_ir_files.sort()
    cs_files.sort()

    i = 0

    for llvm_ir_file, cs_file in zip(llvm_ir_files, cs_files):
        llvm_ir_file_abs = os.path.join(llvm_ir_dir, llvm_ir_file)
        cs_file_abs = os.path.join(cs_file_dir, cs_file)
        save_file_abs = os.path.join(
            result_save_dir, llvm_ir_file.replace('.ll', '.de.json'))
        p = Process(target=detectorRun, args=(llvm_ir_file_abs,
            cs_file_abs, save_file_abs ))
        
        # if(cs_file != 'smc1.c.cs.json'):
        #     continue

        # print(cs_file)
        process_list.append(p)
        p.start()

    for process in process_list:
        process.join()

def detectorTestClang():
    result_save_dir = os.path.join(project_dir, 'dest', 'de')
    os.makedirs(result_save_dir, exist_ok=True)
    llvm_ir_dir = os.path.join(project_dir, 'test', 'clang')
    cs_file_dir = os.path.join(project_dir, 'dest', 'cs')
    llvm_ir_files = [file for file in os.listdir(llvm_ir_dir)]
    cs_files = [file for file in os.listdir(cs_file_dir)]
    process_list = []

    llvm_ir_files.sort()
    cs_files.sort()

    i = 0

    for llvm_ir_file, cs_file in zip(llvm_ir_files, cs_files):
        llvm_ir_file_abs = os.path.join(llvm_ir_dir, llvm_ir_file)
        cs_file_abs = os.path.join(cs_file_dir, cs_file)
        save_file_abs = os.path.join(
            result_save_dir, llvm_ir_file.replace('.ll', '.de.json'))
        p = Process(target=detectorRun, args=(llvm_ir_file_abs,
            cs_file_abs, save_file_abs ))
        
        # if(cs_file != 'smc1.c.cs.json'):
        #     continue

        # print(cs_file)
        process_list.append(p)
        p.start()

    for process in process_list:
        process.join()

def constraintGeneratorRun(llFile: str, binaryFile: str, destFile: str):
    start = time.time()
    constraint_generator = ConstraintGenerator(llFile, binaryFile)

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
    detector = Detector(llvmFile, variableFile)

    detector.run()
    end = time.time()
    detector.saveJson(resultFile, end - start)

def main():
    # constraintGeneratorTestClang()
    constraintGeneratorTest()
    cubicSolverTest()
    detectorTest()
    # detectorTestClang()


















if __name__ == '__main__':
    main()