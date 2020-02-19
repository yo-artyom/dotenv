#!/bin/bash

read -p "Do you want to remove old config files?" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  rm -f ~/.vimrc
  rm -f ~/.ackrc
  rm -f ~/.zshrc
  rm -f ~/.tmux.conf
  rm -f ~/.alacritty.yml
  rm -f ~/.global_gitignore
  rm -rf ~/.config/nvim
fi


# nvim config copy
ln -s `pwd`/.vimrc  ~/.vimrc
ln -s `pwd`/nvim ~/.config/nvim

ln -s `pwd`/.zshrc ~/.zshrc
ln -s `pwd`/.ackrc ~/.ackrc
ln -s `pwd`/.tmux.conf ~/.tmux.conf
ln -s `pwd`/.alacritty.yml ~/.alacritty.yml
ln -s `pwd`/.global_gitignore ~/.global_gitignore

git config --global core.excludesfile ~/.global_gitignore

echo 'Done c:'
