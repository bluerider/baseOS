#!/bin/bash

# build the user encrypted img for storing custom setting

## create 500M image
fallocate -l 500M user-crypt.img

## get password
echo "What will be your password?"
read -r cryptpw

## format encrypted img
echo $cryptpw | cryptsetup luksFormat user-crypt.img

## open up the encrypted img
echo $cryptpw | cryptsetup open user-crypt.img user-crypt.img
sleep 1s

## remove cryptpw value
unset cryptpw

## format filesystem
mkfs.ext4 /dev/mapper/user-crypt.img
sleep 1s
cryptsetup close user-crypt.img

