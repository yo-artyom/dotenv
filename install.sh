#!/bin/bash

echo 'Creating symlinks to configs...'

# nvim config copy
ln -sf `pwd`/nvim/.vimrc  ~/.vimrc
ln -sf `pwd`/nvim ~/.config/nvim

ln -sf `pwd`/zsh/.zshrc ~/.zshrc
ln -sf `pwd`/ack/.ackrc ~/.ackrc
ln -sf `pwd`/tmux/.tmux.conf ~/.tmux.conf
ln -sf `pwd`/alacritty/.alacritty.yml ~/.alacritty.yml

# Scripts copy
ln -sf `pwd`/scripts/*.sh /usr/local/bin/

# Git part
ln -sf `pwd`/git_configs/.global_gitignore ~/.global_gitignore

git config --global core.excludesfile ~/.global_gitignore
git config --global alias.squash $'!sh -c \'/usr/local/bin/squash.sh $1\' -'


echo 'Installing brew dependencies'
brew bundle

echo 'Done c:'
