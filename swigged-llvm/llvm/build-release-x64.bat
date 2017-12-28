
@echo off
echo %VSINSTALLDIR%
if defined VSINSTALLDIR (
echo VSINSTALLDIR is defined.
)else (
echo VSINSTALLDIR is NOT defined.
exit /b 1
)
@echo on

mkdir x64-Release

call "%VSINSTALLDIR%\VC\Auxiliary\Build\vcvarsall.bat" x64
cd x64-Release
cmake -DCMAKE_BUILD_TYPE=Release -G "Visual Studio 15 2017 Win64" ..\llvm
msbuild LLVM.sln /p:Configuration=Release /p:Platform=x64
cd ..
