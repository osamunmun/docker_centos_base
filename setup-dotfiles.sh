#!/bin/sh

echo "Clone osamunmun/dotfiles"
cd /home/osamunmun
git clone https://github.com/osamunmun/dotfiles.git .dotfiles

cd .dotfiles
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git

echo "Make sysmlink"
ln -sf /home/osamunmun/.dotfiles/vim/vimfiles /home/osamunmun/.vim
ln -sf /home/osamunmun/.dotfiles/vim/_vimrc /home/osamunmun/.vimrc
ln -sf /home/osamunmun/.dotfiles/zshrc /home/osamunmun/.zshrc
ln -sf /home/osamunmun/.dotfiles/gitconfig /home/osamunmun/.gitconfig
