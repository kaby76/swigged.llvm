
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
cmake .. -DMORELIBS=ARM -DLLVM_BUILD_TARGETS=ARM  -DCMAKE_ANDROID_ARCH_ABI=armeabi   -DANDROID_NDK=/home/ken/Android/Sdk/ndk-bundle   -DCMAKE_BUILD_TYPE=Release     -DCMAKE_TOOLCHAIN_FILE=/home/ken/Android/Sdk/ndk-bundle/build/cmake/android.toolchain.cmake   -DANDROID_NATIVE_API_LEVEL=23   -DANDROID_TOOLCHAIN=clang   -DLLVM_TARGETS_TO_BUILD=ARM -DLLVM_DIR=`pwd`"/../../llvm/android-arm64-Release/lib/cmake/llvm/"
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
cmake ..  -DLLVM_BUILD_TARGETS=x86  -DCMAKE_ANDROID_ARCH_ABI=x86   -DANDROID_NDK=/home/ken/Android/Sdk/ndk-bundle   -DCMAKE_BUILD_TYPE=Release     -DCMAKE_TOOLCHAIN_FILE=/home/ken/Android/Sdk/ndk-bundle/build/cmake/android.toolchain.cmake   -DANDROID_NATIVE_API_LEVEL=23   -DANDROID_TOOLCHAIN=clang   -DLLVM_TARGETS_TO_BUILD=X86 -DLLVM_DIR=`pwd`"/../../llvm/android-x86-Release/lib/cmake/llvm/"
make -k
# Note2: There is a bug in cmake for Android--the -g option is always specified.
# We cannot turn it off, so use strip to clean it up.
/home/ken/Android/Sdk/ndk-bundle/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/arm-linux-androideabi/bin/strip -S swigged-llvm-native.so
cd ..


#./Android/Sdk/ndk-bundle/toolchains/aarch64-linux-android-4.9/prebuilt/linux-x86_64/aarch64-linux-android/bin/strip
#./Android/Sdk/ndk-bundle/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/arm-linux-androideabi/bin/strip
#./Android/Sdk/ndk-bundle/toolchains/x86_64-4.9/prebuilt/linux-x86_64/x86_64-linux-android/bin/strip

cd ..
