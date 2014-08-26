export EDITOR="vim"
export NODE_PATH="/usr/local/lib/node"
export PATH=$HOME/bin:$PATH
export PATH="/Applications/Postgres.app/Contents/Versions/9.3/bin:$PATH"
export PATH="/usr/local/share/npm/bin:$PATH"
export PATH="/usr/local/bin:$PATH"

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

[[ -s "/Users/samnang/.rvm/scripts/rvm" ]] && source "/Users/samnang/.rvm/scripts/rvm"

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi


function prompt {
	local LIGHT_RED="\[\033[1;31m\]"
	local LIGHT_GREEN="\[\033[1;32m\]"
	local NO_COLOUR="\[\033[0m\]"

	local TITLEBAR='\[\033]0;\u@\h\007\]'

	export GIT_PS1_SHOWDIRTYSTATE=true
	export GIT_PS1_SHOWUNTRACKEDFILES=true
	export GIT_PS1_SHOWUPSTREAM=auto
	export GIT_PS1_SHOWSTASHSTATE=true

  rbenv='$(rbenv version-name)'

	PS1="$TITLEBAR\n\W/$LIGHT_GREEN\$(__git_ps1 ' (%s)') $LIGHT_RED${rbenv}\n$NO_COLOUR$ "
}

#call the prompt function to set things in motion
prompt

source ~/.git-prompt.sh
source ~/.git-completion.bash
