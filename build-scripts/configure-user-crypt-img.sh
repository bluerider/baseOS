#!/bin/bash

# Overlay the user-crypt-img onto the squashfs-root directory

## open the user-crypt img
cryptsetup open user-crypt.img user-crypt.img

## set up encrypted img
mkdir -p baseOS-crypt
mount /dev/mapper/user-crypt.img baseOS-crypt
mkdir baseOS-crypt/{work,upper}

## make needed overlay directories
mkdir baseOS-root

## overlay user-crypt.img with baseOS-squashfs-root
mount baseOS-root -t overlay -o lowerdir=baseOS-squashed-root,upperdir=baseOS-crypt/upper,workdir=baseOS-crypt/work

## chroot into the new directory
## check if auto configuration was passsed
if [ ! "$1" = "auto" ]; then
   arch-chroot baseOS-root
   umount baseOS-root
   rm -r baseOS-crypt/work
   mv baseOS-crypt/upper/* baseOS-crypt
   rm -r baseOS-crypt/upper
   rm -r baseOS-work baseOS-root
   cryptsetup close user-crypt.img
fi
