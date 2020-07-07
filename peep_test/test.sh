dir=$(pwd)/..
llvm_bin=$dir/llvm-Release-install/bin

$llvm_bin/clang -c -S --target=wasm32-unknown-unknown -emit-llvm -O1 $1 -o $1.ll
$llvm_bin/clang -c --target=wasm32-unknown-unknown -emit-llvm -O1 $1 -o $1.bc

$llvm_bin/wasm-ld -lto-O0 -O0 --allow-undefined --export-all --no-entry $1.bc -o $1.wasm
wasm2wat $1.wasm -o $1.wat