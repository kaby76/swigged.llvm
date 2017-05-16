using System;
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
            Test1();
            Test2();
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
            string error = null;
            MyString the_error = new MyString((IntPtr)0);
            LLVM.VerifyModule(mod, VerifierFailureAction.AbortProcessAction, the_error);
            //LLVM.DisposeMessage(error);
            ExecutionEngineRef engine;
            LLVM.LinkInMCJIT();
            LLVM.InitializeNativeTarget();
            LLVM.InitializeNativeAsmPrinter();
            MCJITCompilerOptions options;
            var optionsSize = (4 * sizeof(int)) + IntPtr.Size; // LLVMMCJITCompilerOptions has 4 ints and a pointer
            LLVM.InitializeMCJITCompilerOptions(out options, (uint) optionsSize);
            LLVM.CreateMCJITCompilerForModule(out engine, mod, out options, (uint) optionsSize, out error);
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
    }


}
