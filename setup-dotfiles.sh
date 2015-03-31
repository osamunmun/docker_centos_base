#!/bin/sh

echo "Clone osamunmun/dotfiles"
cd /home/osamunmun
git clone https://github.com/osamunmun/dotfiles.git

mkdir .dotfiles
cd .dotfiles
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git

echo "Make sysmlink"
ln -sf ./dotfiles/vim/vimfiles /home/osamunmun/.vim
ln -sf ./dotfiles/vim/_vimrc /home/osamunmun/.vimrc
ln -sf ./dotfiles/zshrc /home/osamunmun/.zshrc

echo "Cleaning up"
cd /usr/local/src
rm -rf
