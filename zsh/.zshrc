export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="agnoster"
plugins=(tmux git history-substring-search bundler rails ruby)

source $ZSH/oh-my-zsh.sh

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/homebrew/bin/"
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/Users/$USER/go/bin
export PATH=$PATH:/Users/$USER/Library/Python/3.8/bin
export PATH=$PATH:/opt/homebrew/opt/ruby/bin:$PATH
export PATH=$HOME:/.rbenv/bin:$PATH

export PATH=$PATH:/Users/$USER/.cargo/bin
export PATH=$PATH:/Users/amalyshev/.foundry/bin

export EDITOR=nvim

export ACKRC=$HOME/.ackrc

export GOPATH=/Users/$USER/go:$HOME/Learning/Go
export GODOCC_STYLE=solarized-dark

export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH

## Aliases
alias v="nvim"
alias vim="nvim"
alias b="bat"

alias phs="iex -S mix phoenix.server"

export LC_ALL=en_US.UTF-8

bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

prompt_context () { }

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(rbenv init - zsh)"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
