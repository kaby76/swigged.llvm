
echo "Cmake/make of ubuntu-16.04-Release"
rm -rf ubuntu-16.04-Release
rm -f ubuntu-16.04-Release.tar
rm -f ubuntu-16.04-Release.tar.gz
mkdir ubuntu-16.04-Release
cd ubuntu-16.04-Release
cmake -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON -DCMAKE_ASM_FLAGS_RELWITHDEBINFO="-O2 -g0 -DNDEBUG" -DCMAKE_CXX_FLAGS_RELWITHDEBINFO="-O2 -g0 -DNDEBUG" -DCMAKE_C_FLAGS_RELWITHDEBINFO="-O2 -g0 -DNDEBUG" -DCMAKE_BUILD_TYPE=Release ../llvm
make VERBOSE=1
# If all works, then clean up everything, and create .tar.gz file.
rm -f Release\bin\BuildingAJIT*
rm -f Release\bin\Fibonacci
rm -rf Release\bin\HowToUseJIT
rm -rf Release\bin\Kaleidoscope-*
rm -rf Release\bin\llvm-c-test
rm -rf Release\bin\llvm-lto*
rm -rf tools
rm -rf lib\Analysis
rm -rf lib\AsmParser
rm -rf lib\BinaryFormat
rm -rf lib\Bitcode
rm -rf lib\CodeGen
rm -rf lib\DebugInfo
rm -rf lib\Demangle
rm -rf lib\ExecutionEngine
rm -rf lib\Fuzzer
rm -rf lib\IR
rm -rf lib\IRReader
rm -rf lib\LineEditor
rm -rf lib\Linker
rm -rf lib\LTO
rm -rf lib\MC
rm -rf lib\Object
rm -rf lib\ObjectYAML
rm -rf lib\Option
rm -rf lib\Passes
rm -rf lib\ProfileData
rm -rf lib\Support
rm -rf lib\TableGen
rm -rf lib\Target
rm -rf lib\Testing
rm -rf lib\ToolDrivers
rm -rf lib\Transforms
rm -rf lib\XRay
rm -rf examples
rm -rf Debug
rm -rf docs
rm -rf test
rm -rf unittests
rm -rf utils
cd ..
mkdir x64-Release/llvm
cp -r ./llvm/include ubuntu-16.04-Release/llvm
pwd
ls -l ubuntu-16.04-Release
tar cvf ubuntu-16.04-Release.tar ubuntu-16.04-Release
gzip -9 ubuntu-16.04-Release.tar

echo "Cannot build LLVM for Android Arm, so passing for now."
