#!/bin/bash

###############################
# dotfiles for Dev Containers #
###############################

apt-get -y update --no-install-recommends
apt-get -y install diff-so-fancy bat gh

curl -sS https://starship.rs/install.sh | sh

dotfiles="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"
ln -s "${dotfiles}/gemrc" ~/.gemrc
ln -s "${dotfiles}/irbrc" ~/.irbrc
ln -s "${dotfiles}/gitconfig" ~/.gitconfig
ln -s "${dotfiles}/gitignore_global" ~/.gitignore_global
ln -s "${dotfiles}/gitmessage" ~/.gitmessage
ln -s "${dotfiles}/starship.toml" ~/.starship.toml

echo "alias cat='bat'" >> ~/.zshrc
echo 'eval "$(starship init zsh)"' >> ~/.zshrc
