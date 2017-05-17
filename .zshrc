export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"

plugins=(git history-substring-search bundler rails ruby colorize)

source $ZSH/oh-my-zsh.sh

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

export PATH="$HOME/anaconda3/bin:$PATH"

export PATH=$PATH:/usr/local/go/bin

export GOPATH=$HOME/go;
export PATH=$PATH:$GOPATH/bin;

export EDITOR='nvim'

export ACKRC="$HOME/.ackrc"

export PATH="$HOME/.rbenv/bin:$PATH"

eval "$(rbenv init -)"
export RBENV_ROOT="/usr/local/rbenv"
if [ -d "${RBENV_ROOT}" ]; then
  export PATH="${RBENV_ROOT}/bin:${PATH}"
fi

if which rbenv > /dev/null; then eval "$(rbenv init - zsh)"; fi

## NPM ##
alias load_nvm='export NVM_DIR="$HOME/.nvm" && [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"'
alias node='unalias node npm && load_nvm && node'
alias npm='unalias node npm && load_nvm && npm'

## ##
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


alias phs="iex -S mix phoenix.server"

alias v="nvim"
alias vim="nvim"

alias trde='trans :de'
alias trru='trans :ru'

alias t='tig'

function ca(){
  if [ -n "$1" ]; then
    colorize $1
  else
    echo 'colorize called without params'
  fi
}

bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

prompt_context () { }
