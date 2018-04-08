[[ $TERM == "dumb" ]] && unsetopt zle && PS1="> " && return
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory autocd extendedglob nomatch notify
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/chris/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Aliases
alias nmplz="sudo rc-service NetworkManager restart"
alias svim="sudo -E vim"
alias e="emacsclient -nw"
alias E="sudoedit"
alias ls="ls -h --color=auto"
alias du="du -h"
alias df="df -h"
alias wipa="watch -n0.2 -- ip a"

# Source theme
source ~/.minimal.zsh
