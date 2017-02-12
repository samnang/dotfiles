This is my ~/.vim folder I use on Macbook Pro.

Installation/Usage
==================

Run the following command from your terminal and enjoy the fireworks!

```bash
brew update
brew install curl git the_silver_searcher zsh zsh-completions

chsh -s $(which zsh)

curl https://raw.github.com/samnang/dotfiles/master/installer.sh | sh
vim +BundleInstall +qall
```
