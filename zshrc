# Enable extended globbing
setopt extendedglob

# Allow [ or ] whereever you want
unsetopt nomatch

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

plugins=(asdf httpie autoupdate zoxide)

######################
# User configuration #
######################

export EDITOR="nvim"
export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

export STARSHIP_CONFIG=~/.starship.toml
eval "$(starship init zsh)"

eval "$(zoxide init zsh)"

# Web3
export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"
export PATH="$HOME/.avm/bin:$PATH"
export PATH="$PATH:$HOME/.foundry/bin"

# 1Password CLI
[ -f ~/.config/op/plugins.sh ] && source ~/.config/op/plugins.sh

source $ZSH/oh-my-zsh.sh

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
[ -f ~/.aliases ] && source ~/.aliases

#########################
# Plugins Customization #
#########################

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="rg --files --hidden"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
