#!/bin/bash

###############################
# dotfiles for Dev Containers #
###############################

dotfiles="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

ln -s "${dotfiles}/gemrc" ~/.gemrc
ln -s "${dotfiles}/rubocop.yml" ~/.rubocop.yml
ln -s "${dotfiles}/irbrc" ~/.irbrc
ln -s "${dotfiles}/gitconfig" ~/.gitconfig
ln -s "${dotfiles}/gitignore_global" ~/.gitignore_global
ln -s "${dotfiles}/gitmessage" ~/.gitmessage
ln -s "${dotfiles}/starship.toml" ~/.starship.toml

if type brew &>/dev/null; then
  brew install starship diff-so-fancy bat gh

  echo "alias cat='bat'" >>~/.zshrc
  echo 'eval "$(starship init zsh)"' >>~/.zshrc
fi
