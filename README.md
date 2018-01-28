# Swigged-LLVM

This project is a [SWIG](http://swig.org)-generated wrapper of LLVM-C for C#. This code
is based upon [SharpLang](https://github.com/xen2/SharpLang), which is now defunct. The purpose of that project
was to compile Microsoft's [CIL](https://en.wikipedia.org/wiki/Common_Intermediate_Language), but was mothballed
when Microsoft open sourced much of the .NET runtime, including RyuJIT.

Swigged-LLVM recovers the SWIG wrapper for LLVM-C in Sharplang. Swigged-LLVM drops the CIL
reader, and extends the API to contain additional LLVM-C functionality. Swigged.llvm cleans
up some of the problems with the original wrapper in SharpLang, adds more tests of the API,
and adds several examples.

Notes: I found the documentation for LLVM-C and LLVM quite frustrating, including:
the building of LLVM; the identification
of what is going to be in a release;
bug reporting and fixing.

The build scripts in
this project were derived mostly by trial and error for Windows and Android,
from the documentation in LLVM (http://llvm.org/docs/CMake.html ) and
Android cmake (https://developer.android.com/ndk/guides/cmake.html ).

A second important note is that there are no LLVM-C pre-built DLLs.
All LLVM NET wrappers must chooses what to expose. Fortunately, there are not many changes
to the LLVM-C .H include files. What is exported from LLVM-C for each release of Swigged.LLVM
is completely derived by trail and error.

Some changes are future features being accidentally
added to a release. Unfortunately,
LLVM authors do not check their work to see if even breaks a build--especially Windows:
[33455](https://bugs.llvm.org/show_bug.cgi?id=33455),
[34633](https://bugs.llvm.org/show_bug.cgi?id=34633),
[35947](https://bugs.llvm.org/show_bug.cgi?id=35947).

The examples here were culled and derived from a variety
of sources. The equivalent of the Kaleidoscope example is not provided here because it focuses too much on compiler construction
and little on the API itself. Swigged-llvm is used in another project I am writing, [Campy](http://campynet.com/),
which compiles CIL into GPU code for parallel programming.

# Targets

* Windows 10 (x64)
* Ubuntu.16.04 (x64)

Swigged.llvm can be built and run in the Linux environment. Swigged.llvm is Net Standard 2.0 assembly. It is compatible with Net Core 2.0 and Net Framework 4.6.1 and later versions. Swigged.llvm.native is a platform specific library.
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
application, un-check "Prefer 32-bit" to run as 64-bit app.

You should not have to copy swigged.llvm.native.dll to the executable directory. However, if your program is having problems with finding the
dll, copy the swigged-llvm-native.dll from the appropriate target from the packages/ directory.

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
* VS 2017, with C++ installed (Windows)
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

In a directory of your choice, clone swigged.llvm, then clone llvm. Note, I've created
a repository of llvm-mirror because there are build problems currently with LLVM. It also
does not contain tags for particular releases, only branches, which is not sufficient to
select particular sources for debugging.

~~~~
git clone https://github.com/kaby76/swigged-llvm.git
cd swigged-llvm/swigged-llvm/llvm
git clone https://github.com/kaby76/llvm.git
~~~~

### Windows ###

Depending on what you want, you should build both 32-bit and 64-bit libraries. But,
you can skip one target if you aren't interested.

Note, from Cmd or Powershell, execute the Cmd batch file. This will be four targets for Windows.

~~~~
cd .swig
cd ..
bash -c ./generate.sh
cd llvm
call .\build.bat
cd ..
msbuild swigged-llvm.sln /p:Configuration=Debug /p:Platform="AnyCPU"
cd swigged.llvm.native
powershell
./build.ps1
~~~~

### Ubuntu ###

Currently, I only build for Ubuntu.16.04. I've had problems building LLVM for other targets.

Make sure to install ("sudo apt-get install ...") gcc, make, 'g++', cmake,
git, build-essential, xz-utils. For Net Core, follow the instructions at
https://www.microsoft.com/net/core#linuxubuntu 

~~~~
cd .swig
cd ..
bash -c ./generate.sh
cd llvm
.\build.sh
cd ..
cd swigged.llvm
dotnet restore
dotnet build
cd ..
cd swigged.llvm.native
./build.sh
cd ..
~~~~

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

Note, this project should not be confuse with another "LLVM.NET" library (aka "LLVM by Lost"),
https://bitbucket.org/lost/llvm.net/wiki/Home , http://www.nuget.org/packages/LLVM.NativeLibrary/ , which seems to be a wrapper for some LLVM DLLs built within the project.
It hasn't been updated in several years, so I don't think this project is active anymore.
