#!/bin/bash

# Overlay the user-crypt-img onto the squashfs-root directory

## open the user-crypt img
cryptsetup open user-crypt.img user-crypt

## make needed overlay directories
mkdir baseOS-work
mkdir baseOS-root

## overlay user-crypt.img with baseOS-squashfs-root
mount baseOS-root -o lowerdir=baseOS-squashed-root,upperdir=/dev/mapper/user-crypt,workdir=baseOS-work baseOS-root

## chroot into the new directory
arch-chroot baseOS-root
