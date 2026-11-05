#!/bin/bash

set -euo pipefail

# 1. Install Homebrew
if ! command -v brew &> /dev/null; then
    echo -e "\n\t[Brew install]\n"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Add brew to path for the current session (macOS Apple Silicon path)
    if [[ -f /opt/homebrew/bin/brew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo "Homebrew already installed. Skipping..."
fi

# 2. Brew deps (safe to run repeatedly, but we can check for Brewfile)
if [[ -f "Brewfile" ]]; then
    echo -e "\n\t[Brew deps]\n"
    brew bundle
fi

# 3. Neovim plugins are managed by lazy.nvim, which bootstraps itself on
# first launch of Neovim (see nvim/lua/config/lazy.lua). No manual install
# step needed here.

# 4. Install ZSH / Oh My Zsh
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    echo '[Installing Oh My Zsh]'
    # Use KEEP_ZSHRC to avoid overwriting your existing config
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
    # Set shell to zsh if it's not already
    if [[ "$SHELL" != "$(which zsh)" ]]; then
        chsh -s "$(which zsh)"
    fi
else
    echo "Oh My Zsh already installed. Skipping..."
fi

# Finally run local setup
if [[ -f "./setup.sh" ]]; then
    ./setup.sh
fi
