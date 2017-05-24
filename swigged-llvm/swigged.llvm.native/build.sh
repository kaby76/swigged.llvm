
export OLDPATH="$PATH"
export PATH="/home/ken/cmake-3.8.1-Linux-x86_64/bin:$OLDPATH"

echo ""
echo "Cmake/make of ubuntu-16.04-Debug"
bash -c "rm -rf ubuntu-16.04-Debug"
mkdir ubuntu-16.04-Debug
cd ubuntu-16.04-Debug
cmake -DCMAKE_BUILD_TYPE=Debug -DLLVM_BUILD_TARGETS=X86 -DLLVM_TARGETS_TO_BUILD=X86 -DLLVM_DIR=`pwd`"/../../llvm/ubuntu-16.04-Debug/lib/cmake/llvm"  ..
make
cd ..

echo ""
echo "Cmake/make of ubuntu-16.04-Release"
bash -c "rm -rf ubuntu-16.04-Release"
mkdir ubuntu-16.04-Release
cd ubuntu-16.04-Release
cmake -DCMAKE_BUILD_TYPE=Release -DLLVM_BUILD_TARGETS=X86 -DLLVM_TARGETS_TO_BUILD=X86 -DLLVM_DIR=`pwd`"/../../llvm/ubuntu-16.04-Release/lib/cmake/llvm"  ..
make
cd ..


#####################################################
#
# List of all ABIs for Android here:
# https://developer.android.com/ndk/guides/abis.html
#
#####################################################

echo ""
echo "Cmake/make of android-armeabi-Release"
export PATH="/home/ken/Android/Sdk/cmake/3.6.3155560/bin:$OLDPATH"
bash -c "rm -rf android-armeabi-Release"
mkdir android-armeabi-Release
cd android-armeabi-Release
cmake --version
cmake .. \
   -DMORELIBS=ARM \
   -DLLVM_BUILD_TARGETS=ARM \
   -DANDROID_NDK=/home/ken/Android/Sdk/ndk-bundle \
   -DANDROID_NATIVE_API_LEVEL=23 \
   -DANDROID_TOOLCHAIN=clang \
   -DANDROID_ABI=armeabi \
   -DCMAKE_CXX_FLAGS_RELEASE="-g0" \
   -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON \
   -DCMAKE_ANDROID_ARCH_ABI=armeabi \
   -DCMAKE_ANDROID_ARCH=armeabi \
   -DCMAKE_ASM_FLAGS_RELWITHDEBINFO="-O2 -g0 -DNDEBUG" \
   -DCMAKE_CXX_FLAGS_RELWITHDEBINFO="-O2 -g0 -DNDEBUG" \
   -DCMAKE_C_FLAGS_RELWITHDEBINFO="-O2 -g0 -DNDEBUG" \
   -DCMAKE_CXX_FLAGS_DEBUG=""  \
   -DCMAKE_BUILD_TYPE=Release \
   -DCMAKE_TOOLCHAIN_FILE=/home/ken/Android/Sdk/ndk-bundle/build/cmake/android.toolchain.cmake \
   -DLLVM_TARGETS_TO_BUILD=ARM \
   -DLLVM_DIR=`pwd`"/../../llvm/android-armeabi-Release/lib/cmake/llvm/"
make -k
# Note2: There is a bug in cmake for Android--the -g option is always specified.
# We cannot turn it off, so use strip to clean it up.
/home/ken/Android/Sdk/ndk-bundle/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/arm-linux-androideabi/bin/strip -S swigged-llvm-native.so
cd ..


echo ""
echo "Cmake/make of android-x86-Release"
export PATH="/home/ken/Android/Sdk/cmake/3.6.3155560/bin:$OLDPATH"
bash -c "rm -rf android-x86-Release"
mkdir android-x86-Release
cd android-x86-Release
cmake --version
cmake .. \
   -DMORELIBS="" \
   -DLLVM_BUILD_TARGETS=x86 \
   -DANDROID_NDK=/home/ken/Android/Sdk/ndk-bundle \
   -DANDROID_NATIVE_API_LEVEL=23 \
   -DANDROID_TOOLCHAIN=clang \
   -DANDROID_ABI=x86 \
   -DCMAKE_CXX_FLAGS_RELEASE="-g0" \
   -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON \
   -DCMAKE_ANDROID_ARCH_ABI=x86 \
   -DCMAKE_ANDROID_ARCH=x86 \
   -DCMAKE_ASM_FLAGS_RELWITHDEBINFO="-O2 -g0 -DNDEBUG" \
   -DCMAKE_CXX_FLAGS_RELWITHDEBINFO="-O2 -g0 -DNDEBUG" \
   -DCMAKE_C_FLAGS_RELWITHDEBINFO="-O2 -g0 -DNDEBUG" \
   -DCMAKE_CXX_FLAGS_DEBUG=""  \
   -DCMAKE_BUILD_TYPE=Release \
   -DCMAKE_TOOLCHAIN_FILE=/home/ken/Android/Sdk/ndk-bundle/build/cmake/android.toolchain.cmake \
   -DLLVM_TARGETS_TO_BUILD=X86 \
   -DLLVM_DIR=`pwd`"/../../llvm/android-x86-Release/lib/cmake/llvm/"
make -k
# Note2: There is a bug in cmake for Android--the -g option is always specified.
# We cannot turn it off, so use strip to clean it up.
/home/ken/Android/Sdk/ndk-bundle/toolchains/x86_64-4.9/prebuilt/linux-x86_64/x86_64-linux-android/bin/strip -S swigged-llvm-native.so
cd ..
