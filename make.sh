llvm_build_type=Release
llvm_srcdir=$(pwd)
llvm_builddir=$(pwd)/llvm-${llvm_build_type}-build
llvm_installdir=$(pwd)/llvm-${llvm_build_type}-install
ncpus=4

make -C $llvm_builddir -j$ncpus
make -C $llvm_builddir -j$ncpus install