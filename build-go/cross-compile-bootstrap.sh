#!/usr/bin/env bash

wget "https://go.dev/dl/go1.19.src.tar.gz"
tar -xf go1.19.src.tar.gz
cd go/src

# Integrate fix to support SV57 mode
wget "https://go-review.googlesource.com/changes/go~409055/revisions/6/files/src%2Fruntime%2Flfstack_64bit.go/download" -O lfstack_fix_sv57.zip
unzip -p lfstack_fix_sv57.zip > lfstack_64bit.go
mv lfstack_64bit.go runtime/lfstack_64bit.go

# Launch build from source
GOOS=linux GOARCH=riscv64 ./bootstrap.bash

cd ../..
mv go go1.19-src
mv go-linux-riscv64-bootstrap go
tar -cJf go1.19.sv57-fix.linux-riscv64.tar.xz go/
