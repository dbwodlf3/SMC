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

int getStackOffset(LLVMValueRef val) {
  Value *value = unwrap(val);
  
  IntToPtrInst *stack_addr_ptr = dyn_cast<IntToPtrInst>(value);
  if(!stack_addr_ptr) return 0;
  Instruction *stack_addr = dyn_cast<Instruction>(stack_addr_ptr->getOperand(0));
  if(!stack_addr) return 0;
  LoadInst *rbp_addr = dyn_cast<LoadInst>(stack_addr->getOperand(0));
  if(!rbp_addr) return 0;
  ConstantInt *offset = dyn_cast<ConstantInt>(stack_addr->getOperand(1));

  if(isRSP(rbp_addr->getPointerOperand()->getName())) {
    if(!offset) return 0;
    return offset->getSExtValue()+8;
  }
  else if(isRBP(rbp_addr->getPointerOperand()->getName())) {
    if(!offset) return 0;
    return offset->getSExtValue();
  }
}

int getStackStoreOffset(LLVMValueRef val) {
  Value *value = unwrap(val);
  
  IntToPtrInst *stack_addr_ptr = dyn_cast<IntToPtrInst>(value);
  if(!stack_addr_ptr) return 0;
  Instruction *stack_addr = dyn_cast<Instruction>(stack_addr_ptr->getOperand(0));
  if(!stack_addr) return 0;
  LoadInst *rbp_addr = dyn_cast<LoadInst>(stack_addr->getOperand(0));
  if(!rbp_addr) return 0;
  ConstantInt *offset = dyn_cast<ConstantInt>(stack_addr->getOperand(1));

  if(isRSP(rbp_addr->getPointerOperand()->getName())) {
    if(!offset) return 0;
    return offset->getSExtValue()+8;
  }
  else if(isRBP(rbp_addr->getPointerOperand()->getName())) {
    if(!offset) return 0;
    return offset->getSExtValue();
  }
}

} // CLOSE extern "C"