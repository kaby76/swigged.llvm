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
Invoke-CmdScript "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvarsall.bat" x64
msbuild swigged-llvm\swigged.llvm.sln /p:Configuration=Release /p:Platform="Any CPU"
Get-Date
cd swigged-llvm\swigged.llvm.native
.\build.ps1
Get-Date
