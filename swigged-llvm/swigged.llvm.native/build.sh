
bash -c "rm -rf ubuntu.16.04-Debug"
bash -c "rm -rf ubuntu.16.04-Release"
bash -c "rm -rf android.arm64-Release"

mkdir ubuntu.16.04-Debug
mkdir ubuntu.16.04-Release
mkdir android.arm64-Release

cd ubuntu.16.04-Debug
cmake -DCMAKE_BUILD_TYPE=Debug -DLLVM_TARGETS_TO_BUILD=X86 -DLLVM_DIR=`pwd`"/../../llvm/ubuntu-16.04-Debug/lib/cmake/llvm"  ..
cd ..

cd ubuntu.16.04-Release
cmake -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD=X86 -DLLVM_DIR=`pwd`"/../../llvm/ubuntu-16.04-Release/lib/cmake/llvm"  ..
cd ..

cd ubuntu.16.04-Debug
make
cd ..

cd ubuntu.16.04-Release
make
cd ..

export PATH="$PATH":/home/ken/Android/Sdk/cmake/3.6.3155560/bin
cd android.arm64-Release
cmake ..   -DCMAKE_ANDROID_ARCH_ABI=armeabi-v7a   -DANDROID_NDK=/home/ken/Android/Sdk/ndk-bundle   -DCMAKE_BUILD_TYPE=Release     -DCMAKE_TOOLCHAIN_FILE=/home/ken/Android/Sdk/ndk-bundle/build/cmake/android.toolchain.cmake   -DANDROID_NATIVE_API_LEVEL=23   -DANDROID_TOOLCHAIN=clang   -DLLVM_TARGETS_TO_BUILD=ARM -DLLVM_DIR=`pwd`"/../../llvm/android.arm64-Release/lib/cmake/llvm/"
make -k
cd ..
