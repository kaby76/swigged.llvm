# BUILD SCRIPT FOR WINDOWS TARGETS

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

$ErrorActionPreference = "Stop"
$x = $(where.exe msbuild | select -first 1 | %{ $_ -replace ".*2017\\","" } | %{ $_ -replace "\\.*","" })
Invoke-CmdScript "C:\Program Files (x86)\Microsoft Visual Studio\2017\$x\VC\Auxiliary\Build\vcvarsall.bat" x64
Get-Date
cd ..\llvm
rm llvm -Recurse -Force -erroraction 'silentlycontinue'
rm x64-Release -Recurse -Force -erroraction 'silentlycontinue'
rm x64-Release.tar -Force -erroraction 'silentlycontinue'
rm x64-Release.tar.gz -Force -erroraction 'silentlycontinue'
[Net.ServicePointManager]::SecurityProtocol = 
  [Net.SecurityProtocolType]::Tls12 -bor `
  [Net.SecurityProtocolType]::Tls11 -bor `
  [Net.SecurityProtocolType]::Tls
curl -O x64-Release.tar.gz https://github.com/kaby76/llvm/releases/download/v6.0.4/x64-Release.tar.gz
bash -lc "pwd"
bash -lc "gzip -d x64-Release.tar.gz"
bash -lc "tar -xvf x64-Release.tar"
rm x64-Release.tar -Force -erroraction 'silentlycontinue'
cd ..\swigged.llvm.native
rm x64-Release -Recurse -Force -erroraction 'silentlycontinue'
msbuild swigged.llvm.native.sln /p:Configuration=Release /p:Platform=x64
