#!/bin/sh
# Make for OPENH264
# Copyright (c) 2015 Zhao Xin (https://github.com/xinyzhao/)

#DIR=${1:-lib}
DIR=build-ios
rm -rf ./$DIR

LIPO="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/lipo"
ARCHS=("arm64" "armv7" "i386" "x86_64")
FILES=("libcommon.a" "libdecoder.a" "libencoder.a" "libopenh264.a" "libprocessing.a")
BUILD=$DIR/build

# Build Lib
for arch in ${ARCHS[@]}
do
	make clean
	make OS=ios ARCH=$arch
	mkdir -p ./$BUILD/$arch
	for file in ${FILES[@]}
	do
		mv ./$file ./$BUILD/$arch/
	done
done

# Marge Lib
LIB=$DIR/lib
mkdir -p ./$LIB
for file in ${FILES[@]}
do
	# args
	for arch in ${ARCHS[@]}
	do
		arch_file=./$BUILD/$arch/$file
		args="$args -arch $arch $arch_file"
	done
	# lipo
	${LIPO} -create $args -output ./$LIB/$file
	unset args
done

# Copy Include
INC=$DIR/include
mkdir -p ./$INC
cp -r ./codec/api/svc/*.h ./$INC/

# Done
echo "The OPENH264 building completed."