#!/bin/bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$DOTFILES_DIR/lib/platform.sh"

PLATFORM="$(require_supported_platform)"
source_platform_script install "$PLATFORM"

install_platform_packages

# Install vim-plug for Neovim
VIM_PLUG_PATH="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim"
if [[ ! -f "$VIM_PLUG_PATH" ]]; then
    echo -e "\n\t[Plug install]\n"
    curl -fLo "$VIM_PLUG_PATH" --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
    echo "vim-plug already installed. Skipping..."
fi

# Install ZSH / Oh My Zsh
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    echo '[Installing Oh My Zsh]'
    # Use KEEP_ZSHRC to avoid overwriting your existing config
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
    # Set shell to zsh if it's not already
    if [[ "$SHELL" != "$(command -v zsh)" ]]; then
        chsh -s "$(command -v zsh)"
    fi
else
    echo "Oh My Zsh already installed. Skipping..."
fi

# Finally run local setup
if [[ -f "$DOTFILES_DIR/setup.sh" ]]; then
    "$DOTFILES_DIR/setup.sh"
fi
