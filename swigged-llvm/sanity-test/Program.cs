using System;
using System.Diagnostics;
using System.IO;
using System.Runtime.InteropServices;
using System.Text;
using ManagedCuda;
using ManagedCuda.VectorTypes;
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
    }
}
