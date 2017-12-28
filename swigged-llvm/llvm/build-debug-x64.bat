
@echo off
echo %VSINSTALLDIR%
if defined VSINSTALLDIR (
echo VSINSTALLDIR is defined.
)else (
echo VSINSTALLDIR is NOT defined.
exit /b 1
)
@echo on

mkdir x64-Debug

call "%VSINSTALLDIR%\VC\Auxiliary\Build\vcvarsall.bat" x64
cd x64-Debug
cmake -DCMAKE_BUILD_TYPE=Debug -G "Visual Studio 15 2017 Win64" ..\llvm
msbuild LLVM.sln /p:Configuration=Debug /p:Platform=x64
cd ..
