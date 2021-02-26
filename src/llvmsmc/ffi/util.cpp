#include <memory>
#include <string>

#include <llvm-c/Core.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/ValueSymbolTable.h>
#include <llvm/IR/Constants.h>
#include <llvm/IRReader/IRReader.h>
#include <llvm/Support/SourceMgr.h>
#include <llvm/Support/raw_ostream.h>

using namespace llvm;
using namespace std;

//==============================================================================
// Helper

/* An iterator around a module's globals, including the stop condition */
struct AliasIterator {
    typedef llvm::Module::alias_iterator alias_iterator;
    alias_iterator cur;
    alias_iterator end;

    AliasIterator(alias_iterator cur, alias_iterator end)
        :cur(cur), end(end)
    { }
};

struct OpaqueAliasIterator;
typedef OpaqueAliasIterator* LLVMAliasIteratorRef;

static LLVMAliasIteratorRef wrap(AliasIterator *GI){
  return reinterpret_cast<LLVMAliasIteratorRef>(GI);
}

static AliasIterator* unwrap(LLVMAliasIteratorRef GI){
    return reinterpret_cast<AliasIterator*>(GI);
}

//==============================================================================
// cpp Functions

LLVMAliasIteratorRef aliasIter_cpp(LLVMModuleRef moduleRef) {
  Module *module = unwrap(moduleRef);
  
  return wrap(new AliasIterator(module->alias_begin(),
                                  module->alias_end()));
}

LLVMValueRef aliasIterNext_cpp(LLVMAliasIteratorRef AI) {
  AliasIterator *iter = unwrap(AI);
  if(iter->cur != iter->end) {
    return wrap(&*iter->cur++);
  }
  else {
    return NULL;
  }
}

const char* getName_cpp(LLVMValueRef val) {
    auto value = unwrap(val);
    return value->getName().data();
}

bool isConstant_cpp(LLVMValueRef value) {
  if(dyn_cast<Constant>(unwrap(value))) {
    return 1;
  }
  else {
    return 0;
  }
}

bool isConstantExpr_cpp(LLVMValueRef value){
  if(dyn_cast<ConstantExpr>(unwrap(value))) {
    return 1;
  }
  else {
    return 0;
  }
}

LLVMModuleRef giveName_cpp(LLVMModuleRef moduleRef) {
  Module *module = unwrap(moduleRef);

  // global variables
  string global_namespace = "global!";
  int global_name_index = 0;

  for(auto globalVar = module->global_begin(); globalVar != module->global_end();
      globalVar++) {
    string globalvar_name = globalVar->getName();

    if(globalvar_name != "") {
      globalVar->setName(global_namespace + globalvar_name);
    }
    else {
      globalVar->setName(global_namespace + to_string(global_name_index));
      global_name_index++;
    }
  }

  // alias
  string alias_namespace = "alias!";
  int alias_name_index = 0;

  for(auto alias = module->alias_begin(); alias != module->alias_end();
      alias++) {
    string alias_name = alias->getName();

    if(alias_name != "") {
      alias->setName(alias_namespace + alias_name);
    }
    else {
      alias->setName(alias_namespace + to_string(alias_name_index));
      alias_name_index++;
    }
  }

  // instructions
  for(auto function = module->begin(); function != module->end(); function++){
    string function_namespace = (string)function->getName() + "!";
    int function_name_index = 0;

    // set argument names
    for(auto arg = function->arg_begin(); arg != function->arg_end(); arg++){
      string arg_name = arg->getName();

      if(arg_name != "") {
        arg->setName(function_namespace + arg_name);
      }
      else {
        arg->setName(function_namespace + to_string(function_name_index));
        function_name_index++;
      }
    }

    // set local variable names
    for(auto bb = function->begin(); bb != function->end(); bb++) {
      string bb_name = bb->getName();

      if(bb_name == "") {
        bb->setName(to_string(function_name_index));
        function_name_index++;
      }

      for(auto instruction = bb->begin(); instruction != bb->end();
          instruction++){
        if(instruction->getType()->isVoidTy())continue;
        
        string var_name = instruction->getName();
        
        if(var_name != "") {
          instruction->setName(function_namespace + var_name);
        }
        else {
          instruction->setName(function_namespace +
                                                to_string(function_name_index));
          function_name_index++;
        }
      }
    }

    // ConstantExpr names
    for(auto bb = function->begin(); bb != function->end(); bb++) {
      string function_namespace = (string)function->getName() + "!";
      string constant_exp_namespace = "ConstantExpr!";
      int constant_exp_index = 0;

      for(auto ins = bb->begin(); ins != bb->end(); ins++) {
        for(auto user = ins->op_begin(); user != ins->op_end(); user++){
          auto exp = dyn_cast<ConstantExpr>(user->get());
          if(exp) {
            if(!exp->hasName()){
              exp->setName(function_namespace + constant_exp_namespace +
                            to_string(constant_exp_index));
              constant_exp_index++;
            }
          }
        }
      }
    }
  }

  return wrap(module);
}

