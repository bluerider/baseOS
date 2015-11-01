#!/bin/bash

# Overlay the user-crypt-img onto the squashfs-root directory

## open the user-crypt img
cryptsetup open user-crypt.img user-crypt.img

## make needed overlay directories
mkdir baseOS-work
mkdir baseOS-root

## overlay user-crypt.img with baseOS-squashfs-root
mount baseOS-root -t overlay -o lowerdir=baseOS-squashed-root,upperdir=/dev/mapper/user-crypt,workdir=baseOS-work baseOS-root

## chroot into the new directory
## check if auto configuration was passsed
if [ ! "$1" = "auto" ]; then
   arch-chroot baseOS-root
   umount baseOS-root
   rm -r baseOS-work baseOS-root
   cryptsetup close user-crypt.img
fi