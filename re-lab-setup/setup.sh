#!/bin/bash

#Essentials
sudo apt update && sudo apt upgrade
sudo apt install build-essential curl wget python3 python3-pip -y 
pip install bs4
chmod +rx scrapers/*
#Doesn't have read/write permissions

#ida
wget $( scrapers/ida.py )
chmod +x ./ida*_linux.run
sudo ./ida*_linux.run
/opt/idafree*/ida64

#BinaryNinja
wget $( scrapers/binaryNinja.py )
unzip BinaryNinja-demo.zip
sudo mv ./binaryninja/ /opt/
sudo chown -R root:root /opt/binaryninja

#Hopper
curl -O https://d2ap6ypl1xbe4k.cloudfront.net/Hopper-v4-5.7.4-Linux-demo.deb
sudo apt install ./Hopper-v4-5.7.4-Linux-demo.deb -y

#Radare2
git clone https://github.com/radareorg/radare2
./radare2/sys/install.sh

#Cutter
wget $( scrapers/cutter.py )
sudo apt install ./cutter*.deb -y

#Ghidra
sudo apt install openjdk-11-jre openjdk-11-jdk -y
wget $( ./scrapers/ghidra.py )
unzip ghidra_*.zip
sudo mv ./ghidra*/ /opt/
sudo chown -R root:root /opt/ghidra*

#GDB + GEF/PEDA
sudo apt install gdb -y
bash -c "$(curl -fsSL https://gef.blah.cat/sh)"

#binwalk, CPPCheclk, Clang, AFL++, hexcurse
sudo apt install binwalk cppcheck clang clang-tools afl++ hexcurse -y

#Weggli
sudo apt install cargo -y
cargo install weggli 
echo "export PATH=\"$HOME/.cargo/bin:$PATH\"" >> $HOME/.bashrc

#BinDiff
wget $( scrapers/bindiff.py )
sudo apt install ./bindiff*.deb -y
/opt/bindiff/libexec/bindiff_config_setup --per_user