
@echo off
echo %VSINSTALLDIR%
if defined VSINSTALLDIR (
echo VSINSTALLDIR is defined.
)else (
echo VSINSTALLDIR is NOT defined.
exit /b 1
)
@echo on

mkdir x86-Release

call "%VSINSTALLDIR%\VC\Auxiliary\Build\vcvarsall.bat" x86
cd x86-Release
cmake -DCMAKE_BUILD_TYPE=Release -G "Visual Studio 15 2017" ..\llvm
msbuild LLVM.sln /p:Configuration=Release /p:Platform=Win32
cd ..
