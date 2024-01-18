#!/bin/bash

set -eu

echo '[Creating symlinks to configs]'
ln -sf `pwd`/nvim/vimrc  ~/.vimrc
mkdir -p ~/.config
ln -sf `pwd`/nvim ~/.config/nvim

ln -sf `pwd`/tmux/ ~/.tmux
ln -sf `pwd`/tmux/tmux.conf ~/.tmux.conf

ln -sf `pwd`/alacritty/alacritty.yml ~/.alacritty.toml
ln -sf `pwd`/alacritty/ ~/.alacritty

ln -sf `pwd`/zsh/zshrc ~/.zshrc
ln -sf `pwd`/ack/ackrc ~/.ackrc

# Scripts copy
sudo ln -sf `pwd`/scripts/*.sh /usr/local/bin/
ln -sf `pwd`/git_configs/.global_gitignore ~/.global_gitignore

git config --global core.excludesfile ~/.global_gitignore
sudo git config --global alias.d $'!sh -c \'/usr/local/bin/git_diff_bat.sh\' -'

# Asdf plugins
asdf plugin add ruby
asdf plugin add nodejs

echo '[Done c:]'
