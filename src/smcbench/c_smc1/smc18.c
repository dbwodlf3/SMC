#include <stdio.h>
#include <sys/mman.h>

int getMemoryPermission(void*);

int main(){
  char code[8];
  
  code[0] = '\xb8';
  code[1] = '\x01';
  code[2] = '\x00';
  code[3] = '\x00';
  code[4] = '\x00';
  code[5] = '\xcd';
  code[6] = '\x80';
  code[7] = '\x00';

  getMemoryPermission(&code);
  
  ((void(*)())code)();

  printf("This is not excuted");

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
It works ELF32 and ELF64 on X86 and AMD64.
Because instruction binary is same.
*/

/* clang ll file
target="smc18"
clang-9 -S -emit-llvm ${target}.c -o clang_m64_${target}.ll
*/


/*
clang version 9.0.0-2~ubuntu18.04.2 (tags/RELEASE_900/final)
x86-64-pc-linux-gnu
*/

/* clang ll file
target="smc18"
clang-9 -S -emit-llvm ${target}.c -o clang_m64_${target}.ll
*/

/*
GCC VERSION 7.5
*/

/* x64 PIE
target="smc18"
gcc -m64 -fpie -pie ${target}.c -o gcc_m64_PIE_${target}.out
objdump -d gcc_m64_PIE_${target}.out > gcc_m64_PIE_${target}.objdump
mcsema-disass-3.8 --disassembler /opt/ida-7.1/idat64 --os linux --arch amd64 --entrypoint main --binary gcc_m64_PIE_${target}.out --output gcc_m64_PIE_${target}.cfg --log_file gcc_m64_PIE_${target}.log
mcsema-lift-9.0 --os linux --arch amd64 --cfg gcc_m64_PIE_${target}.cfg --output gcc_m64_PIE_${target}.bc --log gcc_m64_PIE_${target}.lift.log
llvm-dis gcc_m64_PIE_${target}.bc -o gcc_m64_PIE_${target}.ll

checksec --file=gcc_m64_PIE_${target}.out

opt -O1 gcc_m64_PIE_${target}.bc -o gcc_m64_PIE_${target}.ll && llvm-dis gcc_m64_PIE_${target}.ll -o gcc_m64_PIE_${target}.ll
*/

/* x64 NON-PIE
target="smc18"
gcc -m64 -fno-pie -no-pie ${target}.c -o gcc_m64_NO_PIE_${target}.out
objdump -d gcc_m64_NO_PIE_${target}.out > gcc_m64_NO_PIE_${target}.objdump
mcsema-disass-3.8 --disassembler /opt/ida-7.1/idat64 --os linux --arch amd64 --entrypoint main --binary gcc_m64_NO_PIE_${target}.out --output gcc_m64_NO_PIE_${target}.cfg --log_file gcc_m64_NO_PIE_${target}.log
mcsema-lift-9.0 --os linux --arch amd64 --cfg gcc_m64_NO_PIE_${target}.cfg --output gcc_m64_NO_PIE_${target}.bc --log gcc_m64_NO_PIE_${target}.lift.log
llvm-dis gcc_m64_NO_PIE_${target}.bc -o gcc_m64_NO_PIE_${target}.ll

checksec --file=gcc_m64_NO_PIE_${target}.out

opt -O1 gcc_m64_NO_PIE_${target}.bc -o gcc_m64_NO_PIE_${target}.ll && llvm-dis gcc_m64_NO_PIE_${target}.ll -o gcc_m64_NO_PIE_${target}.ll
*/