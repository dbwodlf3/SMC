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
  const char *destName;
};

Answer StoreDetector(LLVMValueRef val) {
  Answer A;
  Value *value = unwrap(val);
  StoreInst *store = dyn_cast<StoreInst>(value);
  A.type = 1;

  if(store == nullptr) throw "This Instruction is not store instruction.";

  Value *dest = store->getPointerOperand();
  ConstantExpr *dest_expr = dyn_cast<ConstantExpr>(dest);

  if(dest_expr == nullptr) {
    Value *dest = store->getPointerOperand();
    if(dyn_cast<GlobalAlias>(dest)){
      // Pattern 1
      // store ____, @data_[0-9]*
      A.pattern = 1;
      A.destName = dest->getName().data();
      
      return A;
    } 
    else {
      // Pattern 2
      // store ____, %variable
      A.pattern = 2;
      A.destName = dest->getName().data();

      return A;
    }
  }
  else {
    if(dest_expr->getOpcode() == Instruction::IntToPtr) {
      ConstantInt* dest = dyn_cast<ConstantInt>(dest_expr->getOperand(0));

      if(dest) {
        // Pattern 3
        // store ____, inttoptr (ConstantInt)
        A.pattern = 3;
        A.destName = to_string(dest->getSExtValue()).c_str();

        return A;
      }
    }
    else if(dest_expr->getOpcode() == Instruction::BitCast) {
      GlobalAlias* dest = dyn_cast<GlobalAlias>(dest_expr->getOperand(0));

      if(dest) {
        // Pattern 4
        // store ____, bitcast(@data_[0-9]*)
        A.pattern = 4;
        A.destName = A.destName = dest->getName().data();

        return A;
      }
    }
  }
  A.type = 0;
  A.pattern = 0;

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
    ConstantExpr* constant_expr = dyn_cast<ConstantExpr>(function_pointer);

    if(constant_expr == nullptr) {
      // Pattern 1
      // call void (...) %variable
      // this case also include void ()* asm sideeffect... be careful.
      A.pattern = 1;
      A.destName = function_pointer->getName().data();

      return A;
    } 
    else{
      
      if(constant_expr->getOpcode() == Instruction::BitCast) {
        Value* operand = constant_expr->getOperand(0);
        if(dyn_cast<GlobalValue>(operand)){
          // Pattern 2
          // call void (...) bitcast (@global_variable)
          A.pattern = 2;
          A.destName = operand->getName().data();

          return A;
        }
      }
    }
  } 
  else if(called_function->getName().compare("__remill_function_call") == 0 ||
          0) {
    // Pattern 3
    // call @__remill_function_call(____, %variable, ____)
    if ( call->arg_size() > 1) {
      Value* dest = call->getOperand(1);

      A.pattern = 3;
      A.destName = dest->getName().data();

      return A;
    };
  }

  A.type = 0;
  A.pattern = 0;

  return A;
}
}