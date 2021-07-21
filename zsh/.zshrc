export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"
plugins=(tmux git history-substring-search bundler rails ruby)

source $ZSH/oh-my-zsh.sh

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:/Users/$USER/go/bin"

export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

export EDITOR='nvim'

export ACKRC="$HOME/.ackrc"

export GOPATH="/Users/$USER/go:$HOME/Learning/Go"
export GODOCC_STYLE="solarized-dark"

eval "$(rbenv init -)"
export RBENV_ROOT="/usr/local/rbenv"
if [ -d "${RBENV_ROOT}" ]; then
  export PATH="${RBENV_ROOT}/bin:${PATH}"
fi

if which rbenv > /dev/null; then eval "$(rbenv init - zsh)"; fi

## ##
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

alias phs="iex -S mix phoenix.server"

## Aliases
alias v="nvim"
alias vim="nvim"
alias b="bat"

alias trde='trans :de'
alias trru='trans :ru'

# bindkey "$terminfo[kcuu1]" history-substring-search-up
# bindkey "$terminfo[kcud1]" history-substring-search-down

export LC_ALL=en_US.UTF-8

bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

prompt_context () { }
