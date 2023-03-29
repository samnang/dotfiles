#!/bin/bash

###############################
# dotfiles for Dev Containers #
###############################

brew install starship diff-so-fancy bat brew gh

dotfiles="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"

echo $dotfiles

ln -s "${dotfiles}/gemrc" ~/.gemrc
ln -s "${dotfiles}/irbrc" ~/.irbrc
ln -s "${dotfiles}/gitconfig" ~/.gitconfig
ln -s "${dotfiles}/gitignore_global" ~/.gitignore_global
ln -s "${dotfiles}/gitmessage" ~/.gitmessage
ln -s "${dotfiles}/starship.toml" ~/.starship.toml

echo "alias cat='bat'" >> ~/.zshrc
echo 'eval "$(starship init zsh)"' >> ~/.zshrc
