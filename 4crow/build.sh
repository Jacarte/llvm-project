llvm_build_type=Release
llvm_srcdir=$(pwd)/..
llvm_builddir=$(pwd)/build/llvm-${llvm_build_type}-build
llvm_installdir=$(pwd)/build/llvm-${llvm_build_type}-install

mkdir -p $llvm_srcdir

mkdir -p $llvm_builddir
mkdir -p $llvm_installdir
ncpus=10
cmake_flags="-DCMAKE_INSTALL_PREFIX=$llvm_installdir -DLLVM_ENABLE_ASSERTIONS=ON -DLLVM_FORCE_ENABLE_STATS=ON -DCMAKE_BUILD_TYPE=$llvm_build_type -DLLVM_ENABLE_Z3_SOLVER=OFF -DLLVM_TARGETS_TO_BUILD=WebAssembly  -DLLVM_ENABLE_PROJECTS=\'clang-tools-extra;lld;llvm;clang;compiler-rt;llvm-config;\'"

if [ -n "`which ninja`" ] ; then
  (cd $llvm_builddir && cmake ${llvm_srcdir}/llvm -G Ninja $cmake_flags -DCMAKE_CXX_FLAGS="-DDISABLE_WRONG_OPTIMIZATIONS_DEFAULT_VALUE=true -DDISABLE_PEEPHOLES_DEFAULT_VALUE=true" "$@")
  ninja -C $llvm_builddir -j$ncpus 
  ninja -C $llvm_builddir -j$ncpus install 
else
  (cd $llvm_builddir && cmake $cmake_flags -DCMAKE_CXX_FLAGS="-DDISABLE_WRONG_OPTIMIZATIONS_DEFAULT_VALUE=true -DDISABLE_PEEPHOLES_DEFAULT_VALUE=true" "$@")
  make -C $llvm_builddir -j $ncpus 
  make -C $llvm_builddir -j $ncpus install
fi
