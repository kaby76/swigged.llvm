
bash -c "rm -rf x86-Debug"
bash -c "rm -rf x86-Release"
bash -c "rm -rf x64-Debug"
bash -c "rm -rf x64-Release"

mkdir x86-Debug
mkdir x86-Release
mkdir x64-Debug
mkdir x64-Release

call "%VSINSTALLDIR%\VC\Auxiliary\Build\vcvarsall.bat" x86
cd x86-Debug
cmake -DCMAKE_BUILD_TYPE=Debug -DLLVM_TARGETS_TO_BUILD=X86 -G "Visual Studio 15 2017" ..\llvm
cd ..\x86-Release
cmake -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD=X86 -G "Visual Studio 15 2017" ..\llvm

call "%VSINSTALLDIR%\VC\Auxiliary\Build\vcvarsall.bat" x64
cd ..\x64-Debug
cmake -DCMAKE_BUILD_TYPE=Debug -DLLVM_TARGETS_TO_BUILD=X86 -G "Visual Studio 15 2017 Win64" ..\llvm
cd ..\x64-Release
cmake -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD=X86 -G "Visual Studio 15 2017 Win64" ..\llvm

cd ..

call "%VSINSTALLDIR%\VC\Auxiliary\Build\vcvarsall.bat" x86
cd x86-Debug
msbuild LLVM.sln /p:Configuration=Debug /p:Platform=Win32
cd ..\x86-Release
msbuild LLVM.sln /p:Configuration=Release /p:Platform=Win32


call "%VSINSTALLDIR%\VC\Auxiliary\Build\vcvarsall.bat" x64
cd ..\x64-Debug
msbuild LLVM.sln /p:Configuration=Debug /p:Platform=x64
cd ..\x64-Release
msbuild LLVM.sln /p:Configuration=Release /p:Platform=x64

cd ..
