using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using CSLLVM;

namespace UnitTestProject1
{
    [TestClass]
    public class UnitTest1
    {

        void buildSimpleFunction()
        {
            var Module = LLVM.ModuleCreateWithName("simple_module");
            var triple = LLVM.GetDefaultTargetTriple();
            LLVM.SetTarget(Module, triple);

            var Function = LLVM.AddFunction(Module, "simple_function",
                LLVM.FunctionType(LLVM.Int32Type(), new TypeRef[0], false));
            LLVM.SetFunctionCallConv(Function, (uint)CSLLVM.CallConv.CCallConv);
            var entry = LLVM.AppendBasicBlock(Function, "entry");
            var builder = LLVM.CreateBuilder();
            LLVM.PositionBuilderAtEnd(builder, entry);
            LLVM.BuildRet(builder, LLVM.ConstInt(LLVM.Int32Type(), 42, false));
            string msg = new string(new char[1000]);
            LLVM.VerifyModule(Module, VerifierFailureAction.PrintMessageAction, out msg);

            LLVM.DisposeBuilder(builder);
        }

        CSLLVM.ModuleRef llvm_load_module(bool Lazy, bool New)
        {
            CSLLVM.MemoryBufferRef MB;
            CSLLVM.ModuleRef M;
            string msg = null;
            if (LLVM.CreateMemoryBufferWithSTDIN(out MB, out msg))
            {
                System.Console.WriteLine("Error reading file: " + msg);
                return default(ModuleRef);
            }
            bool Ret;
            if (New)
            {
                ContextRef c = CSLLVM.LLVM.GetGlobalContext();
                // LLVMContextSetDiagnosticHandler(C, diagnosticHandler, NULL);
                if (Lazy)
                    Ret = CSLLVM.LLVM.GetBitcodeModule2(MB, out M);
                else
                    Ret = CSLLVM.LLVM.ParseBitcode2(MB, out M);
            }
            else
            {
                if (Lazy)
                    Ret = CSLLVM.LLVM.GetBitcodeModule(MB, out M, out msg);
                else
                    Ret = CSLLVM.LLVM.ParseBitcode(MB, out M, out msg);
            }
            if (Ret)
            {
                System.Console.WriteLine("Error parsing bitcode: " + msg);
                return default(CSLLVM.ModuleRef);
            }
            if (!Lazy)
                CSLLVM.LLVM.DisposeMemoryBuffer(MB);
            return M;
        }

        [TestMethod]
        public void TestMethod1()
        {
            CSLLVM.LLVM.EnablePrettyStackTrace();
            buildSimpleFunction();
        }
    }
}
