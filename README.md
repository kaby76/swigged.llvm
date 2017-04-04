# Swigged-LLVM

This project is a SWIG-generated C# wrapper API for LLVM-C. This code
based upon [SharpLang](https://github.com/xen2/SharpLang), which is defunct. The purpose of that project
was to compile MS IL, and was abandoned with the open sourcing of RyuJIT. But it also contained a
SWIG-generated C# wrappar for LLVM-C. Swigged-LLVM drops the MS IL reader and extends the API to contain
additional LLVM-C functions.

## Build Instructions:

1) git clone https://github.com/kaby76/swigged-llvm.git
2) cd swigged-llvm
3) git clone -b release_40 https://github.com/llvm-mirror/llvm.git
4) mkdir build-win64
5) cd build-win64
6) "%VS150BASE%\VC\Auxiliary\Build\vcvarsall.bat" x64
7) cmake -G "Visual Studio 15 2017 Win64" ..\llvm
8) msbuild LLVM.sln /p:Configuration=Debug /p:Platform=x64
9) cd ..
9) mkdir build-win32
10) cd build-win32
11) "%VS150BASE%\VC\Auxiliary\Build\vcvarsall.bat" x86
12) cmake -G "Visual Studio 15 2017 Win32" ..\llvm
13) msbuild LLVM.sln /p:Configuration=Debug /p:Platform=x32
14) cd ../swigged-llvm
15) msbuild swigged-llvm.sln /p:Configuration=Debug /p:Platform=x64

## Doxygen Documentation:

http://llvm.org/docs/doxygen/html/modules.html

## Alternative LLVM Framework for C#

LLVMSharp (https://www.nuget.org/packages/LLVMSharp/3.9.1-rc3)
