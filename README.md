# Swigged-LLVM

This project is a C# wrapper API for LLVM-C, generated using [SWIG](http://swig.org). This code
is based upon [SharpLang](https://github.com/xen2/SharpLang), which is now defunct. The purpose of that project
was to compile CIL, and was abandoned when Microsoft open sourced much of the .NET runtime, including
RyuJIT. But, SharpLang contained a SWIG-generated C# wrapper for LLVM-C, useful in its own right.
Swigged-LLVM takes up the C# API for LLVM, drops the CIL reader, and extends the API to contain
additional LLVM-C functionality. In addition, Swigged.llvm cleans up some of the problems with
SharpLang, and adds several full-featured tests and examples. I found the documentation for LLVM-C woefully
inadequate: there is in general only one example you can find (factorial), no examples with pointers, arrays,
structs, or PTX.

Note: IMHO, LLVM is a great example of a large system with purportedly a lot
of documentation of which almost entirely useless. The build scripts and examples in
this project were derived mostly by trial and error. As far as LLVM, you have been forewarned.

# Targets

* Windows 10 (x86 and x64)
* Ubuntu.16.04 (x64)
* Android (x86 ABI)

Swigged.llvm can be built and run in the Linux environment. Swigged.llvm is Net Standard 1.5 code. It is compatible with Net Core and Net Framework. Swigged.llvm.native is a platform specific library. Several targets for Linux are included in the NuGet package.
Details to build are described below.

## Using Swigged.llvm (from NuGet):

#### Net Core App on Windows or Linux
````
dotnet add package swigged.llvm
# Ideally, set up your project for a specific target in mind.
dotnet restore -r <target>
dotnet publish -r <target>
# Copy the swigged-llvm-target file to target output directory.
# (For Windows, the search path for the DLL will be adjusted to find the file.
# If not found, or it's the wrong version, copy the file to the target output directory.
# For Ubuntu, you must copy the swigged-llvm-native.so file to the target directory. There is
# no way to search for the file.)
cp {home}/bin/{Debug or Release}/netcoreapp1.1/{target}/publish
````

For an example, see .../Examples/NetcoreApp

#### Net Framework App on Windows

Use the Package Manager GUI in VS 2017 to add in the package "swigged.llvm". Or,
download the package from NuGet (https://www.nuget.org/packages/swigged.llvm) and
add the package "swigged.llvm" from the nuget package manager console.

Set up the build of your C# application with Platform = "AnyCPU", Configuration = "Debug" or "Release". In the Properties for the
application, either un-check "Prefer 32-bit" if you want to run as 64-bit app, or checked if you want to run as a 32-bit app.

You *do not need* to copy swigged.llvm.native.dll to the executable directory. However, if your program is having problems with finding the
dll, copy the swigged-llvm-native.dll from the appropriate target from the packages/ directory.

If you want to debug Swigged.llvm code, set "Enable native code debugging." Note: this option is unavailable in
Net Core apps in Visual Studio 2017 version 15.2.

Swigged.llvm should work out of the box. However, there it does some dependencies to be fulfilled. I have tried
to get this right, but you may need to adjust the versions of the runtimes, e.g., System.Runtime 4.1.0 vs. 4.3.0.


#### Android/Xamarin Apps

You will need to manually copy the SO files and add SO file to your project. You can do
that by editing the CSPROJ file for the Android project.
````
  <ItemGroup>
    <AndroidNativeLibrary Include="lib\x86\libswigged-llvm-native.so" />
  </ItemGroup>
````

For an example, see .../Examples/AndroidApp

# Typical errors when trying to run an application with Swigged.llvm:
a) "Bad image format" error--the swigged.llvm.native.dll in your target directory is the wrong version (32-bit vs 64-bit). Make sure that you have
set the build for your application to Debug or Release and target "Any CPU". If you build with "x86" or "x64", you will need to make sure you are
using the correct swigged-llvm-native.dll/so file. Otherwise, set the "Prefer 32-bit" build option and choose the corresponding swigged-llvm-native.dll/so
file, copying it to your application executable directory.

b) "Missing DLL" error. This can happen for
a number of reasons. Make sure you you have the swigged.llvm.dll and swigged-llvm-natieve.dll/so files in your application executable directory. Make sure you
have all the required dependencies. I've tried hard to make sure this list is correct, but you may need to add in the appropriate
dependencies using the NuGet console.

If the error specifically mentions that it cannot find Swigged.llvm.native, copy the dll/so file to the application executable.
However, you can also try adding in the path helper function:

            Swigged.LLVM.Helper.Adjust.Path();

This function, which you should call before any Swigged.llvm call, alters the
path environmental variable for the program on the fly, so you don't need to copy
swigged.llvm.native.dll/so to your application executable directory. However, it only works
for Net Framework 4.6.2 or 4.7.
c) Crash in Swigged.llvm. This can happen for any number of reasons. LLVM-C can be quite flaky. Make sure
you have initialized LLVM with:

            LLVM.InitializeAllTargets();
            LLVM.InitializeAllTargetMCs();
            LLVM.InitializeAllTargetInfos();
            LLVM.InitializeAllAsmPrinters();

