#include <stdio.h>
#include <sys/mman.h>

int getMemoryPermission(void*);

char code[] = 
"\xb8\x01\x00\x00\x00"
"\xcd\x80";


int main(){

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
target="smc12"
clang-9 -S -emit-llvm ${target}.c -o clang_m64_${target}.ll
*/

/* clang binary file
target="smc12"
clang-9 ${target}.c -o clang_m64_${target}.out
*/

/*
clang version 9.0.0-2~ubuntu18.04.2 (tags/RELEASE_900/final)
x86-64-pc-linux-gnu
*/

/* clang ll file
target="smc12"
clang-9 -S -emit-llvm ${target}.c -o clang_m64_${target}.ll
*/

/*
target="smc12"
clang-9 -fPIE -pie -target i386-pc-linux-gnu ${target}.c -o a.out
objdump -d a.out > a.out.objdump
*/

/*
GCC VERSION 7.5
*/

/* x64 PIE
target="smc12"
gcc -m64 -fpie -pie ${target}.c -o gcc_m64_PIE_${target}.out
objdump -d gcc_m64_PIE_${target}.out > gcc_m64_PIE_${target}.objdump
mcsema-disass-3.8 --disassembler /opt/ida-7.1/idat64 --os linux --arch amd64 --entrypoint main --binary gcc_m64_PIE_${target}.out --output gcc_m64_PIE_${target}.cfg --log_file gcc_m64_PIE_${target}.log
mcsema-lift-9.0 --os linux --arch amd64 --cfg gcc_m64_PIE_${target}.cfg --output gcc_m64_PIE_${target}.bc --log gcc_m64_PIE_${target}.lift.log
opt -O1 gcc_m64_PIE_${target}.bc -o gcc_m64_PIE_${target}.bc
llvm-dis gcc_m64_PIE_${target}.bc -o gcc_m64_PIE_${target}.ll
checksec --file=gcc_m64_PIE_${target}.out
*/

/* x64 NON-PIE
target="smc12"
gcc -m64 -fno-pie -no-pie ${target}.c -o gcc_m64_NO_PIE_${target}.out
objdump -d gcc_m64_NO_PIE_${target}.out > gcc_m64_NO_PIE_${target}.objdump
mcsema-disass-3.8 --disassembler /opt/ida-7.1/idat64 --os linux --arch amd64 --entrypoint main --binary gcc_m64_NO_PIE_${target}.out --output gcc_m64_NO_PIE_${target}.cfg --log_file gcc_m64_NO_PIE_${target}.log
mcsema-lift-9.0 --os linux --arch amd64 --cfg gcc_m64_NO_PIE_${target}.cfg --output gcc_m64_NO_PIE_${target}.bc --log gcc_m64_NO_PIE_${target}.lift.log
llvm-dis gcc_m64_NO_PIE_${target}.bc -o gcc_m64_NO_PIE_${target}.ll

checksec --file=gcc_m64_NO_PIE_${target}.out

opt -O1 gcc_m64_NO_PIE_${target}.bc -o gcc_m64_NO_PIE_${target}.ll && llvm-dis gcc_m64_NO_PIE_${target}.ll -o gcc_m64_NO_PIE_${target}.ll
*/

/* x32 PIE
target="smc12"
gcc -m32 -fPIE -pie ${target}.c -o gcc_m32_PIE_${target}.out
objdump -d gcc_m32_PIE_${target}.out > gcc_m32_PIE_${target}.objdump
mcsema-disass-3.8 --disassembler /opt/ida-7.1/idat64 --os linux --arch x86 --entrypoint main --binary gcc_m32_PIE_${target}.out --output gcc_m32_PIE_${target}.cfg --log_file gcc_m32_PIE_${target}.log
mcsema-lift-9.0 --os linux --arch x86 --cfg gcc_m32_PIE_${target}.cfg --output gcc_m32_PIE_${target}.bc --log gcc_m32_PIE_${target}.lift.log
llvm-dis gcc_m32_PIE_${target}.bc -o gcc_m32_PIE_${target}.ll

opt -O1 gcc_m32_PIE_${target}.bc -o gcc_m32_PIE_${target}.bc
llvm-dis gcc_m32_PIE_${target}.bc -o gcc_m32_PIE_${target}.ll
checksec --file=gcc_m32_PIE_${target}.out
*/

/* x32 NON-PIE
target="smc12"
gcc -m32 -fno-PIE -no-pie ${target}.c -o gcc_m32_NO_PIE_${target}.out
objdump -d gcc_m32_NO_PIE_${target}.out > gcc_m32_NO_PIE_${target}.objdump
mcsema-disass-3.8 --disassembler /opt/ida-7.1/idat64 --os linux --arch x86 --entrypoint main --binary gcc_m32_NO_PIE_${target}.out --output gcc_m32_NO_PIE_${target}.cfg --log_file gcc_m32_NO_PIE_${target}.log
mcsema-lift-9.0 --os linux --arch x86 --cfg gcc_m32_NO_PIE_${target}.cfg --output gcc_m32_NO_PIE_${target}.bc --log gcc_m32_NO_PIE_${target}.lift.log
llvm-dis gcc_m32_NO_PIE_${target}.bc -o gcc_m32_NO_PIE_${target}.ll

checksec --file=gcc_m32_NO_PIE_${target}.out
*/