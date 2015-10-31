#!/bin/bash

# Run this script with Arch linux's pacman installed
# Requires arch-install-scripts squashfs-tools grub parallel

## build scripts to use, will be sourced in order and in parallel
buildscripts=('build-img.sh' 'build-squashed-root.sh' 'build-user-crypt-img.sh')


serial-build() {
## source build-scripts
for a in ${buildscripts[@]}; do
  . "build-scripts/$a"
done
}

parallel-build() {
## run build.parallel
./build-parallel ${buildscripts[@]}
}

if [ "$1" == "-p" ]; then
   parralel-build
 else
   serial-build
fi
