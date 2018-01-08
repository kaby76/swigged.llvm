swig -debug-memory -debug-classes -debug-symtabs -debug-tmsearch -debug-tmused -debug-symbols -debug-csymbols -debug-lsymbols -debug-typemap -debug-template -csharp -c++ -I./swigged.llvm.native -I../llvm/llvm/include -namespace Swigged.LLVM -dllimport swigged-llvm-native -outdir ../swigged.llvm -o ../swigged.llvm.native/LLVM_wrap.cpp LLVM.i

exit 0
swig -csharp -c++ -I./swigged.llvm.native -I../../llvm/include -namespace CSLLVM -dllimport swigged.llvm.native.dll -outdir ./swigged.llvm.native -o ./swigged.llvm.native/LLVM_wrap.cpp LLVM.i
