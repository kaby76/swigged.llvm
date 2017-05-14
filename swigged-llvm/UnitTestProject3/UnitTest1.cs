using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Swigged.LLVM;
using System.Runtime.InteropServices;


namespace UnitTestProject3
{
    [TestClass]
    public class UnitTest1
    {
        [TestMethod]
        public void TestMethod1()
        {
            // Based on http://npcontemplation.blogspot.com/2008/06/secret-of-llvm-c-bindings.html
            ModuleRef mod = LLVM.ModuleCreateWithName("fac_module");
            TypeRef[] fac_args = { LLVM.Int32Type() };
            ValueRef fac = LLVM.AddFunction(mod, "fac", LLVM.FunctionType(LLVM.Int32Type(), fac_args, false));
            LLVM.SetFunctionCallConv(fac, (uint)Swigged.LLVM.CallConv.CCallConv);
            ValueRef n = LLVM.GetParam(fac, 0);

            BasicBlockRef entry = LLVM.AppendBasicBlock(fac, "entry");
            BasicBlockRef iftrue = LLVM.AppendBasicBlock(fac, "iftrue");
            BasicBlockRef iffalse = LLVM.AppendBasicBlock(fac, "iffalse");
            BasicBlockRef end = LLVM.AppendBasicBlock(fac, "end");
            BuilderRef builder = LLVM.CreateBuilder();

            LLVM.PositionBuilderAtEnd(builder, entry);
            ValueRef If = LLVM.BuildICmp(builder, Swigged.LLVM.IntPredicate.IntEQ, n, LLVM.ConstInt(LLVM.Int32Type(), 0, false), "n == 0");
            LLVM.BuildCondBr(builder, If, iftrue, iffalse);

            LLVM.PositionBuilderAtEnd(builder, iftrue);
            ValueRef res_iftrue = LLVM.ConstInt(LLVM.Int32Type(), 1, false);
            LLVM.BuildBr(builder, end);

            LLVM.PositionBuilderAtEnd(builder, iffalse);
            ValueRef n_minus = LLVM.BuildSub(builder, n, LLVM.ConstInt(LLVM.Int32Type(), 1, false), "n - 1");
            ValueRef[] call_fac_args = { n_minus };
            ValueRef call_fac = LLVM.BuildCall(builder, fac, call_fac_args, "fac(n - 1)");
            ValueRef res_iffalse = LLVM.BuildMul(builder, n, call_fac, "n * fac(n - 1)");
            LLVM.BuildBr(builder, end);

            LLVM.PositionBuilderAtEnd(builder, end);
            ValueRef res = LLVM.BuildPhi(builder, LLVM.Int32Type(), "result");
            ValueRef[] phi_vals = { res_iftrue, res_iffalse };
            BasicBlockRef[] phi_blocks = { iftrue, iffalse };
            LLVM.AddIncoming(res, phi_vals, phi_blocks);
            LLVM.BuildRet(builder, res);

            //LLVM.VerifyModule(mod, AbortProcessAction, &error);
            //LLVM.DisposeMessage(error); // Handler == LLVMAbortProcessAction -> No need to check errors

            string error;
            ExecutionEngineRef engine;
            ModuleProviderRef provider = LLVM.CreateModuleProviderForExistingModule(mod);
            LLVM.CreateJITCompilerForModule(out engine, mod, 0, out error);

            PassManagerRef pass = LLVM.CreatePassManager();
           // LLVM.AddTargetData(LLVM.GetExecutionEngineTargetData(engine), pass);
            LLVM.AddConstantPropagationPass(pass);
            LLVM.AddInstructionCombiningPass(pass);
            LLVM.AddPromoteMemoryToRegisterPass(pass);
            // LLVMAddDemoteMemoryToRegisterPass(pass); // Demotes every possible value to memory
            LLVM.AddGVNPass(pass);
            LLVM.AddCFGSimplificationPass(pass);
            LLVM.RunPassManager(pass, mod);
            LLVM.DumpModule(mod);

            GenericValueRef exec_args = LLVM.CreateGenericValueOfInt(LLVM.Int32Type(), 10, false);
            GenericValueRef exec_res = LLVM.RunFunction(engine, fac, 1, out exec_args);
            LLVM.GenericValueToInt(exec_res, false);

            LLVM.DisposePassManager(pass);
            LLVM.DisposeBuilder(builder);
            LLVM.DisposeExecutionEngine(engine);
        }
    }
}
