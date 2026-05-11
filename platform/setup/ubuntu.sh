#!/bin/bash

platform_link_overlays() {
    link_file "$DOTFILES_DIR/zsh/platform/ubuntu.zsh" "$HOME/.config/dotenv/zsh-platform.zsh"
    link_file "$DOTFILES_DIR/tmux/platform/ubuntu.conf" "$HOME/.config/dotenv/tmux-platform.conf"
    link_file "$DOTFILES_DIR/alacritty/platform/ubuntu.toml" "$HOME/.config/dotenv/alacritty-platform.toml"
    link_file "$DOTFILES_DIR/scripts/alacritty_wrapper.sh" "$HOME/.local/bin/alacritty"
}

install_platform_fonts() {
    local font_dir="$HOME/.local/share/fonts"

    copy_fonts_to_dir "$font_dir"

    if command -v fc-cache > /dev/null 2>&1; then
        echo "  -> Refreshing font cache"
        fc-cache -f "$font_dir"
    fi
}

configure_platform_defaults() {
    if command -v gsettings > /dev/null 2>&1; then
        echo "  -> Setting Alacritty as the default terminal"
        gsettings set org.gnome.desktop.default-applications.terminal exec "$HOME/.local/bin/alacritty" || true
        gsettings set org.gnome.desktop.default-applications.terminal exec-arg '-e' || true
    fi
}
