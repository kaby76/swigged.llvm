using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using App1.Droid.Annotations;
using Xamarin.Forms;
using Swigged.LLVM;

namespace App1
{
	public partial class MainPage : ContentPage
	{
		public MainPage()
		{
			InitializeComponent();
        }
    }

    public class LlvmViewModel : INotifyPropertyChanged
    {
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int Add(int a, int b);

        public event PropertyChangedEventHandler PropertyChanged;

        [NotifyPropertyChangedInvocator]
        protected virtual void OnPropertyChanged([CallerMemberName] string propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }

        public string Result
        {
            get
            {
                StringBuilder sb = new StringBuilder();
                sb.AppendLine("Result of LLVM Test:");
                ModuleRef mod = LLVM.ModuleCreateWithName("LLVMSharpIntro");
                TypeRef[] param_types = { LLVM.Int32Type(), LLVM.Int32Type() };
                TypeRef ret_type = LLVM.FunctionType(LLVM.Int32Type(), param_types, false);
                ValueRef sum = LLVM.AddFunction(mod, "sum", ret_type);
                BasicBlockRef entry = LLVM.AppendBasicBlock(sum, "entry");
                BuilderRef builder = LLVM.CreateBuilder();
                LLVM.PositionBuilderAtEnd(builder, entry);
                ValueRef tmp = LLVM.BuildAdd(builder, LLVM.GetParam(sum, 0), LLVM.GetParam(sum, 1), "tmp");
                LLVM.BuildRet(builder, tmp);
                MyString error = new MyString();
                LLVM.VerifyModule(mod, VerifierFailureAction.AbortProcessAction, error);
                sb.AppendLine(error.ToString());
                ExecutionEngineRef engine;
                LLVM.LinkInMCJIT();
                LLVM.InitializeNativeTarget();
                LLVM.InitializeNativeAsmPrinter();
                MCJITCompilerOptions options = new MCJITCompilerOptions();
                var optionsSize = (4 * sizeof(int)) + IntPtr.Size; // LLVMMCJITCompilerOptions has 4 ints and a pointer
                LLVM.InitializeMCJITCompilerOptions(options, (uint)optionsSize);
                LLVM.CreateMCJITCompilerForModule(out engine, mod, options, (uint)optionsSize, error);
                var ptr = LLVM.GetPointerToGlobal(engine, sum);
                IntPtr p = (IntPtr)ptr;
                Add addMethod = (Add)Marshal.GetDelegateForFunctionPointer(p, typeof(Add));
                int result = addMethod(10, 10);
                sb.AppendLine("Result of sum is: " + result);
                if (LLVM.WriteBitcodeToFile(mod, "sum.bc") != 0)
                {
                    sb.AppendLine("error writing bitcode to file, skipping");
                }
                LLVM.DumpModule(mod);
                LLVM.DisposeBuilder(builder);
                LLVM.DisposeExecutionEngine(engine);
                return sb.ToString();
            }
        }
    }
}
