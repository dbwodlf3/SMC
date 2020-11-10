# ARCHITECTURE

BINARY_FILE ⟶ "Lifter" ⇒ LLVM IR(Lifted)

LLVM IR(Lifted) ⟶ "ConstraintGenrator" ⇒ Constraints(JSON)

Constraints(JSON) ⟶ "CubicSolver" ⇒ Variable Map(JSON)

LLVM IR(Lifted) AND Variable Map ⟶ "Detector" ⇒ ANSWER(JSON)

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