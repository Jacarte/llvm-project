BUILD_OUT=$1
VARIANTS="c1.c c2.c c3.c c4.c"
O="-O1"
for v in $VARIANTS
do
    $BUILD_OUT/bin/clang -c -emit-llvm $O -o out/$v.bc --target=wasm32-unknonwn-unknown variants/$v || exit 1
    $BUILD_OUT/bin/clang -c -emit-llvm $O -S -o out/$v.ll --target=wasm32-unknonwn-unknown variants/$v || exit 1
    $BUILD_OUT/bin/wasm-ld --export-all --no-entry --allow-undefined out/$v.bc -o out/$v.wasm 2> /dev/null
    $WASM2WAT out/$v.wasm -o out/$v.wat
    md5sum out/$v.wat | awk '{print $1}'
done
