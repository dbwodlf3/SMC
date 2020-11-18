# ARCHITECTURE

BINARY_FILE ⟶ "Lifter" ⇒ LLVM IR(Lifted)

LLVM IR(Lifted) ⟶ "ConstraintGenrator" ⇒ Constraints(JSON)

Constraints(JSON) ⟶ "CubicSolver" ⇒ Variable Map(JSON)

LLVM IR(Lifted) AND Variable Map ⟶ "Detector" ⇒ ANSWER(JSON)

## Dependency

- ### LLVM 10.0.x
- ### llvmlite 0.34.0
- ### bitarray

## Lifter
- ### Mcsema

- ### Anvill

- ### Remill

## ConstraintGenerator

- ### Baisic Constraints

- ### Custom Constraints

## CubicSolver

## Detector

- ### Custom Detecting

## Bench Marks


# References

- ### [LLVM Language Reference](https://llvm.org/docs/LangRef.html)
- ### [LLVM IR Doxygen](https://llvm.org/doxygen/) This is latest version. you need to check there are also existing in llvm 10.0.x
- ### [llvmlite User guide](https://llvmlite.readthedocs.io/en/latest/user-guide/index.html)
