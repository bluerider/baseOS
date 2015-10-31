#!/bin/bash

# build the user encrypted img for storing custom settings
fallocate -l 500M user-crypt.img
cryptsetup luksFormat user-crypt.img
cryptsetup open user-crypt.img
mkfs.ext4 /dev/mapper/user-crypt.img
cryptsetup close user-crypt.img
