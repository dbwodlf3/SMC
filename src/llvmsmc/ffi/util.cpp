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

struct Answer {
  int type;
  int pattern;
  char* destName;
};

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

LLVMValueRef getAlias_cpp(LLVMModuleRef moduleRef) {
  Module *module = unwrap(moduleRef);

  
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

extern "C" {
  LLVMModuleRef giveName(LLVMModuleRef moduleRef) {
    return giveName_cpp(moduleRef);
  }

  void dumpModule(LLVMModuleRef moduleRef){
    return dumpModule_cpp(moduleRef);
  }

  void testPrint(){
    return testPrint_cpp();
  }

  void dumpNameValues(LLVMModuleRef moduleRef){
    return dumpNameValues_cpp(moduleRef);
  }

  bool isConstant(LLVMValueRef value) {
    return isConstant_cpp(value);
  }

  bool isConstantExpr(LLVMValueRef value){
    return isConstantExpr_cpp(value);
  }

  bool isAlias(LLVMValueRef value){
    if(dyn_cast<GlobalAlias>(unwrap(value))){
      return 1;
    }
    else {
      return 0;
    }
  }

} // Extern C