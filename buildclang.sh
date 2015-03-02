#!/bin/sh 

version=$1
if [ -z "$1"  ]
then
	echo "No argument supplied"
	version='trunk'
fi

echo "Download version $version"

#co llvm
echo "Checkout llvm"
svn co http://llvm.org/svn/llvm-project/llvm/$version llvm

#co clang
echo "Checkout clang"

cd llvm/tools
svn co http://llvm.org/svn/llvm-project/cfe/$version clang
cd ../..


#co extra clang tools
echo "Checkout extra clang tools"

cd llvm/tools/clang/tools
svn co http://llvm.org/svn/llvm-project/clang-tools-extra/$version extra
cd ../../../..

#co compiler-RT
echo "Checkout compiler-RT"

cd llvm/projects
svn co http://llvm.org/svn/llvm-project/compiler-rt/$version compiler-rt
cd ../..


#build
echo "Build optimized version"
mkdir build
cd build
../llvm/configure --enable-optimized
make -j8


