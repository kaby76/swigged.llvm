#
# Build script for Windows native and Net Standard libraries of Swigged.LLVM.
# Invokes a Cmd.exe shell script and updates the environment.

function Invoke-CmdScript {
  param(
    [String] $scriptName
  )
  $cmdLine = """$scriptName"" $args & set"
  & $Env:SystemRoot\system32\cmd.exe /c $cmdLine |
  select-string '^([^=]*)=(.*)$' | foreach-object {
    $varName = $_.Matches[0].Groups[1].Value
    $varValue = $_.Matches[0].Groups[2].Value
    set-item Env:$varName $varValue
  }
}

Get-Date
$ErrorActionPreference = "Stop"
$x = $(where.exe msbuild | select -first 1 | %{ $_ -replace ".*2017\\","" } | %{ $_ -replace "\\.*","" })
Invoke-CmdScript "C:\Program Files (x86)\Microsoft Visual Studio\2017\$x\VC\Auxiliary\Build\vcvarsall.bat" x64
cd swigged-llvm
dotnet restore
dotnet build
# msbuild swigged-llvm\swigged.llvm.sln /p:Configuration=Release /p:Platform="Any CPU"
Get-Date
cd swigged.llvm.native
.\build.ps1
Get-Date
