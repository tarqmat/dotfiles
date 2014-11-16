# TODO: everythig
export TERM="xterm-256color"
fpath=(~/.zshcompletion ${fpath})

fuction chpwd() { ls -G }

alias df='df -h'
alias du='du -h'
alias vi='vim'
# alias ls='ls --color=auto'
alias ls='ls -G'
alias ll='ls -ltr'
alias la='ls -al'
alias tree='tree -C'

stty stop undef
stty -ixon -ixoff

autoload -U compinit
compinit

zstyle ':completion:*' list-colors ''

export LANG=ja_JP.UTF-8

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt hist_ignore_dups
setopt share_history

bindkey -v

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end 
setopt auto_cd
setopt auto_pushd
setopt auto_param_keys
setopt correct
setopt list_packed
setopt nolistbeep
setopt COMPLETE_IN_WORD
setopt NO_flow_control

