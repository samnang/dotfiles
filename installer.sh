#!/bin/bash

git clone git://github.com/samnang/dotfiles.git ~/.dotfiles

ln -s ~/.dotfiles/vim ~/.vim
ln -s ~/.dotfiles/vimrc ~/.vimrc
ln -s ~/.dotfiles/gvimrc ~/.gvimrc

git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
