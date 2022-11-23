#!/bin/bash

echo 'Creating symlinks to configs...'

echo "\n\t[Brew install]\n"
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh

echo "\n\t[Brew deps]\n"
brew bundle

echo "\n\t[Plug install]\n"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# nvim config copy
ln -sf `pwd`/nvim/vimrc  ~/.vimrc
ln -sf `pwd`/nvim ~/.config/nvim

ln -sf `pwd`/tmux/ ~/.tmux
ln -sf `pwd`/tmux/tmux.conf ~/.tmux.conf

ln -sf `pwd`/alacritty/alacritty.yml ~/.alacritty.yml
ln -sf `pwd`/alacritty/ ~/.alacritty

ln -sf `pwd`/zsh/zshrc ~/.zshrc
ln -sf `pwd`/ack/ackrc ~/.ackrc

# Scripts copy
ln -sf `pwd`/scripts/*.sh /usr/local/bin/

# Git part
ln -sf `pwd`/git_configs/.global_gitignore ~/.global_gitignore

git config --global core.excludesfile ~/.global_gitignore
git config --global alias.d $'!sh -c \'/usr/local/bin/git_diff_bat.sh\' -'

echo 'Done c:'
