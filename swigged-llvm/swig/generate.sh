set -e
swig -debug-memory -debug-classes -debug-symtabs -debug-tmsearch -debug-tmused -debug-symbols -debug-csymbols -debug-lsymbols -debug-typemap -debug-template -csharp -c++ -I./swigged.llvm.native -I../llvm/llvm/include -namespace Swigged.LLVM -dllimport swigged-llvm-native -outdir ../swigged.llvm -o ../swigged.llvm.native/LLVM_wrap.cpp LLVM.i
cd ../swigged.llvm
cat DIFlags.cs | sed -e 's/LLVMDIFlagPrivate/DIFlagPrivate/g' | sed -e 's/LLVMDIFlagProtected/DIFlagProtected/g' | sed -e 's/LLVMDIFlagPublic/DIFlagPublic/g' | sed -e 's/LLVMDIFlagSingleInheritance/DIFlagSingleInheritance/g' | sed -e 's/LLVMDIFlagMultipleInheritance/DIFlagMultipleInheritance/g' | sed -e 's/LLVMDIFlagVirtualInheritance/DIFlagVirtualInheritance/g' > t
rm DIFlags.cs
mv t DIFlags.cs
exit 0
swig -csharp -c++ -I./swigged.llvm.native -I../../llvm/include -namespace CSLLVM -dllimport swigged.llvm.native.dll -outdir ./swigged.llvm.native -o ./swigged.llvm.native/LLVM_wrap.cpp LLVM.i
