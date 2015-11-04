#!/bin/bash
# Make for PJSIP 2.4.5
# Copyright (c) 2015 Zhao Xin (https://github.com/xinyzhao/)

# Build the lib

echo "#define PJ_CONFIG_IPHONE 1" > ./pjlib/include/pj/config_site.h
echo "#include <pj/config_site_sample.h>" >> ./pjlib/include/pj/config_site.h

ARCH="-arch arm64" ./configure-iphone
make dep && make clean && make

ARCH="-arch armv7" ./configure-iphone
make dep && make clean && make

export DEVPATH=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer
ARCH="-arch i386" CFLAGS="-O2 -m32 -mios-simulator-version-min=5.0" LDFLAGS="-O2 -m32 -mios-simulator-version-min=5.0" ./configure-iphone
make dep && make clean && make
unset DEVPATH

export DEVPATH=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer
ARCH="-arch x86_64" CFLAGS="-O2 -m64 -mios-simulator-version-min=5.0" LDFLAGS="-O2 -m64 -mios-simulator-version-min=5.0" ./configure-iphone
make dep && make clean && make
unset DEVPATH

# Merge and copy the lib

DIR=${1:-lib}
rm -rf ./$DIR

#LIPO="/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/lipo"
LIPO="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/lipo"
ARCHS=("arm64" "armv7" "i386" "x86_64")
PARTS=("pjlib" "pjlib-util" "pjmedia" "pjnath" "pjsip" "third_party")
SUFFIX="apple-darwin_ios.a"

for part in ${PARTS[@]}
do
	mkdir -p ./$DIR/$part/lib
	# include
	cp -r ./$part/include ./$DIR/$part/
	# lib
	files=($(ls ./$part/lib/ | grep ${ARCHS[0]}))
	for file in ${files[@]}
	do
		# file
		suffix=-${ARCHS[0]}-$SUFFIX
		lib_name=${file%%${suffix}}
		lib_file=./$DIR/$part/lib/$lib_name.a
		echo "lib file: $lib_file"
		# args
		for arch in ${ARCHS[@]}
		do
			arch_file=./$part/lib/$lib_name-$arch-$SUFFIX
			args="$args -arch $arch $arch_file"
		done
		#echo $args
		# lipo
		${LIPO} $args -create -output $lib_file
		unset args
	done
done

echo "The PJSIP building completed."
