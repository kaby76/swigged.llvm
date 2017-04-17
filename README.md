# Swigged-LLVM

This project is a [SWIG](http://swig.org)-generated C# wrapper API for LLVM-C. This code
based upon [SharpLang](https://github.com/xen2/SharpLang), which is defunct. The purpose of that project
was to compile MS IL, and was abandoned when Microsoft open sourced much of the .NET runtime, including
RyuJIT. But, SharpLang contained a SWIG-generated C# wrappar for LLVM-C, useful in it's own right.
Swigged-LLVM takes up the C# API for LLVM, drops the MS IL reader, and extends the API to contain
additional LLVM-C functionality. In addition, Swigged.llvm cleans up some of the problems that were never
fixed in SharpLang, and adds numerous unit tests (whereas SharpLang had only one test, calling only
LLVM.ModuleCreateWithName("Module Name"), i.e., https://github.com/xen2/SharpLang/blob/coreclr/src/SharpLLVM.Tests/TestLLVM.cs).

## Building application with Swigged.llvm:

1) You will need to build your C# application in either x64 or x86 platform, or if built with AnyCPU platform,
set the executable properties with:
a) 

## Build Instructions:

Swigged.llvm requires a build of LLVM, described below.

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

## Debugging

Make sure to enable unmanaged debugging (<EnableUnmanagedDebugging>true</EnableUnmanagedDebugging>),
and unsafe code (<AllowUnsafeBlocks>true</AllowUnsafeBlocks>).

## Doxygen Documentation of LLVM-C:

http://llvm.org/docs/doxygen/html/modules.html

## The API

Swigged.llvm wraps all LLVM-C functions in the namespace Swigged.LLVM. 

## Alternative LLVM Framework for C#

LLVMSharp (https://www.nuget.org/packages/LLVMSharp/3.9.1-rc3)

Note: LLVMSharp is a NET Core API. It appears it cannot be used with NET Framework applications,
at least I have had no luck in doing so. In theory, NET Framework assemblies can be used in
NET Core applications but not the other way around. However, although swigged.llvm 
is a NET Framework API, it does not seem to work with NET Core apps.
