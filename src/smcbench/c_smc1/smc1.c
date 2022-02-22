#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/mman.h>

#define NUM 8       // fib(8) !!!


int change_page_permissions_of_address(void *addr);
void get_permission(void* foo_addr);

char* err_string = "Error while changing page permissions of foo()\n";

int main(void){
    // code ptr to key
    unsigned char* ptr_key = (unsigned char*)main + 107;  // objdump로 확인!!!

    int counter;
    unsigned char instr9[4];
    unsigned char instr10[4];
    int index;
    unsigned char fib_index;

    // initialize
    get_permission(main);

    // SMC1

    // lw $4, num
    counter = NUM;

    // lw $9, key
    memcpy( instr9, ptr_key, 4);

    // li $8, 1
    index = 1;

    // li $2, 1
    fib_index  = 1;

loop:
    // beq $8, $4, halt
    if (index == counter) goto halt;

    // addi $8, $8, 1
    index = index + 1;

    // add $10, $9, $2
    memcpy( instr10, instr9, 4);
    instr10[3] = instr10[3] + fib_index  - 1;  // difference!!

key:
    // addi $2, $2, 0 
    fib_index = fib_index + 1;   // difference!!

    // sw $10, key
    memcpy(ptr_key, instr10, 4);

    // for debugging
    // printf("fib(%d)=%d\n", index, fib_index);

    // j loop
    goto loop;

halt:
    printf("fib(%d)=%d\n", counter, fib_index);

    return 0;
}


///////////////////////////////
// Permission-related functions
///////////////////////////////

void get_permission(void* foo_addr) {
    if(change_page_permissions_of_address(foo_addr) == -1) {
        write(STDERR_FILENO, err_string, strlen(err_string) + 1);
        exit(1);
    }    
}

int change_page_permissions_of_address(void *addr){
    
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
target="smc1"
clang-9 -S -emit-llvm ${target}.c -o clang_m64_${target}.ll
*/

/*
target="smc1"
clang-9 -fPIE -pie -target i386-pc-linux-gnu ${target}.c -o a.out
objdump -d a.out > a.out.objdump
*/

/*
GCC VERSION 7.5
*/

/* x64 PIE
target="smc1"
gcc -m64 -fpie -pie ${target}.c -o gcc_m64_PIE_${target}.out
objdump -d gcc_m64_PIE_${target}.out > gcc_m64_PIE_${target}.objdump
mcsema-disass-3.8 --disassembler /opt/ida-7.1/idat64 --os linux --arch amd64 --entrypoint main --binary gcc_m64_PIE_${target}.out --output gcc_m64_PIE_${target}.cfg --log_file gcc_m64_PIE_${target}.log --pie-mode
mcsema-lift-9.0 --os linux --arch amd64 --cfg gcc_m64_PIE_${target}.cfg --output gcc_m64_PIE_${target}.bc --log gcc_m64_PIE_${target}.lift.log
opt -O1 gcc_m64_PIE_${target}.bc -o gcc_m64_PIE_${target}.bc
llvm-dis gcc_m64_PIE_${target}.bc -o gcc_m64_PIE_${target}.ll

checksec --file=gcc_m64_PIE_${target}.out
*/

/* x64 NON-PIE
target="smc1"
gcc -m64 -fno-pie -no-pie ${target}.c -o gcc_m64_NO_PIE_${target}.out
objdump -d gcc_m64_NO_PIE_${target}.out > gcc_m64_NO_PIE_${target}.objdump
mcsema-disass-3.8 --disassembler /opt/ida-7.1/idat64 --os linux --arch amd64 --entrypoint main --binary gcc_m64_NO_PIE_${target}.out --output gcc_m64_NO_PIE_${target}.cfg --log_file gcc_m64_NO_PIE_${target}.log
mcsema-lift-9.0 --os linux --arch amd64 --cfg gcc_m64_NO_PIE_${target}.cfg --output gcc_m64_NO_PIE_${target}.bc --log gcc_m64_NO_PIE_${target}.lift.log
llvm-dis gcc_m64_NO_PIE_${target}.bc -o gcc_m64_NO_PIE_${target}.ll

checksec --file=gcc_m64_NO_PIE_${target}.out
*/

/* x32 PIE
target="smc1"
gcc -m32 -fPIE -pie ${target}.c -o gcc_m32_PIE_${target}.out
objdump -d gcc_m32_PIE_${target}.out > gcc_m32_PIE_${target}.objdump
mcsema-disass-3.8 --disassembler /opt/ida-7.1/idat64 --os linux --arch x86 --entrypoint main --binary gcc_m32_PIE_${target}.out --output gcc_m32_PIE_${target}.cfg --log_file gcc_m32_PIE_${target}.log --pie-mode
mcsema-lift-9.0 --os linux --arch x86 --cfg gcc_m32_PIE_${target}.cfg --output gcc_m32_PIE_${target}.bc --log gcc_m32_PIE_${target}.lift.log
opt -O1 gcc_m32_PIE_${target}.bc -o gcc_m32_PIE_${target}.bc
llvm-dis gcc_m32_PIE_${target}.bc -o gcc_m32_PIE_${target}.ll

llvm-dis gcc_m32_PIE_${target}.bc -o gcc_m32_PIE_${target}.ll
checksec --file=gcc_m32_PIE_${target}.out
*/

/* x32 NON-PIE
target="smc1"
gcc -m32 -fno-PIE -no-pie ${target}.c -o gcc_m32_NO_PIE_${target}.out
objdump -d gcc_m32_NO_PIE_${target}.out > gcc_m32_NO_PIE_${target}.objdump
mcsema-disass-3.8 --disassembler /opt/ida-7.1/idat64 --os linux --arch x86 --entrypoint main --binary gcc_m32_NO_PIE_${target}.out --output gcc_m32_NO_PIE_${target}.cfg --log_file gcc_m32_NO_PIE_${target}.log
mcsema-lift-9.0 --os linux --arch x86 --cfg gcc_m32_NO_PIE_${target}.cfg --output gcc_m32_NO_PIE_${target}.bc --log gcc_m32_NO_PIE_${target}.lift.log
opt -O1 gcc_m32_NO_PIE_${target}.bc -o gcc_m32_NO_PIE_${target}.bc
llvm-dis gcc_m32_NO_PIE_${target}.bc -o gcc_m32_NO_PIE_${target}.ll

checksec --file=gcc_m32_NO_PIE_${target}.out
*/