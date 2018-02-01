# BUILD SCRIPT FOR WINDOWS TARGETS
$ErrorActionPreference = "Stop"

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
Get-Location
cd ..\llvm
rm x64-Release -Recurse -Force -erroraction 'silentlycontinue'
# curl -O x64-Release.tar.gz https://github.com/kaby76/llvm/releases/download/v6.0.0.2-alpha/x64-Release.tar.gz
bash -lc "pwd"
bash -lc "gzip -d x64-Release.tar.gz"
bash -lc "tar -xvf x64-Release.tar"
rm x64-Release.tar  -Force -erroraction 'silentlycontinue'
cd ..\swigged.llvm.native
rm x64-Release -Recurse -Force -erroraction 'silentlycontinue'
mkdir x64-Release
Invoke-CmdScript "%VSINSTALLDIR%\VC\Auxiliary\Build\vcvarsall.bat" x64
cd x64-Release
cmake "-DLLVM_DIR=%CD%\..\..\llvm\x64-Release\lib\cmake\llvm"    -G "Visual Studio 15 2017 Win64" ..
msbuild swigged-llvm-native.sln /p:Configuration=Release /p:Platform=x64
cd ..
