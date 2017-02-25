# ZSH=$HOME/.oh-my-zsh
# ZSH_THEME="ys"
# COMPLETION_WAITING_DOTS="true"
# plugins=(git)

# source $ZSH/oh-my-zsh.sh

# User configuration

export GOPATH=$HOME/devel/go
export PATH=/usr/local/bin:$PATH:$HOME/bin:$PATH:$GOPATH/bin:$HOME/devel/bin

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
# export RUST_SRC_PATH=$HOME/.multirust/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src

source $HOME/.cargo/env
