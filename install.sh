#!/bin/bash
git clone git://github.com/samnang/vimfiles.git ~/.vim
ln -s ~/.vim/vimrc ~/.vimrc
cd ~/.vim
git submodule init
git submodule update
cd ~/.vim/bundle/Command-T/ruby/command-t/
ruby extconf.rb
make
