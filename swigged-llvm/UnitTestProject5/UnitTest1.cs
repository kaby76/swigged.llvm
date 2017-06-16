using System;
using System.Runtime.InteropServices;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Swigged.LLVM;

namespace UnitTestProject5
{
    [TestClass]
    public class UnitTest1
    {
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int Add(int a, int b);

        [TestMethod]
        public void TestORC()
        {
            Swigged.LLVM.Helper.Adjust.Path();

            LLVM.InitializeAllTargets();
            LLVM.InitializeAllTargetMCs();
            LLVM.InitializeAllTargetInfos();
            LLVM.InitializeAllAsmPrinters();

            // See http://www.doof.me.uk/2017/05/11/using-orc-with-llvms-c-api/
            ModuleRef mod = LLVM.ModuleCreateWithName("LLVMSharpIntro");
            TypeRef[] param_types = { LLVM.Int32Type(), LLVM.Int32Type() };
            TypeRef ret_type = LLVM.FunctionType(LLVM.Int32Type(), param_types, false);
            ValueRef sum = LLVM.AddFunction(mod, "sum", ret_type);
            BasicBlockRef entry = LLVM.AppendBasicBlock(sum, "entry");
            BuilderRef builder = LLVM.CreateBuilder();
            LLVM.PositionBuilderAtEnd(builder, entry);
            ValueRef tmp = LLVM.BuildAdd(builder, LLVM.GetParam(sum, 0), LLVM.GetParam(sum, 1), "tmp");
            LLVM.BuildRet(builder, tmp);
            MyString the_error = new MyString();
            LLVM.VerifyModule(mod, VerifierFailureAction.AbortProcessAction, the_error);

            //LLVM.DisposeMessage(error);
            TargetRef t2;
            string tr2 = LLVM.GetDefaultTargetTriple();
            var b = LLVM.GetTargetFromTriple(tr2, out t2, the_error);
            string triple = "";
            string cpu = "";
            string features = "";

            TargetMachineRef tmr = LLVM.CreateTargetMachine(t2, tr2, cpu, features,
                CodeGenOptLevel.CodeGenLevelDefault,
                RelocMode.RelocDefault,
                CodeModel.CodeModelDefault);

            OrcJITStackRef ojsr = LLVM.OrcCreateInstance(tmr);
            MyString ms = new MyString();
            LLVM.OrcGetMangledSymbol(ojsr, ms, "sum");
            IntPtr ctx = IntPtr.Zero;
            uint xx = LLVM.OrcAddLazilyCompiledIR(ojsr, mod, null, ctx);
            ulong p = LLVM.OrcGetSymbolAddress(ojsr, "sum");
            Add addMethod = (Add)Marshal.GetDelegateForFunctionPointer((System.IntPtr)p, typeof(Add));
            int result = addMethod(10, 10);
            Console.WriteLine("Result of sum is: " + result);
            if (result != 20) throw new Exception("Failed.");
            LLVM.DumpModule(mod);
            LLVM.DisposeBuilder(builder);
        }

        static ulong Resolver(string str, IntPtr ptr)
        {
            return 0;
        }
    }
}
