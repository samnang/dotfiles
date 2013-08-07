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
alias l='ls -CF'
alias ls='ls -G'
alias grep='GREP_COLOR="1;37;41" LANG=C grep --color=auto'
alias tree='tree -L 1'

# Custom alias
alias work='cd /Volumes/Documents/Work/'
alias proxy='ssh -L 8765:localhost:8765 pair@184.106.240.141'

alias rmigrate='rake db:migrate && rake db:test:prepare'
