#include <stdio.h>
#include <sys/mman.h>

int getMemoryPermission(void*);

int main()
{
  getMemoryPermission(main);
  unsigned long long *write_address = 0;
  // printf("1 => %lld\n", write_address);
  unsigned int offset1 = 0x1;
  unsigned int offset2 = 0x2;
  unsigned int offset3 = 0x3;
  unsigned int offset4 = 0x4;
  unsigned int offset5 = 0x5;
  unsigned int offset6 = 0x4c;
  unsigned int temp = (void *)main + offset1 + offset2 + offset3
  + offset4 + offset5 + offset6;

  write_address = temp;
  // printf("2 => %lld \n", write_address);
  
  *write_address = 0x9090909090909090;

  main();
  __asm__("nop");
  __asm__("nop");
  __asm__("nop");
  
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
target="smc23"
clang-9 -S -emit-llvm ${target}.c -o clang_m64_${target}.ll
*/

/*
GCC VERSION 7.5
*/

/* x64 PIE
target="smc23"
gcc -m64 -fpie -pie ${target}.c -o gcc_m64_PIE_${target}.out
objdump -d gcc_m64_PIE_${target}.out > gcc_m64_PIE_${target}.objdump
mcsema-disass-3.8 --disassembler /opt/ida-7.1/idat64 --os linux --arch amd64 --entrypoint main --binary gcc_m64_PIE_${target}.out --output gcc_m64_PIE_${target}.cfg --log_file gcc_m64_PIE_${target}.log
mcsema-lift-9.0 --os linux --arch amd64 --cfg gcc_m64_PIE_${target}.cfg --output gcc_m64_PIE_${target}.bc --log gcc_m64_PIE_${target}.lift.log
opt -O1 gcc_m64_PIE_${target}.bc -o gcc_m64_PIE_${target}.bc
llvm-dis gcc_m64_PIE_${target}.bc -o gcc_m64_PIE_${target}.ll

checksec --file=gcc_m64_PIE_${target}.out
*/

/* x64 NON-PIE
target="smc23"
gcc -m64 -fno-pie -no-pie ${target}.c -o gcc_m64_NO_PIE_${target}.out
objdump -d gcc_m64_NO_PIE_${target}.out > gcc_m64_NO_PIE_${target}.objdump
mcsema-disass-3.8 --disassembler /opt/ida-7.1/idat64 --os linux --arch amd64 --entrypoint main --binary gcc_m64_NO_PIE_${target}.out --output gcc_m64_NO_PIE_${target}.cfg --log_file gcc_m64_NO_PIE_${target}.log
mcsema-lift-9.0 --os linux --arch amd64 --cfg gcc_m64_NO_PIE_${target}.cfg --output gcc_m64_NO_PIE_${target}.bc --log gcc_m64_NO_PIE_${target}.lift.log
opt -O2 gcc_m64_NO_PIE_${target}.bc -o gcc_m64_NO_PIE_${target}.bc
llvm-dis gcc_m64_NO_PIE_${target}.bc -o gcc_m64_NO_PIE_${target}.ll

checksec --file=gcc_m64_NO_PIE_${target}.out
*/