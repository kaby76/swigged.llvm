
@echo off
echo %VSINSTALLDIR%
if defined VSINSTALLDIR (
echo VSINSTALLDIR is defined.
)else (
echo VSINSTALLDIR is NOT defined.
exit /b 1
)
@echo on

mkdir x86-Debug

call "%VSINSTALLDIR%\VC\Auxiliary\Build\vcvarsall.bat" x86
cd x86-Debug
cmake -DCMAKE_BUILD_TYPE=Debug -G "Visual Studio 15 2017" ..\llvm
msbuild LLVM.sln /p:Configuration=Debug /p:Platform=Win32
cd ..
