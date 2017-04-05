using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Swigged.LLVM;
using System.Runtime.InteropServices;

namespace UnitTestProject2
{
    // See http://releases.llvm.org/2.6/docs/tutorial/JITTutorial2.html

    [TestClass]
    public class UnitTest1
    {
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int Ack(int a, int b);

        int CsAck(int x, int y)
        {
            if (x == y)
            {
                return x;
            }
            else if (x < y)
            {
                return CsAck(x, y - x);
            }
            else
            {
                return CsAck(x - y, y);
            }
        }

        [TestMethod]
        public void TestMethod1()
        {

            Swigged.LLVM.ContextRef g = Swigged.LLVM.LLVM.GetGlobalContext();
            var Module = LLVM.ModuleCreateWithName("tut2");
            var triple = LLVM.GetDefaultTargetTriple();
            LLVM.SetTarget(Module, triple);

            var arg_types = new TypeRef[2] { LLVM.Int32Type(), LLVM.Int32Type() };
            var gcd = LLVM.AddFunction(Module, "gcd",
                LLVM.FunctionType(LLVM.Int32Type(),
                arg_types,
                false));
            LLVM.SetFunctionCallConv(gcd, (uint)Swigged.LLVM.CallConv.CCallConv);

            var x = LLVM.GetParam(gcd, 0);
            var y = LLVM.GetParam(gcd, 1);

            var entry = LLVM.AppendBasicBlock(gcd, "entry");
            var ret = LLVM.AppendBasicBlock(gcd, "return");
            var cond_false = LLVM.AppendBasicBlock(gcd, "cond_false");
            var cond_true = LLVM.AppendBasicBlock(gcd, "cond_true");
            var cond_false_2 = LLVM.AppendBasicBlock(gcd, "cond_false");

            BuilderRef builder = LLVM.CreateBuilder();

            LLVM.PositionBuilderAtEnd(builder, entry);
            var xEqualsY = LLVM.BuildICmp(builder, IntPredicate.IntEQ, x, y, "tmp");
            var br = LLVM.BuildCondBr(builder, xEqualsY, ret, cond_false);

            LLVM.PositionBuilderAtEnd(builder, ret);
            LLVM.BuildRet(builder, x);

            LLVM.PositionBuilderAtEnd(builder, cond_false);
            var xLessThanY = LLVM.BuildICmp(builder, IntPredicate.IntULT, x, y, "tmp");
            LLVM.BuildCondBr(builder, xLessThanY, cond_true, cond_false_2);

            LLVM.PositionBuilderAtEnd(builder, cond_true);
            var yMinusX = LLVM.BuildSub(builder, y, x, "tmp");
            ValueRef[] args1 = new ValueRef[2] { x, yMinusX };
            var recur_1 = LLVM.BuildCall(builder, gcd, args1, "tmp");
            LLVM.BuildRet(builder, recur_1);

            LLVM.PositionBuilderAtEnd(builder, cond_false_2);
            var xMinusY = LLVM.BuildSub(builder, x, y, "tmp");
            ValueRef[] args2 = new ValueRef[2] { xMinusY, y };
            var recur_2 = LLVM.BuildCall(builder, gcd, args2, "tmp");
            LLVM.BuildRet(builder, recur_2);

            string error;
            LLVM.VerifyModule(Module, VerifierFailureAction.AbortProcessAction, out error);
            //LLVM.DisposeMessage(error);
            ExecutionEngineRef engine;
            LLVM.LinkInMCJIT();
            LLVM.InitializeNativeTarget();
            LLVM.InitializeNativeAsmPrinter();
            MCJITCompilerOptions options;
            var optionsSize = (4 * sizeof(int)) + IntPtr.Size; // LLVMMCJITCompilerOptions has 4 ints and a pointer
            LLVM.InitializeMCJITCompilerOptions(out options, (uint)optionsSize);
            LLVM.CreateMCJITCompilerForModule(out engine, Module, out options, (uint)optionsSize, out error);
            var ptr = LLVM.GetPointerToGlobal(engine, gcd);
            IntPtr p = (IntPtr)ptr;
            Ack ackMethod = (Ack)Marshal.GetDelegateForFunctionPointer(p, typeof(Ack));

            for (int i = 1; i < 10; ++i)
                for (int j = 1; j < 10; ++j)
                {
                    int result = ackMethod(i, j);
                    int result2 = CsAck(i, j);
                    if (result != result2)
                    {
                        int xx = 0;
                        int yy = 1 / xx;
                    }
                }

            var pm = Swigged.LLVM.LLVM.CreatePassManager();
            var str = LLVM.PrintModuleToString(Module);
            LLVM.DumpModule(Module);
            LLVM.DisposeBuilder(builder);
            LLVM.DisposeExecutionEngine(engine);
        }
    }
}
