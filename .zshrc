ZSH=$HOME/.oh-my-zsh
ZSH_THEME="ys"
COMPLETION_WAITING_DOTS="true"
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

export GOPATH=$HOME/devel/go
export PATH=$HOME/bin:/usr/local/bin:$PATH:$GOPATH/bin

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
