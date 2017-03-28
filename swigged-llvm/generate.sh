swig -debug-memory -debug-classes -debug-symtabs -debug-tmsearch -debug-tmused -debug-symbols -debug-csymbols -debug-lsymbols -debug-typemap -debug-template -csharp -c++ -I./nlib -I../llvm/include -namespace CSLLVM -dllimport CSLLVM.Native.dll -outdir ./lib -o ./nlib/LLVM_wrap.cpp LLVM.i

exit 0
swig -csharp -c++ -I./nlib -I../../llvm/include -namespace CSLLVM -dllimport CSLLVM.Native.dll -outdir ./lib -o ./nlib/LLVM_wrap.cpp LLVM.i
