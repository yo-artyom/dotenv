#!/bin/bash

echo 'Creating symlinks to configs...'

# nvim config copy
ln -sf `pwd`/nvim/.vimrc  ~/.vimrc
ln -sf `pwd`/nvim ~/.config/nvim

ln -sf `pwd`/zsh/.zshrc ~/.zshrc
ln -sf `pwd`/ack/.ackrc ~/.ackrc
ln -sf `pwd`/tmux/.tmux.conf ~/.tmux.conf
ln -sf `pwd`/alacritty/.alacritty.yml ~/.alacritty.yml
ln -sf `pwd`/global_gitignore/.global_gitignore ~/.global_gitignore

git config --global core.excludesfile ~/.global_gitignore

echo 'Installing brew dependencies'
brew bundle

echo 'Done c:'
