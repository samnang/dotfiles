#!/bin/bash

###############################
# dotfiles for Dev Containers #
###############################

dotfiles="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"

ln -s "${dotfiles}/gemrc" ~/.gemrc
ln -s "${dotfiles}/irbrc" ~/.irbrc
ln -s "${dotfiles}/gitconfig" ~/.gitconfig
ln -s "${dotfiles}/gitignore_global" ~/.gitignore_global
ln -s "${dotfiles}/gitmessage" ~/.gitmessage
ln -s "${dotfiles}/starship.toml" ~/.starship.toml

if ! type brew &> /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew install starship diff-so-fancy bat gh

echo "alias cat='bat'" >> ~/.zshrc
echo 'eval "$(starship init zsh)"' >> ~/.zshrc
