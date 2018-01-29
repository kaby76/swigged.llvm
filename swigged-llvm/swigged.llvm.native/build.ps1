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

rm x64-Release -Recurse -Force

mkdir x64-Release
Invoke-CmdScript "%VSINSTALLDIR%\VC\Auxiliary\Build\vcvarsall.bat" x64
cd x64-Release
cmake "-DLLVM_DIR=%CD%\..\..\llvm\x64-Release\lib\cmake\llvm"    -G "Visual Studio 15 2017 Win64" ..
msbuild swigged-llvm-native.sln /p:Configuration=Release /p:Platform=x64
cd ..
