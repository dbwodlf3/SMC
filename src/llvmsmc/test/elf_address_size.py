import os
from elftools.elf.elffile import ELFFile

testfile_dir = os.path.join(os.path.dirname(__file__), 'testfiles')
testfile = os.path.join(os.path.join(testfile_dir, 'x86_smc1.out'))

def test(filename):
    with open(filename, 'rb') as f:
        elffile = ELFFile(f)

        for segment in elffile.iter_segments():
            if(segment['p_type'] == 'PT_LOAD' and segment['p_flags'] & 0b100):
                print(hex(segment['p_vaddr']))
                print(hex(segment['p_memsz']))

test(testfile)