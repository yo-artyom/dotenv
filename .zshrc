export ZSH=/home/artyom/.oh-my-zsh

ZSH_THEME="agnoster"

plugins=(git history-substring-search bundler rails ruby powerline)

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

source $ZSH/oh-my-zsh.sh

export EDITOR='vim'

export ACKRC=".ackrc"

export PATH="$HOME/.rbenv/bin:$PATH"

export PATH="/home/artyom/anaconda2/bin:$PATH"

eval "$(rbenv init -)"
export RBENV_ROOT="/usr/local/rbenv"
if [ -d "${RBENV_ROOT}" ]; then
    export PATH="${RBENV_ROOT}/bin:${PATH}"
  fi

alias shop_server="ssh root@194.58.103.234"
alias fun_server="ssh root@185.159.130.152"
alias phs="iex -S mix phoenix.server"

alias v="vim"

bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down


if which rbenv > /dev/null; then eval "$(rbenv init - zsh)"; fi
export RBENV_ROOT="/usr/local/rbenv"
if [ -d "${RBENV_ROOT}" ]; then
    export PATH="${RBENV_ROOT}/bin:${PATH}"
fi


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

NPM_PACKAGES="${HOME}/.npm-packages"
PATH="$NPM_PACKAGES/bin:$PATH"

# Unset manpath so we can inherit from /etc/manpath via the `manpath` command
unset MANPATH # delete if you already modified MANPATH elsewhere in your config
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

prompt_context () { }


export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
