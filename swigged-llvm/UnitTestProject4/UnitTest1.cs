using System;
using System.Text;
using ManagedCuda;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Swigged.LLVM;

namespace UnitTestProject4
{
    [TestClass]
    public class UnitTest1
    {
        [TestMethod]
        public void TestPTX()
        {
            Swigged.LLVM.Helper.Adjust.Path();
            LLVM.InitializeAllTargets();
            LLVM.InitializeAllTargetMCs();
            LLVM.InitializeAllTargetInfos();
            LLVM.InitializeAllAsmPrinters();
            ModuleRef mod = LLVM.ModuleCreateWithName("llvmptx");
            var pt = LLVM.PointerType(LLVM.Int64Type(), 1);
            TypeRef[] param_types = {pt};
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
            ContextRef context_ref = LLVM.ContextCreate();
            ValueRef kernelMd = LLVM.MDNodeInContext(context_ref, new ValueRef[3]
            {
                sum,
                LLVM.MDStringInContext(context_ref, "kernel", 6),
                LLVM.ConstInt(LLVM.Int32TypeInContext(context_ref), 1, false)
            });
            LLVM.AddNamedMetadataOperand(mod, "nvvm.annotations", kernelMd);
            var y1 = LLVM.TargetMachineEmitToMemoryBuffer(
                tmr,
                mod,
                Swigged.LLVM.CodeGenFileType.AssemblyFile,
                the_error,
                out MemoryBufferRef buffer);
            string ptx = null;
            try
            {
                ptx = LLVM.GetBufferStart(buffer);
                uint length = LLVM.GetBufferSize(buffer);
                // Output the PTX assembly code. We can run this using the CUDA Driver API
                System.Console.WriteLine(ptx);
            }
            finally
            {
                LLVM.DisposeMemoryBuffer(buffer);
            }


            // RUN THE MF.

            Int64[] h_C = new Int64[100];
            CudaContext ctx = new CudaContext(CudaContext.GetMaxGflopsDeviceId());
            CudaKernel kernel = ctx.LoadKernelPTX(Encoding.ASCII.GetBytes(ptx), "sum");
            var d_C = new CudaDeviceVariable<Int64>(100);
            int N = 1;
            int threadsPerBlock = 256;
            kernel.BlockDimensions = threadsPerBlock;
            kernel.GridDimensions = (N + threadsPerBlock - 1) / threadsPerBlock;
            kernel.Run(d_C.DevicePointer);
            h_C = d_C;
            System.Console.WriteLine("Result " + h_C[0]);
            if (h_C[0] != 1) throw new Exception("Failed.");
            LLVM.DumpModule(mod);
            LLVM.DisposeBuilder(builder);
        }
    }
}
