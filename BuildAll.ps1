
msbuild swigged-llvm\swigged.llvm.sln /p:Configuration=Release /p:Platform="Any CPU"
cd swigged-llvm\swigged.llvm.native
.\build.ps1

