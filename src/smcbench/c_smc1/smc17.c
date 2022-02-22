int main(){
  unsigned char *write_address = (unsigned char *)main + 107;
  *write_address = 0x90;

  return 0;
}


/*
clang version 9.0.0-2~ubuntu18.04.2 (tags/RELEASE_900/final)
x86-64-pc-linux-gnu
*/

/* clang ll file
target="smc17"
clang-9 -S -emit-llvm ${target}.c -o clang_m64_${target}.ll
*/

/* x64 PIE
target="smc17"
gcc -m64 -fpie -pie ${target}.c -o gcc_m64_PIE_${target}.out
objdump -d gcc_m64_PIE_${target}.out > gcc_m64_PIE_${target}.objdump
mcsema-disass-3.8 --disassembler /opt/ida-7.1/idat64 --os linux --arch amd64 --entrypoint main --binary gcc_m64_PIE_${target}.out --output gcc_m64_PIE_${target}.cfg --log_file gcc_m64_PIE_${target}.log --pie-mode
mcsema-lift-9.0 --os linux --arch amd64 --cfg gcc_m64_PIE_${target}.cfg --output gcc_m64_PIE_${target}.bc --log gcc_m64_PIE_${target}.lift.log
opt -O1 gcc_m64_PIE_${target}.bc -o gcc_m64_PIE_${target}.bc
llvm-dis gcc_m64_PIE_${target}.bc -o gcc_m64_PIE_${target}.ll

checksec --file=gcc_m64_PIE_${target}.out
*/

/*
GCC VERSION 7.5
*/