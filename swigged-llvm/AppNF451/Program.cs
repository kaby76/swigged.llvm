using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using Swigged.LLVM;

namespace AppNF451
{
    class Program
    {
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int Add(int a, int b);

        static void Main(string[] args)
        {
            LLVM.InitializeAllTargets();
            LLVM.InitializeAllTargetMCs();
            LLVM.InitializeAllTargetInfos();
            LLVM.InitializeAllAsmPrinters();

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
            ExecutionEngineRef engine;
            MCJITCompilerOptions options = new MCJITCompilerOptions();
            var optionsSize = (4 * sizeof(int)) + IntPtr.Size; // LLVMMCJITCompilerOptions has 4 ints and a pointer
            LLVM.InitializeMCJITCompilerOptions(options, (uint)optionsSize);
            LLVM.CreateMCJITCompilerForModule(out engine, mod, options, (uint)optionsSize, the_error);
            var ptr = LLVM.GetPointerToGlobal(engine, sum);
            IntPtr p = (IntPtr)ptr;
            Add addMethod = (Add)Marshal.GetDelegateForFunctionPointer(p, typeof(Add));
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
