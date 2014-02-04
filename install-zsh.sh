#!/bin/sh

zsh_version=5.0.5

echo "Downloading zsh-$zsh_version"
cd /usr/local/src
wget -O zsh-$zsh_version.tar.bz2 http://sourceforge.net/projects/zsh/files/zsh/$zsh_version/zsh-$zsh_version.tar.bz2/download
tar -jxvf ./zsh-$zsh_version.tar.bz2

echo "Compiling zsh-$zsh_version"
cd zsh-$zsh_version/
./configure --prefix=/usr --with-tcsetpgrp
make -j 2
make install
echo /usr/bin/zsh >> /etc/shells

echo "Cleaning up"
cd /usr/local/src
rm -rf ./zsh-$zsh_version.tar.bz2 zsh-$zsh_version
