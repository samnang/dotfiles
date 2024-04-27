# Enable extended globbing
setopt extendedglob

# Allow [ or ] whereever you want
unsetopt nomatch

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

plugins=(asdf autoupdate fzf httpie starship zoxide)

source $ZSH/oh-my-zsh.sh

######################
# User configuration #
######################

export EDITOR="nvim"
export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# Web3
export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"
export PATH="$HOME/.avm/bin:$PATH"
export PATH="$PATH:$HOME/.foundry/bin"

#########################
# Plugins Customization #
#########################
export FZF_DEFAULT_COMMAND="rg --files --hidden"
export STARSHIP_CONFIG=~/.starship.toml

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
[ -f ~/.aliases ] && source ~/.aliases

export TMUXINATOR_CONFIG="~/Documents/Apps/tmuxinator"

# 1Password CLI
if (( ${+commands[op]} )); then
  eval "$(op completion zsh)"
  compdef _op op

  [ -f ~/.config/op/plugins.sh ] && source ~/.config/op/plugins.sh
fi
