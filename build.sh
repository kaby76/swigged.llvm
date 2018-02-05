#
date
set -e
cd swigged-llvm
dotnet restore
dotnet build
date
cd swigged.llvm.native
.\build.ps1
date
