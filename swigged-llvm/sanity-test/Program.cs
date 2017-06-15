﻿using System;
using System.Diagnostics;
using System.Runtime.InteropServices;
using Swigged.LLVM;

namespace ConsoleApplication1
{
    class Program
    {
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int Add(int a, int b);

        public static ulong Factorial(ulong i)
        {
            ulong result = 1;
            if (i == 0) return 1;
            if (i == 1) return 1;
            return Factorial(i - 1) * i;
        }

        static void Main(string[] args)
        {
            Swigged.LLVM.Helper.Adjust.Path();

            // As it turns out, we need InitializeNativeTarget for ORC. Otherwise,
            // GetTargetFromTriple fails.
            // LLVM.LinkInMCJIT();
            //LLVM.InitializeNativeTarget();
            // LLVM.InitializeNativeAsmPrinter();
            LLVM.InitializeAllTargets();
            LLVM.InitializeAllTargetMCs();
            LLVM.InitializeAllTargetInfos();
            LLVM.InitializeAllAsmPrinters();

            Test1();
            Test2();
            Test3();
            Test4();
            Test5();
        }

        static void Test1()
        {
            ModuleRef mod = LLVM.ModuleCreateWithName("LLVMSharpIntro");
            TypeRef[] param_types = {LLVM.Int32Type(), LLVM.Int32Type()};
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
            ExecutionEngineRef engine;
            MCJITCompilerOptions options = new MCJITCompilerOptions();
            var optionsSize = (4 * sizeof(int)) + IntPtr.Size; // LLVMMCJITCompilerOptions has 4 ints and a pointer
            LLVM.InitializeMCJITCompilerOptions(options, (uint) optionsSize);
            LLVM.CreateMCJITCompilerForModule(out engine, mod, options, (uint) optionsSize, the_error);
            var ptr = LLVM.GetPointerToGlobal(engine, sum);
            IntPtr p = (IntPtr) ptr;
            Add addMethod = (Add) Marshal.GetDelegateForFunctionPointer(p, typeof(Add));
            int result = addMethod(10, 10);
            Console.WriteLine("Result of sum is: " + result);
            if (LLVM.WriteBitcodeToFile(mod, "sum.bc") != 0)
            {
                Console.WriteLine("error writing bitcode to file, skipping");
            }
            LLVM.DumpModule(mod);
            LLVM.DisposeBuilder(builder);
            LLVM.DisposeExecutionEngine(engine);
        }

        public static void Test2()
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

            ValueRef If = LLVM.BuildICmp(builder, Swigged.LLVM.IntPredicate.IntEQ, n, LLVM.ConstInt(LLVM.Int32Type(), 0, false),
                "n == 0");

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

            MyString error = new MyString();
            ExecutionEngineRef engine;
            ModuleProviderRef provider = LLVM.CreateModuleProviderForExistingModule(mod);
            LLVM.CreateJITCompilerForModule(out engine, mod, 0, error);

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

            ulong input = 10;
            GenericValueRef exec_args = LLVM.CreateGenericValueOfInt(LLVM.Int32Type(), input, false);
            GenericValueRef exec_res = LLVM.RunFunction(engine, fac, 1, out exec_args);
            var result_of_function = LLVM.GenericValueToInt(exec_res, false);
            var result_of_csharp_function = Factorial(input);
            Debug.Assert(result_of_csharp_function == result_of_function);

            LLVM.DisposePassManager(pass);
            LLVM.DisposeBuilder(builder);
            LLVM.DisposeExecutionEngine(engine);
        }

        public static void Test3()
        {
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

            LLVM.DumpModule(mod);
            LLVM.DisposeBuilder(builder);
        }

        static ulong Resolver(string str, IntPtr ptr)
        {
            return 0;
        }

        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate void PAdd(IntPtr a);

