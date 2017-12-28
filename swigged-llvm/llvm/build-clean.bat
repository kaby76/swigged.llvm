
@echo off
echo %VSINSTALLDIR%
if defined VSINSTALLDIR (
echo VSINSTALLDIR is defined.
)else (
echo VSINSTALLDIR is NOT defined.
exit /b 1
)
@echo on

bash -c "rm -rf x86-Debug"
bash -c "rm -rf x86-Release"
bash -c "rm -rf x64-Debug"
bash -c "rm -rf x64-Release"

