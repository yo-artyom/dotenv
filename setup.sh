#!/bin/bash

set -euo pipefail

DOTFILES_DIR="$PWD"

echo '[Creating symlinks to configs]'

# 2. Helper function to make symlinking cleaner and provide visual feedback
link_file() {
    local src="$1"
    local dest="$2"
    echo "  -> Linking $dest"
    ln -sf "$src" "$dest"
}

# Ensure base config directories exist before symlinking inside them
mkdir -p ~/.config
mkdir -p ~/.config/alacritty
mkdir -p ~/.local/bin

# 3. Create symlinks
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
# 5. Removed 'sudo' from git config: Setting user aliases with sudo writes to the root user's ~/.gitconfig
git config --global alias.d $'!sh -c \'$HOME/.local/bin/git_diff_bat.sh\' -'

echo '[Configuring language plugins]'
# 6. Updated to use 'mise' instead of 'asdf', consistent with our new stack
if command -v mise &> /dev/null; then
    # In mise, plugins are installed automatically when you request a language version,
    # but you can explicitly install the latest versions like this:
    echo "  -> Installing latest Ruby and Node via mise"
    mise use --global ruby@latest
    mise use --global node@latest
else
    echo "  ! mise not found. Skipping Ruby/Node setup."
fi

echo '[Installing fonts]'
for font in "$DOTFILES_DIR/fonts/"*.{otf,ttf}; do
    if [[ -f "$font" ]]; then
        font_name=$(basename "$font")
        if [[ ! -f "$HOME/Library/Fonts/$font_name" ]]; then
            echo "  -> Installing $font_name"
            cp "$font" "$HOME/Library/Fonts/"
        else
            echo "  -> $font_name already installed. Skipping..."
        fi
    fi
done

echo '[Done c:]'
