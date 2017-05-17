#!/bin/bash

rm -f ~/.vimrc
rm -f ~/.ackrc
rm -f ~/.zshrc
rm -rf ~/.config/nvim

ln -s `pwd`/.vimrc  ~/.vimrc
ln -s `pwd`/nvim ~/.config/nvim

ln -s `pwd`/.zshrc ~/.zshrc
ln -s `pwd`/.ackrc ~/.ackrc

echo 'Done c:'
