#!/bin/bash

set -e

print()
{
    echo -e "\e[1;31m$*\e[0m"	
}

print "Install dependencies"
sudo apt install bc \
            bison \
            ca-certificates \
            ccache \
            clang \
            cmake \
            curl \
            file \
            flex \
            gcc \
            g++ \
            git \
            libelf-dev \
            libssl-dev \
            make \
            ninja-build \
            python3 \
            texinfo \
            u-boot-tools \
	    lld \
            zlib1g-dev

print "Start building LLVM"
./build-llvm.py \
	--assertions \
	--build-type "Release" \
	--clang-vendor "AtomSand-$(date +%D)" \
	--incremental \
	--lto "thin" \
	--targets "AArch64;ARM" \
	--use-good-revision \
 	--additional-build-arguments "CLANG_REPOSITORY_STRING=GitHub.com/AtomSand"

print "Start building binutils"
./build-binutils.py \
	--targets arm aarch64
