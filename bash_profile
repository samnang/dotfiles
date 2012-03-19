export EDITOR="vim"
export NODE_PATH="/usr/local/lib/node"
export PATH=/usr/local/bin:$PATH

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

[[ -s "/Users/samnang/.rvm/scripts/rvm" ]] && source "/Users/samnang/.rvm/scripts/rvm"
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

function prompt {
	local LIGHT_RED="\[\033[1;31m\]"
	local LIGHT_GREEN="\[\033[1;32m\]"
	local NO_COLOUR="\[\033[0m\]"

	local TITLEBAR='\[\033]0;\u@\h\007\]'

	export GIT_PS1_SHOWDIRTYSTATE=true
	export GIT_PS1_SHOWUNTRACKEDFILES=true
	export GIT_PS1_SHOWUPSTREAM=auto
	export GIT_PS1_SHOWSTASHSTATE=true

	PS1="$TITLEBAR\n\W/$LIGHT_GREEN\$(__git_ps1 ' (%s)') $LIGHT_RED\$(~/.rvm/bin/rvm-prompt i v g)\n$NO_COLOUR$ "
}

#call the prompt function to set things in motion
prompt
