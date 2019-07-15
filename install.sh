#!/bin/bash

rm -f ~/.vimrc
rm -f ~/.ackrc
rm -f ~/.zshrc
rm -f ~/.tmux.conf
rm -rf ~/.config/nvim

ln -s `pwd`/.vimrc  ~/.vimrc
ln -s `pwd`/nvim ~/.config/nvim

ln -s `pwd`/.zshrc ~/.zshrc
ln -s `pwd`/.ackrc ~/.ackrc
ln -s `pwd`/.tmux.conf ~/.tmux.conf

echo 'Done c:'
