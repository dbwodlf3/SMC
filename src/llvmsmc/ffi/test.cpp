#include <memory>
#include <string>

#include <llvm-c/Core.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/Constants.h>
#include <llvm/IR/GlobalAlias.h>
#include <llvm/Support/raw_ostream.h>

using namespace llvm;
using namespace std;

void testFunction_cpp(LLVMModuleRef moduleRef) {
  Module *module = unwrap(moduleRef);

  for(auto fun = module->begin(); fun != module->end(); fun++) {
    if(fun->getName() != "main") continue;

    for(auto bb = fun->begin(); bb != fun->end(); bb++) {
      for(auto ins = bb->begin(); ins != bb->end(); ins++) {
        CallInst* call = dyn_cast<CallInst>(ins);

        if(call) {
          Function* called_function = call->getCalledFunction();
          
          if(called_function){
          }
          else {
            call->print(outs());
            outs() <<'\n';
            outs() << call->getOperand(0)->getName();
          }
        }
      }
    }
  }
}

extern "C" {
  void testFunction(LLVMModuleRef moduleRef) {
    return testFunction_cpp(moduleRef);
  }
}