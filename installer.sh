#!/bin/bash

brew install curl git the_silver_searcher zsh zsh-completions
chsh -s $(which zsh) # chsh -s /bin/zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

brew tap homebrew/cask-fonts &&
brew install --cask font-jetbrains-mono-nerd-font
brew install starship

curl https://raw.github.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
curl https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh -o ~/.git-prompt.sh

git clone git://github.com/samnang/dotfiles.git ~/.dotfiles

ln -f -s ~/.dotfiles/zshrc ~/.zshrc
ln -s ~/.dotfiles/aliases ~/.aliases

ln -s ~/.dotfiles/vim ~/.vim
ln -s ~/.dotfiles/vimrc ~/.vimrc

ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/gemrc ~/.gemrc
ln -s ~/.dotfiles/irbrc ~/.irbrc
ln -s ~/.dotfiles/gitconfig ~/.gitconfig
ln -s ~/.dotfiles/gitignore_global ~/.gitignore_global
ln -s ~/.dotfiles/ctags ~/.ctags
ln -s ~/.dotfiles/ackrc ~/.ackrc
ln -s ~/.dotfiles/agignore ~/.agignore
ln -s ~/.dotfiles/gitmessage ~/.gitmessage
ln -s ~/.dotfiles/starship.toml ~/.starship.toml

vim +PlugInstall +qall
