using System;
using System.Runtime.InteropServices;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Swigged.LLVM;

namespace UnitTestProject6
{
    [TestClass]
    public class UnitTest1
    {
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int Add(int a, int b);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int Sub(int a, int b);

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int Comb();

        /// <summary>
        /// This test works with different modules, linking them together, and executing.
        /// </summary>
        [TestMethod]
        public void TestMultiModules()
        {
            Swigged.LLVM.Helper.Adjust.Path();

            LLVM.InitializeAllTargets();
            LLVM.InitializeAllTargetMCs();
            LLVM.InitializeAllTargetInfos();
            LLVM.InitializeAllAsmPrinters();

            // First module contains add.
            ModuleRef mod1 = LLVM.ModuleCreateWithName("LLVMSharpIntro");
            TypeRef[] param_types1 = { LLVM.Int32Type(), LLVM.Int32Type() };
            TypeRef ret_type1 = LLVM.FunctionType(LLVM.Int32Type(), param_types1, false);
            ValueRef add = LLVM.AddFunction(mod1, "add", ret_type1);
            BasicBlockRef entry1 = LLVM.AppendBasicBlock(add, "entry");
            BuilderRef builder1 = LLVM.CreateBuilder();
            LLVM.PositionBuilderAtEnd(builder1, entry1);
            ValueRef tmp1 = LLVM.BuildAdd(builder1, LLVM.GetParam(add, 0), LLVM.GetParam(add, 1), "tmp");
            LLVM.BuildRet(builder1, tmp1);
            MyString the_error = new MyString();
            LLVM.VerifyModule(mod1, VerifierFailureAction.PrintMessageAction, the_error);
            LLVM.DumpModule(mod1);

            // Second module contains sub.
            ModuleRef mod2 = LLVM.ModuleCreateWithName("LLVMSharpIntro");
            TypeRef[] param_types2 = { LLVM.Int32Type(), LLVM.Int32Type() };
            TypeRef ret_type2 = LLVM.FunctionType(LLVM.Int32Type(), param_types2, false);
            ValueRef sub = LLVM.AddFunction(mod2, "sub", ret_type2);
            BasicBlockRef entry2 = LLVM.AppendBasicBlock(sub, "entry");
            BuilderRef builder2 = LLVM.CreateBuilder();
            LLVM.PositionBuilderAtEnd(builder2, entry2);
            ValueRef tmp2 = LLVM.BuildSub(builder2, LLVM.GetParam(sub, 0), LLVM.GetParam(sub, 1), "tmp");
            LLVM.BuildRet(builder2, tmp2);
            LLVM.VerifyModule(mod2, VerifierFailureAction.PrintMessageAction, the_error);
            LLVM.DumpModule(mod2);

            // Third module contains uses of add and sub.
            ModuleRef mod3 = LLVM.ModuleCreateWithName("LLVMSharpIntro");
            TypeRef[] param_types3 = { };
            TypeRef ret_type3 = LLVM.FunctionType(LLVM.Int32Type(), param_types3, false);
            ValueRef comb = LLVM.AddFunction(mod3, "comb", ret_type3);
            ValueRef add1 = LLVM.AddFunction(mod3, "add", ret_type1);
            ValueRef sub2 = LLVM.AddFunction(mod3, "sub", ret_type1);
            BasicBlockRef entry3 = LLVM.AppendBasicBlock(comb, "entry");
            BuilderRef builder3 = LLVM.CreateBuilder();
            LLVM.PositionBuilderAtEnd(builder3, entry3);
            ValueRef tmpa3 = LLVM.ConstInt(LLVM.Int32Type(), 1, false);
            ValueRef tmpb3 = LLVM.ConstInt(LLVM.Int32Type(), 2, false);
            ValueRef tmpc3 = LLVM.ConstInt(LLVM.Int32Type(), 3, false);
            var tmpd3 = LLVM.BuildCall(builder3, add1, new ValueRef[] { tmpa3, tmpc3 }, "");
            var tmpe3 = LLVM.BuildCall(builder3, sub2, new ValueRef[] { tmpd3, tmpb3 }, "");
            LLVM.BuildRet(builder3, tmpe3);

            LLVM.VerifyModule(mod3, VerifierFailureAction.PrintMessageAction, the_error);
            LLVM.DumpModule(mod3);

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
            LLVM.OrcGetMangledSymbol(ojsr, ms, "comb");
            IntPtr ctx = IntPtr.Zero;
            SharedModuleRef smr1 = LLVM.OrcMakeSharedModule(mod1);
            var xx = LLVM.OrcAddLazilyCompiledIR(ojsr, out uint omh1, smr1, null, ctx);
            SharedModuleRef smr2 = LLVM.OrcMakeSharedModule(mod2);
            xx = LLVM.OrcAddLazilyCompiledIR(ojsr, out uint omh2, smr2, null, ctx);
            SharedModuleRef smr3 = LLVM.OrcMakeSharedModule(mod3);
            xx = LLVM.OrcAddLazilyCompiledIR(ojsr, out uint omh3, smr3, null, ctx);
            var p = LLVM.OrcGetSymbolAddress(ojsr, out IntPtr RetAddr, "comb");
            Comb combMethod = (Comb)Marshal.GetDelegateForFunctionPointer(RetAddr, typeof(Comb));
            int result = combMethod();
            Console.WriteLine("Result of comb is: " + result);
            if (result != 2) throw new Exception();
        }

        static ulong Resolver(string str, IntPtr ptr)
        {
            return 0;
        }
    }
}

