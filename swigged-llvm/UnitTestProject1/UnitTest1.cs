using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Swigged.LLVM;

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
            LLVM.SetFunctionCallConv(Function, (uint)Swigged.LLVM.CallConv.CCallConv);
            var entry = LLVM.AppendBasicBlock(Function, "entry");
            var builder = LLVM.CreateBuilder();
            LLVM.PositionBuilderAtEnd(builder, entry);
            LLVM.BuildRet(builder, LLVM.ConstInt(LLVM.Int32Type(), 42, false));
            string msg = new string(new char[1000]);
            //LLVM.VerifyModule(Module, VerifierFailureAction.PrintMessageAction, out msg);

            LLVM.DisposeBuilder(builder);
        }

        Swigged.LLVM.ModuleRef llvm_load_module(bool Lazy, bool New)
        {
            Swigged.LLVM.MemoryBufferRef MB;
            Swigged.LLVM.ModuleRef M;
            MyString msg = new MyString();
            if (LLVM.CreateMemoryBufferWithSTDIN(out MB, msg))
            {
                System.Console.WriteLine("Error reading file: " + msg);
                return default(ModuleRef);
            }
            bool Ret;
            if (New)
            {
                ContextRef c = Swigged.LLVM.LLVM.GetGlobalContext();
                // LLVMContextSetDiagnosticHandler(C, diagnosticHandler, NULL);
                if (Lazy)
                    Ret = Swigged.LLVM.LLVM.GetBitcodeModule2(MB, out M);
                else
                    Ret = Swigged.LLVM.LLVM.ParseBitcode2(MB, out M);
            }
            else
            {
                if (Lazy)
                    Ret = Swigged.LLVM.LLVM.GetBitcodeModule(MB, out M, msg);
                else
                    Ret = Swigged.LLVM.LLVM.ParseBitcode(MB, out M, msg);
            }
            if (Ret)
            {
                System.Console.WriteLine("Error parsing bitcode: " + msg);
                return default(Swigged.LLVM.ModuleRef);
            }
            if (!Lazy)
                Swigged.LLVM.LLVM.DisposeMemoryBuffer(MB);
            return M;
        }

        [TestMethod]
        public void Test1()
        {
            Swigged.LLVM.LLVM.EnablePrettyStackTrace();
            buildSimpleFunction();
        }
    }
}
