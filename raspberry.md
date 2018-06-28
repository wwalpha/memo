# Raspberry Pi3 Model B+
MacでOSインストールから、WIFI、SSH設定環境までの簡単手順です

## Download
* [NOOBS](https://www.raspberrypi.org/downloads/noobs/)
  * An easy operating system installer which contains Raspbian and LibreELEC
* [Raspbian](https://www.raspberrypi.org/downloads/raspbian/)
  * The Official supported Raspberry Pi Operating System - based on debian

## Install OS
* Unzip
```s
unzi NOOBS_lite_v2_8.zip
```
* Find SDCard Solt
```s
diskutil list
```
* Format SDCard
```s
diskutil eraseDisk FAT32 RPI **/dev/disk2**
```
* SDCard unmount
```s
diskutil unmountDisk /dev/disk2
```
* Write OS
  * first move to img file folder
```s
sudo dd bs=1m if=NOOBS_lite_v2_8.img of=/dev/disk2
```

## Update & Upgrade OS
```s
sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade
sudo apt-get install -y rpi-update
sudo apt-get install -y vim
sudo rpi-update
sudo reboot
```