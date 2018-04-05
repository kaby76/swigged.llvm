using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Swigged.LLVM;

namespace UnitTestProject1
{
    [TestClass]
    public class UnitTest1
    {

        /// <summary>
        /// A simple test of Swigged.llvm, which tests the creation of module, basic block,
        /// a function, a return instruction. No test of the JIT.
        /// </summary>
        [TestMethod]
        public void Test42()
        {
            LLVM.EnablePrettyStackTrace();
            var Module = LLVM.ModuleCreateWithName("the_meaning_of_life");
            var triple = LLVM.GetDefaultTargetTriple();
            LLVM.SetTarget(Module, triple);
            var Function = LLVM.AddFunction(Module, "the_meaning_of_life",
                LLVM.FunctionType(LLVM.Int32Type(), new TypeRef[0], false));
            LLVM.SetFunctionCallConv(Function, (uint)Swigged.LLVM.CallConv.CCallConv);
            var entry = LLVM.AppendBasicBlock(Function, "entry");
            var builder = LLVM.CreateBuilder();
            LLVM.PositionBuilderAtEnd(builder, entry);
            LLVM.BuildRet(builder, LLVM.ConstInt(LLVM.Int32Type(), 42, false));
            string msg = new string(new char[1000]);
            MyString error = new MyString();
            LLVM.VerifyModule(Module, VerifierFailureAction.PrintMessageAction, error);
            if (error.ToString() != "") throw new Exception("Failed");
            LLVM.DisposeBuilder(builder);
        }
    }
}
