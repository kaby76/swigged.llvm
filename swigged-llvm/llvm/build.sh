
bash -c "rm -rf ubuntu-16.04-Debug"
bash -c "rm -rf ubuntu-16.04-Release"
bash -c "rm -rf android.arm64-Release"

mkdir ubuntu-16.04-Debug
mkdir ubuntu-16.04-Release
mkdir android.arm64-Release

cd ubuntu-16.04-Debug
cmake -DCMAKE_BUILD_TYPE=Debug -DLLVM_TARGETS_TO_BUILD=X86 ../llvm
cd ..

cd ubuntu-16.04-Release
cmake -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD=X86 ../llvm
cd ..

cd  android.arm64-Release
cmake .. -DCMAKE_ANDROID_NDK=/home/ken/android-ndk-r14b -DCMAKE_SYSTEM_NAME=Android -DCMAKE_SYSTEM_VERSION=21 -DCMAKE_ANDROID_ARCH_ABI=arm64-v8a -DCMAKE_ANDROID_STL_TYPE=gnustl_static -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD=ARM -DLLVM_DIR=`pwd`"/../../llvm/android/lib/cmake/llvm"
cd ..

cd ubuntu-16.04-Debug
make
cd ..

cd ubuntu-16.04-Release
make
cd ..

cd  android.arm64-Release
make
cd ..
