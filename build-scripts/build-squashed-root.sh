#!/bin/bash

# create the read only squashed root


## set the user specified packages from ../squashed-packages.txt
packages=()
while read -r; do
  packages+=($REPLY)
done < ../squashed-packages.txt

## requires arch-install-scripts pacman
## install arch linux to a directory
mkdir baseOS-squashed-root
pacstrap baseOS-squashed-root base ${packages[@]}
mksquashfs baseOS-squashed-root baseOS.sqsh
