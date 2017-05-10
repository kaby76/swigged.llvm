# Swigged-LLVM

This project is a [SWIG](http://swig.org)-generated C# wrapper API for LLVM-C. This code
based upon [SharpLang](https://github.com/xen2/SharpLang), which is defunct. The purpose of that project
was to compile MS IL, and was abandoned when Microsoft open sourced much of the .NET runtime, including
RyuJIT. But, SharpLang contained a SWIG-generated C# wrappar for LLVM-C, useful in it's own right.
Swigged-LLVM takes up the C# API for LLVM, drops the MS IL reader, and extends the API to contain
additional LLVM-C functionality. In addition, Swigged.llvm cleans up some of the problems that were never
fixed in SharpLang, and adds several full-featured tests (whereas SharpLang had only one test, calling only
LLVM.ModuleCreateWithName("Module Name"), i.e., https://github.com/xen2/SharpLang/blob/coreclr/src/SharpLLVM.Tests/TestLLVM.cs).

Swigged.llvm can be built and run in the Linux environment. Most of Swigged.llvm is Net Standard 1.6 code, and runs on any platform 
where Net Core runs. Swigged.llvm.native is platform specific. Several targets for Linux are included in the NuGet package.
Details to build in Linux are described below.

## Linking and building with Swigged.llvm from NuGet:

1) Download the package from NuGet (currently https://www.nuget.org/packages/swigged.llvm/4.0.1.2-alpha), or in Visual Studio,
add the package "swigged.llvm".
2) Set up the build of your C# application with Platform = "AnyCPU", Configuration = "Debug" or "Release". In the Properties for the
application, either un-check "Prefer 32-bit" if you want to run as 64-bit app, or checked if you want to run as a 32-bit app. Swigged-llvm
should copy swigged.llvm.native.dll of the appropriate type to the executable directory.
3) If you want to debug Swigged.llvm code, set "Enable native code debugging." Note: this option is unavailable in
Net Core apps in Visual Studio 2017 version 15.1 April 15 2017.
4) Run. There are several potential problems:
a) "Bad image format" error--the swigged.llvm.native.dll in your target directory is the wrong version (32-bit vs 64-bit).
b) "Missing DLL" error--make sure swigged.llvm.native.dll and std.swigged.llvm.dll are in your executable directory.
c) Crash in VerifyModule() call--the translation of "char **" is incorrect. Comment out the call for now.

## Building Swigged.llvm:

Swigged.llvm requires a build of LLVM, described below. Building LLVM is a very time consuming process. Also, the SWIG translation spec file is
highly tuned to the particular version of LLVM, currently for Release_40, so it may not work with other releases.

Also note that LLVM does not use tags in its repository! Therefore, if you want a particular version of finer granularity than the latest on a branch, you
will need to grab the sources directly from the LLVM download area and unpack them.

### Requirements to build

* Cmake
* Git
* VS 2017 or 2015, with C++ installed (Windows)
* Python
* WSL Bash (Windows)
* These tools in path variable.

~~~~
# Optimized for DigitalOcean.com
sudo apt-get install git
sudo apt-get update
sudo apt-get install cmake
sudo apt-get install build-essential
~~~~

### Grab sources from git or LLVM download area.

In a directory of your choice, clone LLVM and swigged.llvm. If you
downloaded LLVM sources, place them here.

~~~~
git clone https://github.com/kaby76/swigged-llvm.git
git clone -b release_40 https://github.com/llvm-mirror/llvm.git
~~~~

The build of swigged.llvm will assume this directory structure.

### Windows ###

#### build llvm

Depending on what you want, you should build both 32-bit and 64-bit libraries. But,
you can skip one target if you aren't interested.

Note, use Cmd or Powershell to execute the following.
Make sure WSL bash is used, and not Cygwin or Mingw.

~~~~
mkdir build-win64 build-win32
cd build-win64
"%VSINSTALLDIR%\VC\Auxiliary\Build\vcvarsall.bat" x64
cmake -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD=X86 -G "Visual Studio 15 2017 Win64" ..\llvm
msbuild LLVM.sln /p:Configuration=Debug /p:Platform=x64
cd ..
cd build-win32
"%VSINSTALLDIR%\VC\Auxiliary\Build\vcvarsall.bat" x86
cmake -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD=X86 -G "Visual Studio 15 2017" ..\llvm
msbuild LLVM.sln /p:Configuration=Debug /p:Platform=Win32
~~~~

#### build swigged.llvm

1) cd ../swigged-llvm
2) (optional)
  a) bash -c ./generate.sh
  b) bash -c ./fix.sh
3) msbuild swigged-llvm.sln /p:Configuration=Debug /p:Platform="AnyCPU"

### Ubuntu/Linux ###

Make sure to install ("sudo apt-get install ...") gcc, make, 'g++', cmake,
git, build-essential, xz-utils. For Net Core, follow the instructions at
https://www.microsoft.com/net/core#linuxubuntu 

#### build llvm ####

~~~~
pushd .; cd llvm; mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD=X86 ../llvm/
make
cd lib/cmake/llvm; export=`pwd`
popd
~~~~

#### build swigged.llvm ####

1) cd swigged-llvm
2) dotnet restore
3) cd std.swigged.llvm; dotnet restore; dotnet build; cd ..
4) cd core.sanity-test; dotnet restore; dotnet build; cd ..
5) mkdir build; cd build; cmake -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD=X86 ../llvm/

make; cd ..

#### run ####

1) cd core.sanity-test; cp ../build/swigged.llvm.native.so bin/Debug/netcoreapp1.1/
2) dotnet run

## Testing

... (incomplete)

## Debugging on Window

Enable unmanaged debugging (<EnableUnmanagedDebugging>true</EnableUnmanagedDebugging>).

## Documentation of Swigged.llvm (Docfx):

http://domemtech.com/swigged-llvm

## Documentation of LLVM-C (Doxygen):

http://llvm.org/docs/doxygen/html/modules.html

## Alternative LLVM Framework for C#

LLVMSharp (https://www.nuget.org/packages/LLVMSharp/3.9.1-rc3)

Note: LLVMSharp is a NET Core API. It appears it cannot be used with NET Framework applications,
at least I have had no luck in doing so. In theory, NET Framework assemblies can be used in
NET Core applications but not the other way around. However, although swigged.llvm 
is a NET Framework API, it does not seem to work with NET Core apps.
