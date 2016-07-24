alias x='exit'
alias q='exit'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'

alias ll='ls -alF'
alias la='ls -A'
alias ls='ls -G'
alias grep='GREP_COLOR="1;37;41" LANG=C grep --color=auto'
alias tree='tree -L 1'

alias rb=rbenv
alias r=rails
alias gh=ghub

alias ctags="`brew --prefix`/bin/ctags"
alias tmux='direnv exec / tmux'

alias askme="ruby /Users/samnang/Workspaces/ask_reframing_question.rb"

# Custom alias
alias rmigrate='rake db:migrate && rake db:test:prepare'
