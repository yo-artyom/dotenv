#!/bin/bash

platform_link_overlays() {
    link_file "$DOTFILES_DIR/zsh/platform/macos.zsh" "$HOME/.config/dotenv/zsh-platform.zsh"
    link_file "$DOTFILES_DIR/tmux/platform/macos.conf" "$HOME/.config/dotenv/tmux-platform.conf"
    link_file "$DOTFILES_DIR/alacritty/platform/macos.toml" "$HOME/.config/dotenv/alacritty-platform.toml"
}

install_platform_fonts() {
    copy_fonts_to_dir "$HOME/Library/Fonts"
}

configure_platform_defaults() {
    :
}
