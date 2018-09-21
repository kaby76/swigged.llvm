# BUILD SCRIPT FOR UBUNTU AND ANDROID TARGETS
# RUN ON UBUNTU
set -e
date
cd ../llvm
rm -rf llvm
rm -rf ubuntu-16.04-Release
rm -rf ubuntu-16.04-Release.tar
rm -rf ubuntu-16.04-Release.tar.gz
wget https://github.com/kaby76/llvm/releases/download/v70.0.1/ubuntu-16.04-Release.tar.gz
pwd
gzip -d ubuntu-16.04-Release.tar.gz
tar -xvf ubuntu-16.04-Release.tar
rm -rf ubuntu-16.04-Release.tar
cd ../swigged.llvm.native
echo "Cmake/make of ubuntu-16.04-Release"
rm -rf ubuntu-16.04-Release
mkdir ubuntu-16.04-Release
cd ubuntu-16.04-Release
cmake  -MORELIBS="AArch64AsmParser AArch64AsmPrinter AArch64CodeGen AArch64Desc AArch64Disassembler AArch64Info AArch64Utils" -DCMAKE_BUILD_TYPE=Release -DLLVM_DIR=`pwd`"/../../llvm/ubuntu-16.04-Release/lib/cmake/llvm"  ..
make
cd ..

echo "Cannot build LLVM for Android Arm, so passing for now."
exit 0

