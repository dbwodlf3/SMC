#include <memory>
#include <string>

#include <llvm/IR/Instructions.h>
#include <llvm/IR/Constants.h>
#include <llvm/IR/GlobalAlias.h>
#include <llvm/Support/raw_ostream.h>
#include "llvm/ADT/StringRef.h"

#include <llvm-c/Core.h>

using namespace llvm;
using namespace std;

//==============================================================================
// Helper Functions

bool isRBP(StringRef const valueName) { 
  if(valueName.size() > 9) {
    if(strncmp(valueName.data(), "alias!RBP", 9) == 0)
      return true;
  }

  return false;
}

bool isRSP(StringRef const valueName) { 
  if(valueName.size() > 9) {
    if(strncmp(valueName.data(), "alias!RSP", 9) == 0)
      return true;
  }

  return false;
}

//==============================================================================
extern "C" {

struct Stack {
  // if Answer.type is 0, then it means to None.
  int offset;
  char ** tokens;
};
// load <- add
int getStackOffsetHelper(LLVMValueRef val) {
  Value *value = unwrap(val);
  LoadInst *rbp_addr;
  ConstantInt *offset;

  Instruction *stack_addr = dyn_cast<Instruction>(value);
  if(!stack_addr) return 0;

  rbp_addr = dyn_cast<LoadInst>(stack_addr->getOperand(0));
  offset = dyn_cast<ConstantInt>(stack_addr->getOperand(1));

  if(!rbp_addr) { 
    rbp_addr = dyn_cast<LoadInst>(stack_addr->getOperand(1));
    offset = dyn_cast<ConstantInt>(stack_addr->getOperand(1));
  }

  if(!rbp_addr) return 0;

  if(isRSP(rbp_addr->getPointerOperand()->getName())) {
    if(!offset) return 0;
    return offset->getSExtValue()+8;
  }
  else if(isRBP(rbp_addr->getPointerOperand()->getName())) {
    if(!offset) return 0;
    return offset->getSExtValue();
  }
}

// (load <- add) <- inttoptr
int getStackOffset(LLVMValueRef val) {
  Value *value = unwrap(val);
  
  // inttoptr instruction
  IntToPtrInst *stack_addr_ptr = dyn_cast<IntToPtrInst>(value);
  if(!stack_addr_ptr) return 0;
  // add instruction
  Instruction *stack_addr = dyn_cast<Instruction>(stack_addr_ptr->getOperand(0));
  if(!stack_addr) return 0;

  if ( stack_addr->getNumOperands() >= 2 ) {
    return getStackOffsetHelper(wrap(stack_addr));
  }
  else 
    return 0;
}

// (load <- add <- inttoptr) <- load <- store
int getStackOffset2(LLVMValueRef val) {
  Value *value = unwrap(val);
  LoadInst *load_inst = dyn_cast<LoadInst>(value);
  if(!load_inst) return 0;
  IntToPtrInst *inttoptr_inst = dyn_cast<IntToPtrInst>(load_inst->getPointerOperand());
  if(!inttoptr_inst) return 0;

  return getStackOffset(wrap(inttoptr_inst));
}

// load(pointer(inttoptr)) <- add <- inttoptr <- store
int getStackOffset3(LLVMValueRef val) {
  Value *value = unwrap(val);
  IntToPtrInst *stack_addr_ptr = dyn_cast<IntToPtrInst>(value);
  Instruction *stack_addr;
  LoadInst *rbp_addr;

  // inttoptr instruction
  if(!stack_addr_ptr) return 0;
  // add instruction
  stack_addr = dyn_cast<Instruction>(stack_addr_ptr->getOperand(0));
  
  if ( !(stack_addr->getNumOperands() >= 2) ) 
    return 0;

  rbp_addr = dyn_cast<LoadInst>(stack_addr->getOperand(0));
  if(rbp_addr){
    if(getStackOffset(wrap(rbp_addr->getOperand(0)))){
      return getStackOffset(wrap(rbp_addr->getOperand(0)));
    }
  }

  rbp_addr = dyn_cast<LoadInst>(stack_addr->getOperand(1));
  if(rbp_addr){
    if(getStackOffset(wrap(rbp_addr->getOperand(0)))){
      return getStackOffset(wrap(rbp_addr->getOperand(0)));
    }
  }

  return 0;
}

} // CLOSE extern "C"