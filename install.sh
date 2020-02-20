#!/bin/bash

read -p "Do you want to remove old config files? [y/n]" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  rm -f ~/.ackrc
  rm -f ~/.alacritty.yml
  rm -f ~/.global_gitignore
  rm -f ~/.tmux.conf
  rm -f ~/.zshrc

  rm -f ~/.vimrc
  rm -rf ~/.config/nvim
fi


# nvim config copy
ln -s `pwd`/nvim/.vimrc  ~/.vimrc
ln -s `pwd`/nvim ~/.config/nvim

ln -s `pwd`/zsh/.zshrc ~/.zshrc
ln -s `pwd`/ack/.ackrc ~/.ackrc
ln -s `pwd`/tmux/.tmux.conf ~/.tmux.conf
ln -s `pwd`/alacritty/.alacritty.yml ~/.alacritty.yml
ln -s `pwd`/global_gitignore/.global_gitignore ~/.global_gitignore

git config --global core.excludesfile ~/.global_gitignore

echo 'Done c:'
