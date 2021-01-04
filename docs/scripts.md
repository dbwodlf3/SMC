```console
binary_target="cat"
mcsema-disass-3.8 --disassembler /opt/ida-7.1/idat64 --os linux --arch amd64 --entrypoint main --binary ${binary_target} --output ${binary_target}.cfg --log_file gcc_m64_NO_PIE_${binary_target}.log
mcsema-lift-9.0 --os linux --arch amd64 --cfg ${binary_target}.cfg --output ${binary_target}.bc --log ${binary_target}.lift.log
llvm-dis ${binary_target}.bc -o ${binary_target}.ll
```

```console
binary_target="cat"
mcsema-disass-3.8 --disassembler /opt/ida-7.1/idat64 --os linux --arch x86 --entrypoint main --binary ${binary_target} --output ${binary_target}.cfg --log_file gcc_m64_NO_PIE_${binary_target}.log
mcsema-lift-9.0 --os linux --arch x86 --cfg ${binary_target}.cfg --output ${binary_target}.bc --log ${binary_target}.lift.log
llvm-dis ${binary_target}.bc -o ${binary_target}.ll
```