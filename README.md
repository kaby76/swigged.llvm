# Swigged-LLVM

This project is a SWIG-generated C# wrapper API for LLVM-C. This code
based upon SharpLLVM, a project that is now defunct.

Build Instructions:

1) git clone https://github.com/kaby76/swigged-llvm.git
2) cd swigged-llvm
3) git clone -b release_40 https://github.com/llvm-mirror/llvm.git
4) mkdir build-win64
5) cd build-win64
6) "%VS150BASE%\VC\Auxiliary\Build\vcvarsall.bat" x64
7) cmake -G "Visual Studio 15 2017 Win64" ..\llvm
8) msbuild LLVM.sln /p:Configuration=Debug /p:Platform=x64
9) cd swigged-llvm
10) msbuild swigged-llvm.sln /p:Configuration=Debug /p:Platform=x64

