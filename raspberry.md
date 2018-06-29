# Raspberry Pi3 Model B+
MacでOSインストールから、WIFI、SSH設定環境までの簡単手順です

## Download
* [NOOBS](https://www.raspberrypi.org/downloads/noobs/)
  * An easy operating system installer which contains Raspbian and LibreELEC
* [Raspbian](https://www.raspberrypi.org/downloads/raspbian/)
  * The Official supported Raspberry Pi Operating System - based on debian

## Install OS
Complete KitはNOOBSインストール済みのSDCardまで提供していますので、下記コマンドは未検証です。

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

## Nodejs
### Install
* インストールコマンド
```s
sudo apt-get install -y nodejs npm
sudo npm cache clean
sudo npm install npm n -g
sudo n lts
sudo npm install npm -g
```
* インストール可能のバージョン一覧
```s
n ls
```
* バージョン指定のインストール
```s
sudo n 8.11.3
```

### Versions
SSH接続でインストールした場合、最新版に切り替わるため、SSHの再接続が必要です。

* インストール済バージョン確認
```s
node -v
npm -v
```
* 複数バージョン間の切替
```s
```

## Python3
### Install For pyenv
```s
sudo apt-get install -y git openssl libssl-dev libbz2-dev libreadline-dev libsqlite3-dev
```

### Get pyenv
```
git clone https://github.com/yyuu/pyenv.git ~/.pyenv
```

### Set Env
```
sudo vi ~/.bash_profile

# 以下の内容を追記
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
```

### Python Install
* インストールできるバージョンの一覧表示
```
pyenv install --list
```

* バージョン指定し、インストール
```s
pyenv install 3.6.6
```

* 現状のpythonのバージョンを確認
```
python --version
Python 2.7.5
```

* Python3に切替
```
pyenv global 3.6.6
```

* Python2に切替
```
pyenv global system
```
