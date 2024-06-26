#!/bin/bash -e


# LLVM version: 15.0.0

ROOT=$(git rev-parse --show-toplevel)
git clone https://github.com/llvm/llvm-project.git
cd $ROOT/llvm/llvm-project && git checkout llvmorg-15.0.0

if [ ! -d "build" ]; then
  mkdir build
fi

cd build
cmake -DLLVM_TARGET_ARCH="ARM;X86;AArch64" -DLLVM_TARGETS_TO_BUILD="ARM;X86;AArch64" -DCMAKE_BUILD_TYPE=Release \
			-DLLVM_ENABLE_PROJECTS="clang" -G "Unix Makefiles" ../llvm
make -j8

if [ ! -d "$ROOT/llvm/llvm-project/prefix" ]; then
  mkdir $ROOT/llvm/llvm-project/prefix
fi

cmake -DCMAKE_INSTALL_PREFIX=$ROOT/llvm/llvm-project/prefix -P cmake_install.cmake
