#!/bin/bash

###############################
# dotfiles for Dev Containers #
###############################

brew install starship diff-so-fancy bat

ln -s gemrc ~/.gemrc
ln -s irbrc ~/.irbrc
ln -s gitconfig ~/.gitconfig
ln -s gitignore_global ~/.gitignore_global
ln -s ackrc ~/.ackrc
ln -s agignore ~/.agignore
ln -s gitmessage ~/.gitmessage
ln -s starship.toml ~/.starship.toml

echo 'eval "$(starship init zsh)"' >> ~/.zshrc
