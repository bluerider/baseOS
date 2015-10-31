#!/bin/bash

# build the usb img that will contain baseOS

## requires kpartx from multipath-tools
## requires sgdisk 
## requires dosfstools
fallocate -l 2G baseOS.img
sgdisk baseOS.img -n 1:-1M -N 0 -t 1:ef02

## format, mount partitions and install grub
## this parts gets dicey need the kpart loop device
## requires awk to resolve kpart device
loop_device="$(kpartx -l baseOS.img | tail -1 | awk '{print $4}')"
kpartx -a  baseOS.img

## create the FAT partition that will contain the img
mkfs.fat /dev/loop0p1
## get a temporary mount
temp_mount="$(mktemp -d)"
mount /dev/loop0p1 "$temp_mount"

## install grub
grub-install --target=i386-pc --boot-directory="$temp_mount/boot"
grub-install --target=x86_64-efi --efi-directory="$temp_mount" --bootloader-id=grub --boot-directory="$temp_mount/boot"

## install grub configuration files
## should get UUID of root device
## needs sed
cp "../grub/grub.cfg" "$temp_mount/boot/grub/"
## get the UUID of the FAT partition
fat_uuid=$(blkid /dev/loop0p2 | awk '{print $2}')
## add UUID to grub configuration file 
sed "s/UUID=XXXX-XXX/${fat_uuid//\"/}/g" "$temp_mount/boot/grub/grub.cfg"
