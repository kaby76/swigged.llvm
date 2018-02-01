# BUILD SCRIPT FOR WINDOWS TARGETS

rm x64-Release.tar -Force
rm x64-Release.tar.gz -Force
cd x64-Release

# If all works, then clean up everything, and create .tar.gz file.
rm Release\bin\BuildingAJIT*.exe -Force
rm Release\bin\Fibonacci.exe -Force
rm Release\bin\HowToUseJIT.exe -Force
rm Release\bin\Kaleidoscope-*.exe -Force
rm Release\bin\llvm-c-test.exe -Force
rm Release\bin\llvm-lto*.exe -Force

rm tools -Recurse -Force

rm lib\Analysis -Recurse -Force
rm lib\AsmParser -Recurse -Force
rm lib\BinaryFormat -Recurse -Force
rm lib\Bitcode -Recurse -Force
rm lib\CodeGen -Recurse -Force
rm lib\DebugInfo -Recurse -Force
rm lib\Demangle -Recurse -Force
rm lib\ExecutionEngine -Recurse -Force
rm lib\Fuzzer -Recurse -Force
rm lib\IR -Recurse -Force
rm lib\IRReader -Recurse -Force
rm lib\LineEditor -Recurse -Force
rm lib\Linker -Recurse -Force
rm lib\LTO -Recurse -Force
rm lib\MC -Recurse -Force
rm lib\Object -Recurse -Force
rm lib\ObjectYAML -Recurse -Force
rm lib\Option -Recurse -Force
rm lib\Passes -Recurse -Force
rm lib\ProfileData -Recurse -Force
rm lib\Support -Recurse -Force
rm lib\TableGen -Recurse -Force
rm lib\Target -Recurse -Force
rm lib\Testing -Recurse -Force
rm lib\ToolDrivers -Recurse -Force
rm lib\Transforms -Recurse -Force
rm lib\XRay -Recurse -Force
rm examples -Recurse -Force
rm Debug -Recurse -Force
rm docs -Recurse -Force
rm test -Recurse -Force
rm unittests -Recurse -Force
rm utils -Recurse -Force
cd ..
$ErrorActionPreference = "Stop"
bash -lc "pwd"
bash -lc "ls -l x64-Release"
bash -lc "tar cvf x64-Release.tar x64-Release"
bash -lc "gzip -9 x64-Release.tar"