If you suspect that Swigged.llvm is messed up, try the example in C++ or using LLVMSharp. Note,
Swigged.llvm works on some examples that LLVMSharp does not work on (particularily ORC calls).


# Example #

~~~~
using System;
using System.Runtime.InteropServices;
using Swigged.LLVM;

namespace core.sanity_test
{
    class Program
    {
        [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
        public delegate int Add(int a, int b);

        static void Main(string[] args)
        {
            ModuleRef mod = LLVM.ModuleCreateWithName("LLVMSharpIntro");
            TypeRef[] param_types = { LLVM.Int32Type(), LLVM.Int32Type() };
            TypeRef ret_type = LLVM.FunctionType(LLVM.Int32Type(), param_types, false);
            ValueRef sum = LLVM.AddFunction(mod, "sum", ret_type);
            BasicBlockRef entry = LLVM.AppendBasicBlock(sum, "entry");
            BuilderRef builder = LLVM.CreateBuilder();
            LLVM.PositionBuilderAtEnd(builder, entry);
            ValueRef tmp = LLVM.BuildAdd(builder, LLVM.GetParam(sum, 0), LLVM.GetParam(sum, 1), "tmp");
            LLVM.BuildRet(builder, tmp);
            MyString error= new MyString();
            LLVM.VerifyModule(mod, VerifierFailureAction.AbortProcessAction, error);
            System.Console.WriteLine(error);
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
            Console.WriteLine("Result of sum is: " + result);
            if (LLVM.WriteBitcodeToFile(mod, "sum.bc") != 0)
            {
                Console.WriteLine("error writing bitcode to file, skipping");
            }
            LLVM.DumpModule(mod);
            LLVM.DisposeBuilder(builder);
            LLVM.DisposeExecutionEngine(engine);
        }
    }
}
~~~~

## Documentation of Swigged.llvm (Docfx):

http://domemtech.com/swigged-llvm

## Documentation of LLVM-C (Doxygen):

http://llvm.org/docs/doxygen/html/modules.html

## Building Swigged.llvm/swigged.llvm.native:

Swigged.llvm requires a build of LLVM, described below. Building LLVM is a very time consuming process. Also, the SWIG translation spec file is
highly tuned to the particular version of LLVM, currently for Release_40, so it may not work with other releases. Some editing is done post Swig
because Swig hardwires some things.

### General requirements to build

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
cd swigged-llvm/swigged-llvm/llvm
git clone -b release_40 https://github.com/llvm-mirror/llvm.git
cd ..
# You should be in the directory .../swigged-llvm/swigged-llvm/. Following instructions assume this.
~~~~

### Windows ###

#### Build llvm

Depending on what you want, you should build both 32-bit and 64-bit libraries. But,
you can skip one target if you aren't interested.

Note, from Cmd or Powershell, execute the Cmd batch file. This will be four targets for Windows.

~~~~
cd llvm
call .\build.bat
cd ..
~~~~

#### Build swigged.llvm

~~~~
(optional)
a) bash -c ./generate.sh
b) bash -c ./fix.sh
msbuild swigged-llvm.sln /p:Configuration=Debug /p:Platform="AnyCPU"
~~~~

### Ubuntu ###

Currently, I only build for Ubuntu.16.04. I've had problems building LLVM for other targets.

Make sure to install ("sudo apt-get install ...") gcc, make, 'g++', cmake,
git, build-essential, xz-utils. For Net Core, follow the instructions at
https://www.microsoft.com/net/core#linuxubuntu 

#### Build llvm ####

~~~~
cd llvm
./build.sh
cd ..
~~~~

#### Build swigged.llvm ####

~~~~
cd swigged.llvm
dotnet restore
dotnet build
~~~~

_You can reference the swigged.llvm.dll assembly in your project. However, make
sure to copy swigged.llvm.native.dll to your executable directory._

## Debugging on Windows

Enable unmanaged debugging (<EnableUnmanagedDebugging>true</EnableUnmanagedDebugging>).

## Alternative LLVM Frameworks for C#

##### LLVMSharp (https://www.nuget.org/packages/LLVMSharp/3.9.1-rc3   https://github.com/Microsoft/LLVMSharp )

LLVMSharp is the "semi-official" C# LLVM bindings library from Microsoft. 
While it is a NET Core API, it appears it cannot be used with NET Framework
applications--at least I have had no luck in doing so. The bindings are generated
from program contained within the project. I have had no luck in getting through a simple
example using the ORC code generator. (Fortunately, I provide functioning examples in the swigged-llvm project!)

##### LLVM.NET (https://github.com/NETMF/Llvm.NET http://netmf.github.io/Llvm.NET/html/47ec5af0-5c1c-443e-b2b3-158a100dc594.htm )

This project is another C# LLVM bindings librarys.

Note, this project is not confuse this with another "LLVM.NET" library (aka "LLVM by Lost"),
https://bitbucket.org/lost/llvm.net/wiki/Home , http://www.nuget.org/packages/LLVM.NativeLibrary/ , which seems to be a wrapper for some LLVM DLLs built within the project.
It hasn't been updated in several years, so I don't think this project is active anymore.
