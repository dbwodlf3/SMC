#include <memory>
#include <string>

#include <llvm-c/Core.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/Constants.h>
#include <llvm/IR/GlobalAlias.h>
#include <llvm/Support/raw_ostream.h>

using namespace llvm;
using namespace std;

extern "C" {

struct Answer {
  // if Answer.type is 0, then it means to None.
  int type;
  int pattern;
  char *destName;
};

Answer StoreDetector(LLVMValueRef val) {
  Answer A;
  Value *value = unwrap(val);
  StoreInst *store = dyn_cast<StoreInst>(value);

  A.type = 1;

  if(store == nullptr) throw "This Instruction is not store instruction.";

  if(dyn_cast<ConstantExpr>(store) == nullptr) {
    Value *dest = store->getPointerOperand();
  
    if(dyn_cast<GlobalAlias>(dest)){
      // Pattern 1
      // store ____, @data_[0-9]*
      A.pattern = 1;
      strcpy(A.destName, ((string)dest->getName()).c_str());
      
      return A;
    } 
    else {
      // Pattern 2
      // store ____, %variable
      A.pattern = 2;
      strcpy(A.destName, ((string)dest->getName()).c_str());

      return A;
    }
  }
  else {
    BitCastInst* bitcast = dyn_cast<BitCastInst>(store->getPointerOperand());
    IntToPtrInst* inttoptr = dyn_cast<IntToPtrInst>(store->getPointerOperand());

    if(bitcast) {
      ConstantInt* dest = dyn_cast<ConstantInt>(inttoptr->getOperand(0));

      if(dest) {
        // Pattern 3
        // store ____, inttoptr (ConstantInt)
        A.pattern = 3;
        strcpy(A.destName, to_string(dest->getSExtValue()).c_str());

        return A;
      }
    }
    else if(inttoptr) {
      GlobalAlias* dest = dyn_cast<GlobalAlias>(bitcast->getOperand(0));

      if(dest) {
        // Pattern 4
        // store ____, bitcast(@data_[0-9]*)
        A.pattern = 4;
        strcpy(A.destName, ((string)dest->getName()).c_str());

        return A;
      }
    }
  }
  A.type = 0;

  return A;
}

Answer CallDetector(LLVMValueRef val) {
  Answer A;
  Value *value = unwrap(val);
  CallInst *call = dyn_cast<CallInst>(value);

  A.type = 2;

  if(call == nullptr) throw "This Instruction is not call instruction.";

  Function *called_function = call->getCalledFunction();

  if( called_function == nullptr){
    Value *function_pointer = call->getOperand(0);

    if(dyn_cast<ConstantExpr>(function_pointer) == nullptr){
      // Pattern 1
      // call void (...) %variable
      A.pattern = 1;
      strcpy(A.destName, ((string)function_pointer->getName()).c_str());

      return A;
    } 
    else{
      BitCastInst *bitcast = dyn_cast<BitCastInst>(function_pointer);

      if(bitcast){
        Value* operand = bitcast->getOperand(0);
        if(dyn_cast<GlobalValue>(operand)){
          // Pattern 2
          // call void (...) bitcast (@global_variable)
          A.pattern = 2;
          strcpy(A.destName, ((string)operand->getName()).c_str());

          return A;
        }
      }
    }
  } 
  else if(called_function->getName() == "__remill_function_call" ||
          0) {
    // Pattern 3
    // call @__remill_function_call(____, %variable, ____)
    A.pattern = 3;
    
    return A;
  }

  A.type = 0;

  return A;
}
}