#!/bin/bash

# build the user encrypted img for storing custom setting

fallocate -l 500M user-crypt.img
cryptsetup luksFormat user-crypt.img
cryptsetup open user-crypt.img user-crypt.img
sleep 1s
mkfs.ext4 /dev/mapper/user-crypt.img
sleep 1s
cryptsetup close user-crypt.img