void dumpModule_cpp(LLVMModuleRef moduleRef) {
  Module *module = unwrap(moduleRef);

  outs() << (string) module->begin()->getName();

  module->dump();
}

void dumpNameValues_cpp(LLVMModuleRef moduleRef) {
  Module *module = unwrap(moduleRef);

  for(auto fun = module->begin(); fun != module->end(); fun++){
    auto sym_table = fun->getValueSymbolTable();
    
    outs() << "function: "<< fun->getName() << "\n";
    for(auto sym = sym_table->begin(); sym != sym_table->end(); sym++){
      outs() << sym->getKey() << " => " << sym->getValue() << "\n";
    }

  }

  for(auto fun = module->begin(); fun != module->end(); fun++) {
    for(auto bb = fun->begin(); bb != fun->end(); bb++) {
      for(auto ins = bb->begin(); ins != bb->end(); ins++) {
        for(auto op = ins->op_begin(); op != ins->op_end(); op++) {
          auto exp = dyn_cast<ConstantExpr>(op->get());
          if(exp){
            op->get()->print(outs());
            outs() << (op->get()->getName() == "") ;
            outs() << "\n 이름: " << op->get()->getName() << "\n";
            outs() << "타입: " << op->get()->getValueName() << "\n";
          }
        }
      }
    }
  }


}

void testPrint_cpp(){
  outs() << "print test";
}

//==============================================================================
// Extern C
extern "C" {

  //==============================================================================
  // Helper Structure

  // This structure for return constant integer.
  struct IntFail {
    int value;
    bool fail;
  };

  // give name every ir.
  // it is used for analysis
  LLVMModuleRef giveName(LLVMModuleRef moduleRef) {
    return giveName_cpp(moduleRef);
  }

  // return wrapped alias iterator reference from module. 
  LLVMAliasIteratorRef aliasIter(LLVMModuleRef moduleRef) {
    return aliasIter_cpp(moduleRef);
  }

  // return wrapped alias iterator next reference from wrapped iterator
  // reference.
  LLVMValueRef aliasIterNext(LLVMAliasIteratorRef AI){
    return aliasIterNext_cpp(AI);
  }

  // return integer and boolean value from valueRef.
  // if valueRef is ConstantInt then boolean value is true.
  IntFail getConstantInt(LLVMValueRef valueRef) {
    IntFail result;
    Value* value = unwrap(valueRef);
    ConstantInt* constant_int = dyn_cast<ConstantInt>(value);
    
    if(constant_int){
      result.value = (int)constant_int->getSExtValue();
      result.fail = false;
      
      return result;
    }
    else {
      result.fail = true;
      return result;
    }

  }

  // Get IR name from valueRef
  const char* getName(LLVMValueRef val) { 
    return getName_cpp(val);
  }

  // dump module into stdout.
  void dumpModule(LLVMModuleRef moduleRef){
    return dumpModule_cpp(moduleRef);
  }

  void testPrint(){
    return testPrint_cpp();
  }

  // dump every named ir into stdout.
  void dumpNameValues(LLVMModuleRef moduleRef){
    return dumpNameValues_cpp(moduleRef);
  }

  // if valueRef is Constant then return true. 
  bool isConstant(LLVMValueRef value) {
    return isConstant_cpp(value);
  }

  // if valueRef is ConstantExpression then return true.
  bool isConstantExpr(LLVMValueRef value){
    return isConstantExpr_cpp(value);
  }

  // if valueRef is Alias then return true.
  bool isAlias(LLVMValueRef value){
    if(dyn_cast<GlobalAlias>(unwrap(value))){
      return 1;
    }
    else {
      return 0;
    }
  }

} // Extern C