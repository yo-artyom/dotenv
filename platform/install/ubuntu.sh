#!/bin/bash

install_optional_apt_package() {
    local package_name="$1"

    if apt-cache show "$package_name" > /dev/null 2>&1; then
        sudo apt-get install -y "$package_name"
    else
        echo "  ! $package_name is not available via apt. Skipping..."
    fi
}

install_platform_packages() {
    local packages=(
        ack
        bat
        curl
        fzf
        git
        jq
        libxkbcommon-x11-0
        neovim
        tmux
        wl-clipboard
        xclip
        zsh
    )

    echo -e "\n\t[APT deps]\n"
    sudo apt-get update
    sudo apt-get install -y "${packages[@]}"

    install_optional_apt_package alacritty
    install_optional_apt_package git-extras
    install_optional_apt_package lsd
    install_optional_apt_package lua5.4
    install_optional_apt_package xsel

    if ! command -v mise > /dev/null 2>&1; then
        echo -e "\n\t[Mise install]\n"
        curl https://mise.run | sh
    else
        echo "mise already installed. Skipping..."
    fi
}
