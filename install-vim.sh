#!/bin/sh

vim_version=7.4

echo "Downloading vim-$vim_version"
cd /usr/local/src
wget ftp://ftp.vim.org/pub/vim/unix/vim-$vim_version.tar.bz2
tar -xf vim-$vim_version.tar.bz2

echo "Compiling vim-$vim_version"
cd vim74
./configure --with-features=huge --enable-multibyte --enable-rubyinterp --enable-pythoninterp --enable-gpm --enable-cscope --enable-fontset
make
make install
# vim -u /home/osamunmun/.vimrc -i NONE -c "try | NeoBundleUpdate! | finally | q! | endtry" -e -s -V1
# cd /home/osamunmun/.dotfiles/vim/bundle/vimproc
# make

echo "Cleaning up"
cd /usr/local/src
rm -rf ./vim-$vim_version.tar.gz vim-$vim_version
