#!/bin/bash

# build the usb img that will contain baseOS

## requires kpartx from multipath-tools
## requires gdisk
## requires dosfstools
fallocate -l 2G baseOS.img
gdisk baseOS.img <<EOF
n
1

+1M
ef02
n
2



x
t
1
2
w
y
EOF

## format, mount partitions and install grub
## this parts gets dicey need the kpart loop device
## requires awk to resolve kpart device
loop_name="$(kpartx -l baseOS.img | tail -1 | awk -F'/' '{print $3}')"
loop_device="/dev/${loop_name}"
loop_parts="/dev/mapper/${loop_name}"
kpartx -a  baseOS.img
# give time for kernel to mount the partition table
sleep 1s

## create the FAT partition that will contain the img
mkfs.fat "${loop_parts}p1"
## get a temporary mount
temp_mount="$(mktemp -d)"
sleep 1s
mount "${loop_parts}p1" "$temp_mount"

## install grub
grub-install --target=i386-pc --boot-directory="$temp_mount/boot" "${loop_device}"
grub-install --target=i386-efi --efi-directory="$temp_mount" --bootloader-id=grub --boot-directory="$temp_mount/boot" --removable

## install grub configuration files
## should get UUID of root device
## needs sed
cp "grub.cfg" "$temp_mount/boot/grub/"
## get the UUID of the FAT partition
fat_uuid=$(blkid ${loop_parts}p1 | awk '{print $2}')
#echo "Please edit $temp_mount/boot/grub/grub.cfg and replace UUID=XXXX-XXX with $fat_uuid"
## add UUID to grub configuration file 
sed -i "s/UUID=XXXX-XXX/${fat_uuid//\"/}/g" "$temp_mount/boot/grub/grub.cfg"

## clean up
umount "$temp_mount"
rm -r "$temp_mount"
kpartx -d baseOS.img
