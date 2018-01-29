
Get-Date

msbuild swigged-llvm\swigged.llvm.sln /p:Configuration=Release /p:Platform="Any CPU"

Get-Date

cd swigged-llvm\swigged.llvm.native
.\build.ps1

Get-Date