# Swigged-LLVM

This project is a [SWIG](http://swig.org)-generated C# wrapper API for LLVM-C. This code
based upon [SharpLang](https://github.com/xen2/SharpLang), which is defunct. The purpose of that project
was to compile MS IL, and was abandoned when Microsoft open sourced much of the .NET runtime, including
RyuJIT. But, SharpLang contained a SWIG-generated C# wrappar for LLVM-C, useful in it's own right.
Swigged-LLVM takes up the C# API for LLVM, drops the MS IL reader, and extends the API to contain
additional LLVM-C functionality.

## Build Instructions:

1) git clone https://github.com/kaby76/swigged-llvm.git
2) cd swigged-llvm
3) git clone -b release_40 https://github.com/llvm-mirror/llvm.git
4) mkdir build-win64 build-win32
5) cd build-win64
6) "%VS150BASE%\VC\Auxiliary\Build\vcvarsall.bat" x64
7) cmake -G "Visual Studio 15 2017 Win64" ..\llvm
8) msbuild LLVM.sln /p:Configuration=Debug /p:Platform=x64
9) cd ..
10) cd build-win32
11) "%VS150BASE%\VC\Auxiliary\Build\vcvarsall.bat" x86
12) cmake -G "Visual Studio 15 2017" ..\llvm
13) msbuild LLVM.sln /p:Configuration=Debug /p:Platform=Win32
14) cd ../swigged-llvm
15) msbuild swigged-llvm.sln /p:Configuration=Debug /p:Platform=x86

## Testing

Make sure to set the Default Processor Architecture to x86 or x64, then
recompile in Visual Studio 2017. If you don't set the DPA, then
no tests will be discovered, and so cannot be run.

Test>Test Settings>Default Processor Architecture>X64

## Doxygen Documentation:

http://llvm.org/docs/doxygen/html/modules.html

## Alternative LLVM Framework for C#

LLVMSharp (https://www.nuget.org/packages/LLVMSharp/3.9.1-rc3)