        static void Test4()
        {
            ModuleRef mod = LLVM.ModuleCreateWithName("llvmptx");
            var pt = LLVM.PointerType(LLVM.Int64Type(), 1);
            TypeRef[] param_types = { pt };
            TypeRef ret_type = LLVM.FunctionType(LLVM.VoidType(), param_types, false);
            ValueRef sum = LLVM.AddFunction(mod, "sum", ret_type);
            BasicBlockRef entry = LLVM.AppendBasicBlock(sum, "entry");
            BuilderRef builder = LLVM.CreateBuilder();
            LLVM.PositionBuilderAtEnd(builder, entry);
            var v = LLVM.BuildLoad(builder, LLVM.GetParam(sum, 0), "");
            ValueRef tmp = LLVM.BuildAdd(builder, v, LLVM.ConstInt(LLVM.Int64Type(), 1, false), "tmp");
            LLVM.BuildStore(builder, tmp, LLVM.GetParam(sum, 0));
            LLVM.BuildRetVoid(builder);
            MyString the_error = new MyString();
            LLVM.VerifyModule(mod, VerifierFailureAction.PrintMessageAction, the_error);
            //LLVM.DisposeMessage(error);
            ExecutionEngineRef engine;
            MCJITCompilerOptions options = new MCJITCompilerOptions();
            var optionsSize = (4 * sizeof(int)) + IntPtr.Size; // LLVMMCJITCompilerOptions has 4 ints and a pointer
            LLVM.InitializeMCJITCompilerOptions(options, (uint)optionsSize);
            LLVM.CreateMCJITCompilerForModule(out engine, mod, options, (uint)optionsSize, the_error);
            var ptr = LLVM.GetPointerToGlobal(engine, sum);
            IntPtr p = (IntPtr)ptr;

            var dataArray = new Int64[1];
            dataArray[0] = 99;
            var handle = GCHandle.Alloc(dataArray, GCHandleType.Pinned);
            IntPtr a = handle.AddrOfPinnedObject();

            PAdd addMethod = (PAdd)Marshal.GetDelegateForFunctionPointer(p, typeof(PAdd));

            addMethod(a);

            Console.WriteLine("Result of sum is: " + dataArray[0]);
            if (LLVM.WriteBitcodeToFile(mod, "sum.bc") != 0)
            {
                Console.WriteLine("error writing bitcode to file, skipping");
            }
            LLVM.DumpModule(mod);
            LLVM.DisposeBuilder(builder);
            LLVM.DisposeExecutionEngine(engine);
            handle.Free();

        }

        static void Test5()
        {
            ModuleRef mod = LLVM.ModuleCreateWithName("llvmptx");
            var pt = LLVM.PointerType(LLVM.Int64Type(), 1);
            TypeRef[] param_types = { pt };
            TypeRef ret_type = LLVM.FunctionType(LLVM.VoidType(), param_types, false);
            ValueRef sum = LLVM.AddFunction(mod, "sum", ret_type);
            BasicBlockRef entry = LLVM.AppendBasicBlock(sum, "entry");
            BuilderRef builder = LLVM.CreateBuilder();
            LLVM.PositionBuilderAtEnd(builder, entry);
            var v = LLVM.BuildLoad(builder, LLVM.GetParam(sum, 0), "");
            ValueRef tmp = LLVM.BuildAdd(builder, v, LLVM.ConstInt(LLVM.Int64Type(), 1, false), "tmp");
            LLVM.BuildStore(builder, tmp, LLVM.GetParam(sum, 0));
            LLVM.BuildRetVoid(builder);
            MyString the_error = new MyString();
            LLVM.VerifyModule(mod, VerifierFailureAction.PrintMessageAction, the_error);

            string triple = "nvptx64-nvidia-cuda";
            TargetRef t2;
            var b = LLVM.GetTargetFromTriple(triple, out t2, the_error);

            string cpu = "";
            string features = "";

            TargetMachineRef tmr = LLVM.CreateTargetMachine(t2, triple, cpu, features,
                CodeGenOptLevel.CodeGenLevelDefault,
                RelocMode.RelocDefault,
                CodeModel.CodeModelKernel);

            var y1 = LLVM.TargetMachineEmitToMemoryBuffer(
                    tmr,
                    mod,
                    Swigged.LLVM.CodeGenFileType.AssemblyFile,
                    the_error,
                    out MemoryBufferRef buffer);
                    
            try
            {
                string start = LLVM.GetBufferStart(buffer);
                uint length = LLVM.GetBufferSize(buffer);
                System.Console.WriteLine(start);
            }
            finally
            {
                LLVM.DisposeMemoryBuffer(buffer);
            }


            //OrcJITStackRef ojsr = LLVM.OrcCreateInstance(tmr);
            //MyString ms = new MyString();
            //LLVM.OrcGetMangledSymbol(ojsr, ms, "sum");
            //IntPtr ctx = IntPtr.Zero;
            //uint xx = LLVM.OrcAddLazilyCompiledIR(ojsr, mod, null, ctx);
            //ulong p = LLVM.OrcGetSymbolAddress(ojsr, "sum");
            //Add addMethod = (Add)Marshal.GetDelegateForFunctionPointer((System.IntPtr)p, typeof(Add));
            //int result = addMethod(10, 10);
            //Console.WriteLine("Result of sum is: " + result);

            LLVM.DumpModule(mod);
            LLVM.DisposeBuilder(builder);

        }
    }


}
