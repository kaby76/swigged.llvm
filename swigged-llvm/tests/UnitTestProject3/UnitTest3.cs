using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Swigged.LLVM;
using System.Runtime.InteropServices;


namespace UnitTestProject3
{
    [TestClass]
    public class UnitTest3
    {
        public static ulong Factorial(ulong i)
        {
            ulong result = 1;
            if (i == 0) return 1;
            if (i == 1) return 1;
            return Factorial(i - 1) * i;
        }

        /// <summary>
        /// Test of LLVM with a factorial example.
        /// Based on http://npcontemplation.blogspot.com/2008/06/secret-of-llvm-c-bindings.html
        /// </summary>
        [TestMethod]
        public void TestFact()
        {
            ModuleRef Module = LLVM.ModuleCreateWithName("fac_module");
            TypeRef[] fac_args = { LLVM.Int32Type() };
            ValueRef fac = LLVM.AddFunction(Module, "fac", LLVM.FunctionType(LLVM.Int32Type(), fac_args, false));
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

            MyString error = new MyString();
            LLVM.VerifyModule(Module, VerifierFailureAction.PrintMessageAction, error);
            if (error.ToString() != "") throw new Exception("Failed");

            ExecutionEngineRef engine;
            ModuleProviderRef provider = LLVM.CreateModuleProviderForExistingModule(Module);
            LLVM.CreateJITCompilerForModule(out engine, Module, 0, error);

            PassManagerRef pass = LLVM.CreatePassManager();
           // LLVM.AddTargetData(LLVM.GetExecutionEngineTargetData(engine), pass);
            LLVM.AddConstantPropagationPass(pass);
            LLVM.AddInstructionCombiningPass(pass);
            LLVM.AddPromoteMemoryToRegisterPass(pass);
            // LLVMAddDemoteMemoryToRegisterPass(pass); // Demotes every possible value to memory
            LLVM.AddGVNPass(pass);
            LLVM.AddCFGSimplificationPass(pass);
            LLVM.RunPassManager(pass, Module);
            LLVM.DumpModule(Module);

            ulong input = 10;
            for (ulong i = 0; i < input; ++i)
            {
                GenericValueRef exec_args = LLVM.CreateGenericValueOfInt(LLVM.Int32Type(), input, false);
                GenericValueRef exec_res = LLVM.RunFunction(engine, fac, 1, out exec_args);
                var result_of_function = LLVM.GenericValueToInt(exec_res, false);
                var result_of_csharp_function = Factorial(input);
                if (result_of_csharp_function != result_of_function) throw new Exception("Results not the same.");
            }

            LLVM.DisposePassManager(pass);
            LLVM.DisposeBuilder(builder);
            LLVM.DisposeExecutionEngine(engine);
        }
    }
}
