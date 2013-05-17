#!/bin/bash

git clone git://github.com/samnang/dotfiles.git ~/.dotfiles

ln -s ~/.dotfiles/vim ~/.vim
ln -s ~/.dotfiles/vimrc ~/.vimrc
ln -s ~/.dotfiles/gvimrc ~/.gvimrc

ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/gemrc ~/.gemrc
ln -s ~/.dotfiles/gitconfig ~/.gitconfig
ln -s ~/.dotfiles/ackrc ~/.ackrc

git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
