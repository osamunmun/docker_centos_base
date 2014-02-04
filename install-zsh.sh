#!/bin/sh

zsh_version=5.0.5

cd /usr/local/src
wget -O zsh-$zsh_version.tar.bz2 http://sourceforge.net/projects/zsh/files/zsh/$zsh_version/zsh-$zsh_version.tar.bz2/download
tar -jxvf ./zsh-$zsh_version.tar.bz2
cd zsh-$zsh_version/
./configure --prefix=/usr --with-tcsetpgrp
make -j 2
make install
echo /usr/bin/zsh >> /etc/shells
