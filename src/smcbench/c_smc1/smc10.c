#include <stdio.h>
#include <sys/mman.h>

int getMemoryPermission(void*);

int main(void)
{
	// x86 code
	// char shellcode[] = 
	// "\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69"
	// "\x6e\x89\xe3\x50\x53\x89\xe1\xb0\x0b\xcd\x80";

	// x64 code
	char shellcode[] = 
	"\x48\x31\xf6\x56\x48\xbf\x2f\x62\x69\x6e\x2f\x2f\x73\x68\x57\x54\x5f"
	"\x6a\x3b\x58\x99\x0f\x05";	
	
	getMemoryPermission(&shellcode);

	((void(*)())shellcode)();

	return 0;
}

int getMemoryPermission(void *addr){
    
    int page_size = 4096;

    addr -= (unsigned long)addr % page_size;

    if(mprotect(addr, page_size, PROT_READ | PROT_WRITE | PROT_EXEC) == -1){
        return -1;
    }

    return 0;
}

/*
clang version 9.0.0-2~ubuntu18.04.2 (tags/RELEASE_900/final)
x86-64-pc-linux-gnu
*/

/* clang ll file
target="smc10"
clang-9 -S -emit-llvm ${target}.c -o clang_m64_${target}.ll
*/

/* clang binary file
target="smc10"
clang-9 ${target}.c -o clang_m64_${target}.out
*/

/*
GCC VERSION 7.5
*/

/* x64 PIE
target="smc10"
gcc -m64 -fpie -pie ${target}.c -o gcc_m64_PIE_${target}.out
objdump -d gcc_m64_PIE_${target}.out > gcc_m64_PIE_${target}.objdump
mcsema-disass-3.8 --disassembler /opt/ida-7.1/idat64 --os linux --arch amd64 --entrypoint main --binary gcc_m64_PIE_${target}.out --output gcc_m64_PIE_${target}.cfg --log_file gcc_m64_PIE_${target}.log
mcsema-lift-9.0 --os linux --arch amd64 --cfg gcc_m64_PIE_${target}.cfg --output gcc_m64_PIE_${target}.bc --log gcc_m64_PIE_${target}.lift.log
opt -O1 gcc_m64_PIE_${target}.bc -o gcc_m64_PIE_${target}.bc
llvm-dis gcc_m64_PIE_${target}.bc -o gcc_m64_PIE_${target}.ll

checksec --file=gcc_m64_PIE_${target}.out
*/

/* x64 NON-PIE
target="smc10"
gcc -m64 -fno-pie -no-pie ${target}.c -o gcc_m64_NO_PIE_${target}.out
objdump -d gcc_m64_NO_PIE_${target}.out > gcc_m64_NO_PIE_${target}.objdump
mcsema-disass-3.8 --disassembler /opt/ida-7.1/idat64 --os linux --arch amd64 --entrypoint main --binary gcc_m64_NO_PIE_${target}.out --output gcc_m64_NO_PIE_${target}.cfg --log_file gcc_m64_NO_PIE_${target}.log
mcsema-lift-9.0 --os linux --arch amd64 --cfg gcc_m64_NO_PIE_${target}.cfg --output gcc_m64_NO_PIE_${target}.bc --log gcc_m64_NO_PIE_${target}.lift.log
llvm-dis gcc_m64_NO_PIE_${target}.bc -o gcc_m64_NO_PIE_${target}.ll

checksec --file=gcc_m64_NO_PIE_${target}.out

opt -O1 gcc_m64_NO_PIE_${target}.bc -o gcc_m64_NO_PIE_${target}.ll && llvm-dis gcc_m64_NO_PIE_${target}.ll -o gcc_m64_NO_PIE_${target}.ll
*/