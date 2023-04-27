#!/bin/bash

echo "\n\t[Brew install]\n"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "\n\t[Brew deps]\n"
brew bundle

echo "\n\t[Plug install]\n"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

echo '[Installing ZSH]'
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo '[Creating symlinks to configs]'
ln -sf `pwd`/nvim/vimrc  ~/.vimrc
mkdir -p ~/.config
ln -sf `pwd`/nvim ~/.config/nvim

ln -sf `pwd`/tmux/ ~/.tmux
ln -sf `pwd`/tmux/tmux.conf ~/.tmux.conf

ln -sf `pwd`/alacritty/alacritty.yml ~/.alacritty.yml
ln -sf `pwd`/alacritty/ ~/.alacritty

ln -sf `pwd`/zsh/zshrc ~/.zshrc
ln -sf `pwd`/ack/ackrc ~/.ackrc

# Scripts copy
sudo ln -sf `pwd`/scripts/*.sh /usr/local/bin/

ln -sf `pwd`/git_configs/.global_gitignore ~/.global_gitignore

git config --global core.excludesfile ~/.global_gitignore
sudo git config --global alias.d $'!sh -c \'/usr/local/bin/git_diff_bat.sh\' -'

echo '[Done c:]'
