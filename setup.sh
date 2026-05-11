#!/bin/bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$DOTFILES_DIR/lib/platform.sh"

PLATFORM="$(require_supported_platform)"
source_platform_script setup "$PLATFORM"

echo '[Creating symlinks to configs]'

link_file() {
    local src="$1"
    local dest="$2"
    echo "  -> Linking $dest"
    ln -sf "$src" "$dest"
}

# Ensure base config directories exist before symlinking inside them
mkdir -p ~/.config
mkdir -p ~/.config/alacritty
mkdir -p ~/.config/dotenv
mkdir -p ~/.local/bin

link_file "$DOTFILES_DIR/nvim/vimrc" ~/.vimrc
link_file "$DOTFILES_DIR/nvim" ~/.config/nvim

link_file "$DOTFILES_DIR/tmux/" ~/.tmux
link_file "$DOTFILES_DIR/tmux/tmux.conf" ~/.tmux.conf

link_file "$DOTFILES_DIR/zsh/zshrc" ~/.zshrc
link_file "$DOTFILES_DIR/ack/ackrc" ~/.ackrc
link_file "$DOTFILES_DIR/git_configs/.gitconfig" ~/.gitconfig
link_file "$DOTFILES_DIR/git_configs/.global_gitignore" ~/.global_gitignore

# Alacritty natively looks in ~/.config/alacritty/alacritty.toml
# Note: Ensure your actual source file is TOML, as Alacritty dropped YAML support.
if [[ -f "$DOTFILES_DIR/alacritty/alacritty.toml" ]]; then
    link_file "$DOTFILES_DIR/alacritty/alacritty.toml" ~/.config/alacritty/alacritty.toml
    link_file "$DOTFILES_DIR/alacritty/currentTheme.toml" ~/.config/alacritty/currentTheme.toml
    link_file "$DOTFILES_DIR/alacritty/darkTheme.toml" ~/.config/alacritty/darkTheme.toml
    link_file "$DOTFILES_DIR/alacritty/lightTheme.toml" ~/.config/alacritty/lightTheme.toml
elif [[ -f "$DOTFILES_DIR/alacritty/alacritty.yml" ]]; then
    echo "  ! Warning: Alacritty no longer supports YAML. Please migrate to TOML."
    link_file "$DOTFILES_DIR/alacritty/alacritty.yml" ~/.alacritty.yml
fi

echo '[Linking platform overlays]'
platform_link_overlays

echo '[Installing custom scripts]'
for script in "$DOTFILES_DIR/scripts/"*.sh; do
    if [[ -f "$script" ]]; then
        script_name=$(basename "$script")
        echo "  -> Symlinking $script_name to ~/.local/bin/"
        ln -sf "$script" "$HOME/.local/bin/$script_name"
    fi
done

echo '[Configuring Git]'
git config --global core.excludesfile ~/.global_gitignore
git config --global alias.d $'!sh -c \'$HOME/.local/bin/git_diff_bat.sh\' -'

echo '[Configuring language plugins]'
if command -v mise &> /dev/null; then
    echo "  -> Installing latest Ruby and Node via mise"
    mise use --global ruby@latest
    mise use --global node@latest
else
    echo "  ! mise not found. Skipping Ruby/Node setup."
fi

echo '[Installing fonts]'
install_platform_fonts

echo '[Applying platform defaults]'
configure_platform_defaults

echo '[Done c:]'
