
bash -c "rm -rf ubuntu.16.04-Debug"
bash -c "rm -rf ubuntu.16.04-Release"

mkdir ubuntu.16.04-Debug
mkdir ubuntu.16.04-Release

cd ubuntu.16.04-Debug
cmake -DCMAKE_BUILD_TYPE=Debug "-DLLVM_DIR=`pwd`/../../llvm/ubuntu.16.04-Debug/lib/cmake/llvm" -DLLVM_TARGETS_TO_BUILD=X86  ..
cd ..

cd ubuntu.16.04-Release
cmake -DCMAKE_BUILD_TYPE=Release "-DLLVM_DIR=`pwd`/../../llvm/ubuntu.16.04-Release/lib/cmake/llvm" -DLLVM_TARGETS_TO_BUILD=X86 ..
cd ..

cd ubuntu.16.04-Debug
make
cd ..

cd ubuntu.16.04-Release
make
cd ..
