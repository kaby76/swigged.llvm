
export OLDPATH="$PATH"
export PATH="$OLDPATH:/home/ken/cmake-3.8.1-Linux-x86_64/bin"

echo ""
echo "Cmake/make of ubuntu-16.04-Debug"
bash -c "rm -rf ubuntu-16.04-Debug"
mkdir ubuntu-16.04-Debug
cd ubuntu-16.04-Debug
cmake -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON -DCMAKE_BUILD_TYPE=Debug -DLLVM_TARGETS_TO_BUILD=X86 ../llvm
make VERBOSE=1
cd ..

echo ""
echo "Cmake/make of ubuntu-16.04-Release"
bash -c "rm -rf ubuntu-16.04-Release"
mkdir ubuntu-16.04-Release
cd ubuntu-16.04-Release
cmake -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON -DCMAKE_ASM_FLAGS_RELWITHDEBINFO="-O2 -g0 -DNDEBUG" -DCMAKE_CXX_FLAGS_RELWITHDEBINFO="-O2 -g0 -DNDEBUG" -DCMAKE_C_FLAGS_RELWITHDEBINFO="-O2 -g0 -DNDEBUG" -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD=X86 ../llvm
make VERBOSE=1
cd ..


#####################################################
#
# List of all ABIs for Android here:
# https://developer.android.com/ndk/guides/abis.html
#
#####################################################


echo ""
echo "Cmake/make of android-armeabi-Release"
bash -c "rm -rf android-armeabi-Release"
mkdir android-armeabi-Release
# https://developer.android.com/ndk/guides/cmake.html
# Make sure to install Android Studio, and with that, configure it to
# include NDK, cmake, ....
cd  android-armeabi-Release
export PATH="$OLDPATH":/home/ken/Android/Sdk/cmake/3.6.3155560/bin
cmake ../llvm -DCMAKE_CXX_FLAGS_RELEASE="-g0" -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON   -DCMAKE_ANDROID_ARCH_ABI=armeabi   -DANDROID_NDK=/home/ken/Android/Sdk/ndk-bundle -DCMAKE_ASM_FLAGS_RELWITHDEBINFO="-O2 -g0 -DNDEBUG" -DCMAKE_CXX_FLAGS_RELWITHDEBINFO="-O2 -g0 -DNDEBUG" -DCMAKE_C_FLAGS_RELWITHDEBINFO="-O2 -g0 -DNDEBUG" -DCMAKE_CXX_FLAGS_DEBUG=""  -DCMAKE_BUILD_TYPE=Release     -DCMAKE_TOOLCHAIN_FILE=/home/ken/Android/Sdk/ndk-bundle/build/cmake/android.toolchain.cmake   -DANDROID_NATIVE_API_LEVEL=23   -DANDROID_TOOLCHAIN=clang   -DLLVM_TARGETS_TO_BUILD=ARM

# Note, there is a bug in the make of LLVM. Make everything regardless of errors.
make VERBOSE=1 -k
cd ..


echo ""
echo "Cmake/make of android-x86-Release"
bash -c "rm -rf android-x86-Release"
mkdir android-x86-Release
# https://developer.android.com/ndk/guides/cmake.html
# Make sure to install Android Studio, and with that, configure it to
# include NDK, cmake, ....
cd  android-x86-Release
export PATH="$OLDPATH":/home/ken/Android/Sdk/cmake/3.6.3155560/bin
cmake ../llvm -DCMAKE_CXX_FLAGS_RELEASE="-g0" -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON   -DCMAKE_ANDROID_ARCH_ABI=x86   -DANDROID_NDK=/home/ken/Android/Sdk/ndk-bundle -DCMAKE_ASM_FLAGS_RELWITHDEBINFO="-O2 -g0 -DNDEBUG" -DCMAKE_CXX_FLAGS_RELWITHDEBINFO="-O2 -g0 -DNDEBUG" -DCMAKE_C_FLAGS_RELWITHDEBINFO="-O2 -g0 -DNDEBUG" -DCMAKE_CXX_FLAGS_DEBUG=""  -DCMAKE_BUILD_TYPE=Release     -DCMAKE_TOOLCHAIN_FILE=/home/ken/Android/Sdk/ndk-bundle/build/cmake/android.toolchain.cmake   -DANDROID_NATIVE_API_LEVEL=23   -DANDROID_TOOLCHAIN=clang   -DLLVM_TARGETS_TO_BUILD=X86

# Note, there is a bug in the make of LLVM. Make everything regardless of errors.
make VERBOSE=1 -k

# Note2: There is a bug in cmake for Android--the -g option is always specified.
# We cannot turn it off, so use strip to clean it up.

/home/ken/Android/Sdk/ndk-bundle/toolchains/x86_64-4.9/prebuilt/linux-x86_64/x86_64-linux-android/bin/strip -S swigged-llvm-native.so

cd ..
