#include <memory>

#include <llvm-c/Core.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IRReader/IRReader.h>
#include <llvm/Support/SourceMgr.h>
#include <llvm/Support/raw_ostream.h>

using namespace llvm;
using namespace std;

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
    for(auto bb = function->begin(); bb != function->end(); bb++){
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
  }

  return wrap(module);
}

LLVMModuleRef readFromLL_cpp(string filename) {
  LLVMContext context;
  SMDiagnostic error;
  std::unique_ptr<llvm::Module> module = 
                                  llvm::parseIRFile(filename, error, context);

  if(!module) {
    outs() << "Can't read file!\n";
    throw "Can't read file!\n";
  }
  
  return wrap(module.get());
}

extern "C" {
  LLVMModuleRef giveName(LLVMModuleRef moduleRef) {
    return giveName_cpp(moduleRef);
  }

  LLVMModuleRef readFromLL(string filename){
    return readFromLL_cpp(filename);
  }
}