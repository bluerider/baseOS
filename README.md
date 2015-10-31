# baseOS

baseOS is a squashfs based operating system with selective data permanence and block level user encryption. Read the README for instructions on how to install baseOS.


#Minimum Requirements:
  * 1GB Ram
  * 2GB USB/HDD/SSD/SD
  * Keyboard support (need this for entering password)

#Features:
  * Runs mostly on ram reducing I/O hits from running off slow media.
  * Boots up cleanly from an encrypted user image and a read only root. Test out new programs on baseOS without committing anything to disk!
  * Based on Arch Linux and features the pacman package manager.
  * Block level encryption of user img allows deploying multiplying multiple baseOS imgs with minor user changes.
  * Comes with tor, openvpn, and socks support.

As of the time of this readme. The build scripts for baseOS haven't been rigorously tested yet. If one wants to test baseOS they should just download from the release branch.
