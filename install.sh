#!/bin/bash
git clone git://github.com/samnang/dotfiles.git ~/.vim
ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc
cd ~/.vim
git submodule init
git submodule update
cd ~/.vim/bundle/Command-T/ruby/command-t/
ruby extconf.rb
make
