# BUILD SCRIPT FOR WINDOWS TARGETS

rm x64-Release.tar -Force -erroraction 'silentlycontinue'
rm x64-Release.tar.gz -Force -erroraction 'silentlycontinue'
cd x64-Release

# If all works, then clean up everything, and create .tar.gz file.
rm Release\bin\BuildingAJIT*.exe -Force -erroraction 'silentlycontinue'
rm Release\bin\Fibonacci.exe -Force -erroraction 'silentlycontinue'
rm Release\bin\HowToUseJIT.exe -Force -erroraction 'silentlycontinue'
rm Release\bin\Kaleidoscope-*.exe -Force -erroraction 'silentlycontinue'
rm Release\bin\llvm-c-test.exe -Force -erroraction 'silentlycontinue'
rm Release\bin\llvm-lto*.exe -Force -erroraction 'silentlycontinue'
rm tools -Recurse -Force -erroraction 'silentlycontinue'
rm lib\Analysis -Recurse -Force -erroraction 'silentlycontinue'
rm lib\AsmParser -Recurse -Force -erroraction 'silentlycontinue'
rm lib\BinaryFormat -Recurse -Force -erroraction 'silentlycontinue'
rm lib\Bitcode -Recurse -Force -erroraction 'silentlycontinue'
rm lib\CodeGen -Recurse -Force -erroraction 'silentlycontinue'
rm lib\DebugInfo -Recurse -Force -erroraction 'silentlycontinue'
rm lib\Demangle -Recurse -Force -erroraction 'silentlycontinue'
rm lib\ExecutionEngine -Recurse -Force -erroraction 'silentlycontinue'
rm lib\Fuzzer -Recurse -Force -erroraction 'silentlycontinue'
rm lib\IR -Recurse -Force -erroraction 'silentlycontinue'
rm lib\IRReader -Recurse -Force -erroraction 'silentlycontinue'
rm lib\LineEditor -Recurse -Force -erroraction 'silentlycontinue'
rm lib\Linker -Recurse -Force -erroraction 'silentlycontinue'
rm lib\LTO -Recurse -Force -erroraction 'silentlycontinue'
rm lib\MC -Recurse -Force -erroraction 'silentlycontinue'
rm lib\Object -Recurse -Force -erroraction 'silentlycontinue'
rm lib\ObjectYAML -Recurse -Force -erroraction 'silentlycontinue'
rm lib\Option -Recurse -Force -erroraction 'silentlycontinue'
rm lib\Passes -Recurse -Force -erroraction 'silentlycontinue'
rm lib\ProfileData -Recurse -Force -erroraction 'silentlycontinue'
rm lib\Support -Recurse -Force -erroraction 'silentlycontinue'
rm lib\TableGen -Recurse -Force -erroraction 'silentlycontinue'
rm lib\Target -Recurse -Force -erroraction 'silentlycontinue'
rm lib\Testing -Recurse -Force -erroraction 'silentlycontinue'
rm lib\ToolDrivers -Recurse -Force -erroraction 'silentlycontinue'
rm lib\Transforms -Recurse -Force -erroraction 'silentlycontinue'
rm lib\XRay -Recurse -Force -erroraction 'silentlycontinue'
rm examples -Recurse -Force -erroraction 'silentlycontinue'
rm Debug -Recurse -Force -erroraction 'silentlycontinue'
rm docs -Recurse -Force -erroraction 'silentlycontinue'
rm test -Recurse -Force -erroraction 'silentlycontinue'
rm unittests -Recurse -Force -erroraction 'silentlycontinue'
rm utils -Recurse -Force -erroraction 'silentlycontinue'
cd ..
bash -lc "mkdir x64-Release/llvm"
bash -lc "cp -r ./llvm/include x64-Release/llvm"
bash -lc "pwd"
bash -lc "ls -l x64-Release"
bash -lc "tar cvf x64-Release.tar x64-Release"
bash -lc "gzip -9 x64-Release.tar"
