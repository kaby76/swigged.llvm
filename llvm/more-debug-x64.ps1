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
Invoke-CmdScript "%VSINSTALLDIR%\VC\Auxiliary\Build\vcvarsall.bat" x64
cd x64-Debug
msbuild LLVM.sln /p:Configuration=Debug /p:Platform=x64

exit 0
